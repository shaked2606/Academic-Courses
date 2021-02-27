import sys
import cv2 as cv
import numpy as np
import math
from numpy.linalg import inv

def translate_to_nearest(location, img_file):
    x = round(float(location[0]))
    y = round(float(location[1]))

    rows, cols = img_file.shape

    if x < 0 or y < 0 or x >= rows or y >= cols:
        return 0
    return img_file[x, y]

def translate_to_bilinear(location, img_file):
    x = float(location[0])
    y = float(location[1])

    rows, cols = img_file.shape

    tl_x = math.floor(x)
    tl_y = math.ceil(y)

    tr_x = math.ceil(x)
    tr_y = math.ceil(y)

    x_distance = (x - tl_x)

    if tl_x < 0 or tl_y < 0 or tl_x >= rows or tl_y >= cols or tr_x < 0 or tr_y < 0 or tr_x >= rows or tr_y >= cols:
        return 0
    t_value = (1-x_distance)*(img_file[tl_x][tl_y]) + (x_distance)*(img_file[tr_x][tr_y])

    bl_x = math.floor(x)
    bl_y = math.floor(y)

    br_x = math.ceil(x)
    br_y = math.floor(y)

    if tl_x < 0 or bl_y < 0 or bl_x >= rows or bl_y >= cols or br_x < 0 or br_y < 0 or br_x >= rows or br_y >= cols:
        return 0

    b_value = (1-x_distance)*(img_file[bl_x][bl_y]) + (x_distance)*(img_file[br_x][br_y])

    y_distance = (y - bl_y)
    curr_value = (1-y_distance)*(b_value) + (y_distance)*(t_value)
    return curr_value


def get_color(img_file, x, y):
    try:
        return img_file[x, y]
    except:
        return 0


def translate_to_cubic(location, img_file):
    frac_x, whole_x = math.modf(float(location[0]))
    frac_y, whole_y = math.modf(float(location[1]))

    rows, cols = img_file.shape

    whole_x = int(whole_x)
    whole_y = int(whole_y)

    if whole_x < 0 or whole_x >= rows or whole_y < 0 or whole_y >= cols:
        return 0

    # computing constant distances
    d_0_25 = d_0_to_1(0.25)
    d_0_75 = d_0_to_1(0.75)
    d_1_25 = d_1_to_2(1.25)
    d_1_75 = d_1_to_2(1.75)

    if frac_x >= 0.5 and frac_y >= 0.5:       # point at top-right of pixel
        distance_matrix = [[d_1_25 * d_1_75 * get_color(img_file, whole_x - 1,whole_y + 2), d_0_25 * d_1_75 * get_color(img_file, whole_x, whole_y + 2), d_0_75 * d_1_75 * get_color(img_file, whole_x + 1, whole_y + 2), d_1_75 * d_1_75 * get_color(img_file, whole_x + 2, whole_y + 2)],
                           [d_1_25 * d_0_75 * get_color(img_file, whole_x - 1, whole_y + 1), d_0_25 * d_0_75 * get_color(img_file, whole_x, whole_y + 1), d_0_75 * d_0_75 * get_color(img_file, whole_x + 1, whole_y + 1), d_1_75 * d_0_75 * get_color(img_file, whole_x + 2, whole_y + 1)],
                           [d_1_25 * d_0_25 * get_color(img_file, whole_x - 1, whole_y), d_0_25 * d_0_25 * get_color(img_file, whole_x, whole_y), d_0_75 * d_0_25 * get_color(img_file, whole_x + 1, whole_y), d_1_75 * d_0_25 * get_color(img_file, whole_x + 2, whole_y)],
                           [d_1_25 * d_1_25 * get_color(img_file, whole_x - 1, whole_y - 1), d_0_25 * d_1_25 * get_color(img_file, whole_x, whole_y - 1), d_0_75 * d_1_25 * get_color(img_file, whole_x + 1, whole_y - 1), d_1_75 * d_1_25 * get_color(img_file, whole_x + 2, whole_y - 1)]]

    elif frac_x < 0.5 and frac_y >= 0.5:        # point at top-left of pixel
        distance_matrix = [[d_1_75 * d_1_75 * get_color(img_file, whole_x - 2, whole_y + 2), d_0_75 * d_1_75 * get_color(img_file, whole_x - 1, whole_y + 2), d_0_25 * d_1_75 * get_color(img_file, whole_x, whole_y + 2), d_1_25 * d_1_75 * get_color(img_file, whole_x + 1, whole_y + 2)],
                           [d_1_75 * d_0_75 * get_color(img_file, whole_x - 2, whole_y + 1), d_0_75 * d_0_75 * get_color(img_file, whole_x - 1, whole_y + 1), d_0_25 * d_0_75 * get_color(img_file, whole_x, whole_y + 1), d_1_25 * d_0_75 * get_color(img_file, whole_x + 1, whole_y + 1)],
                           [d_1_75 * d_0_25 * get_color(img_file, whole_x - 2, whole_y), d_0_75 * d_0_25 * get_color(img_file, whole_x - 1, whole_y), d_0_25 * d_0_25 * get_color(img_file, whole_x, whole_y), d_1_25 * d_0_25 * get_color(img_file, whole_x + 1, whole_y)],
                           [d_1_75 * d_1_25 * get_color(img_file, whole_x - 2, whole_y - 1), d_0_75 * d_1_25 * get_color(img_file, whole_x - 1, whole_y - 1), d_0_25 * d_1_25 * get_color(img_file, whole_x, whole_y - 1), d_1_25 * d_1_25 * get_color(img_file, whole_x + 1, whole_y - 1)]]
                        
    elif frac_x >= 0.5 and frac_y < 0.5:        # point at bottom-right of pixel
        distance_matrix = [[d_1_25 * d_1_25 * get_color(img_file, whole_x - 1, whole_y + 1), d_0_25 * d_1_25 * get_color(img_file, whole_x, whole_y + 1), d_0_75 * d_1_25 * get_color(img_file, whole_x + 1, whole_y + 1), d_1_75 * d_1_25 * get_color(img_file, whole_x + 2, whole_y + 1)],
                           [d_1_25 * d_0_25 * get_color(img_file, whole_x - 1, whole_y), d_0_25 * d_0_25 * get_color(img_file, whole_x, whole_y), d_0_75 * d_0_25 * get_color(img_file, whole_x + 1, whole_y), d_1_75 * d_0_25 * get_color(img_file, whole_x + 2, whole_y)],
                           [d_1_25 * d_0_75 * get_color(img_file, whole_x - 1, whole_y - 1), d_0_25 * d_0_75 * get_color(img_file, whole_x, whole_y - 1), d_0_75 * d_0_75 * get_color(img_file, whole_x + 1, whole_y - 1), d_1_75 * d_0_75 * get_color(img_file, whole_x + 2, whole_y - 1)],
                           [d_1_25 * d_1_75 * get_color(img_file, whole_x - 1, whole_y - 2), d_0_25 * d_1_75 * get_color(img_file, whole_x, whole_y - 2), d_0_75 * d_1_75 * get_color(img_file, whole_x + 1, whole_y - 2), d_1_75 * d_1_75 * get_color(img_file, whole_x + 2, whole_y - 2)]]


    elif frac_x < 0.5 and frac_y < 0.5:         # point at bottom-left of pixel              
        distance_matrix = [[d_1_75 * d_1_25 * get_color(img_file, whole_x - 2, whole_y + 1), d_0_75 * d_1_25 * get_color(img_file, whole_x - 1, whole_y + 1), d_0_25 * d_1_25 * get_color(img_file, whole_x, whole_y + 1), d_1_25 * d_1_25 * get_color(img_file, whole_x + 1, whole_y + 1)],
                           [d_1_75 * d_0_25 * get_color(img_file, whole_x - 2, whole_y), d_0_75 * d_0_25 * get_color(img_file, whole_x - 1, whole_y), d_0_25 * d_0_25 * get_color(img_file, whole_x, whole_y), d_1_25 * d_0_25 * get_color(img_file, whole_x + 1, whole_y)],
                           [d_1_75 * d_0_75 * get_color(img_file, whole_x - 2, whole_y - 1), d_0_75 * d_0_75 * get_color(img_file, whole_x - 1, whole_y - 1), d_0_25 * d_0_75 * get_color(img_file, whole_x, whole_y - 1), d_1_25 * d_0_75 * get_color(img_file, whole_x + 1, whole_y - 1)],
                           [d_1_75 * d_1_75 * get_color(img_file, whole_x - 2, whole_y - 2), d_0_75 * d_1_75 * get_color(img_file, whole_x - 1, whole_y - 2), d_0_25 * d_1_75 * get_color(img_file, whole_x, whole_y - 2), d_1_25 * d_1_75 * get_color(img_file, whole_x + 1, whole_y - 2)]]
    pixel_value = 0
    for i in range(0, 4):
        for j in range(0, 4):
            pixel_value += distance_matrix[i][j]
    
    return max(min(pixel_value, 255), 0)
    #NOTE: pixel value is returned wrapped with the min and max functions below in order to handle random black\white pixels that appeared in the new picture


def d_0_to_1(d):
    return 1.5 * pow(abs(d), 3) - 2.5 * pow(abs(d), 2) + 1

def d_1_to_2(d):
    return -0.5 * pow(abs(d), 3) + 2.5 * pow(abs(d), 2) -4 * abs(d) + 2

def tranform_the_image(img_file, matrix, rows, cols, quality):
    new_img_file = np.zeros((rows, cols), dtype=int)
    for row in range(rows):
        for col in range(cols):
            pixel_new_img = [row, col, 1]
            pixel_old_img_location = np.matmul(matrix, pixel_new_img)          # multiply tranformation matrix with the vector of the pixel location
            # checks which of the quality the user wants
            if quality == 'N':
                pixel_value = translate_to_nearest(pixel_old_img_location, img_file)

            elif quality == 'B':
                pixel_value = translate_to_bilinear(pixel_old_img_location, img_file)

            elif quality == 'C':
                pixel_value = translate_to_cubic(pixel_old_img_location, img_file)

            else:
                sys.exit("Illegal input")

            new_img_file[row][col] = int(pixel_value)
    return new_img_file


def multiplicate_matrices(trans_file, rows, cols):
    matrix = [[1, 0, 0],
              [0, 1, 0],
              [0, 0, 1]]                  # init In matrix for the multiplications 

    file = open(trans_file, 'r')
    lines = file.readlines()              # read lines fron transformation file
    file.close()

    for line in lines:                    # creates transformation matrix by multiplicating all transfromations
        line = line.split(' ')
        if line[0] == 'S':  # scailing
            matrix = np.matmul([[float(line[1]), 0, 0],
                                [0, float(line[2]), 0], 
                                [0, 0, 1]],
                                matrix) # scailing the image
        elif line[0] == 'R':  # rotation
            angle = line[1]
            angle = math.radians(int(angle))
            matrix = np.matmul([[math.cos(angle), -math.sin(angle), 0],
                                [math.sin(angle), math.cos(angle), 0],
                                [0, 0, 1]],
                                matrix)  # rotating the image
        elif line[0] == 'T':   # transition
            matrix = np.matmul([[1, 0, float(line[1])],
                                [0, 1, float(line[2])],
                                [0, 0, 1]],
                                matrix)     # translating the image
        #NOTE: the act of moving the beginning of our picture to the 0,0 coordinates causes a picture with T transformation to display as if nothing happened.

        else:
            sys.exit("Illegal transformation file")
     
    return matrix

# taking the edges of the original image and computing the size of the new image after transformation
def computing_size_of_new_image(matrix, rows, cols):
    tl_new_image = np.matmul(matrix, [0, 0, 1])
    tr_new_image = np.matmul(matrix, [0, cols - 1, 1])
    bl_new_image = np.matmul(matrix, [rows - 1, 0, 1])
    br_new_image = np.matmul(matrix, [rows - 1, cols - 1, 1])


    min_x = min(tl_new_image[0], tr_new_image[0], bl_new_image[0], br_new_image[0])
    max_x = max(tl_new_image[0], tr_new_image[0], bl_new_image[0], br_new_image[0])

    min_y = min(tl_new_image[1], tr_new_image[1], bl_new_image[1], br_new_image[1])
    max_y = max(tl_new_image[1], tr_new_image[1], bl_new_image[1], br_new_image[1])

    cols = int(max_y - min_y)
    rows = int(max_x - min_x)

    return [rows, cols, min_x, min_y]

    # NOTE: for running using the Terminal (Windows): python .\translate.py image tran quality
def main(): 
    # reads input from user:
    img_file_name = sys.argv[1]     # reads input - name of image file
    trans_file = sys.argv[2]        # reads input - name of transformation file
    quality = sys.argv[3]           # reads input - char of quality - N, B or C

    # loading image
    img_file = cv.imread(img_file_name, cv.IMREAD_GRAYSCALE)          # loading original image

    # check if image file name is valid
    if img_file is None:
        sys.exit("Illegal image file")

    rows_original, cols_original = img_file.shape                     # assigning rows and cols of new image

    # show the image before manipulating
    cv.namedWindow("Before", cv.WINDOW_NORMAL)
    cv.imshow("Before", img_file)

    matrix = multiplicate_matrices(trans_file, rows_original, cols_original)                                           # multiplication and inverse the transformation matrix

    rows_new, cols_new, min_x, min_y = computing_size_of_new_image(matrix, rows_original, cols_original)               # computing size of new image after transformation

    move_to_0_0_coordinates = [[1, 0, -min_x],
                               [0, 1, -min_y],
                               [0, 0, 1]]                          # translation for moving to 0,0 coordinates
    matrix = np.matmul(move_to_0_0_coordinates, matrix)            # moving to 0,0 coordinates
    #NOTE: the act of moving the beginning of our picture to the 0,0 coordinates causes a picture with T transformation to display as if nothing happened.

    # printing the size of the new image after transformation
    print("Size of the new image after transformation:")
    print(rows_new)
    print(cols_new)

    matrix = inv(matrix)                                           # do the inverse to the transformation matrix 

    new_img_file = tranform_the_image(img_file, matrix, rows_new, cols_new, quality)
    
    # saving the image to file
    cv.imwrite('./new_image.jpg', new_img_file) 
    new_img_file = cv.imread('new_image.jpg', cv.IMREAD_GRAYSCALE) 

    # show the image after manipulating
    cv.imshow("After", new_img_file)
    cv.waitKey()

if __name__=="__main__": 
    main() 