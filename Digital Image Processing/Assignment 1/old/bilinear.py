import sys
import cv2 as cv
import numpy as np
import math
from numpy.linalg import inv

def translate_to_nearest(location, img_file, rows, cols):
    x = round(float(location[0]))
    y = round(float(location[1]))
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

def translate_to_cubic(location, img_file):
    frac_x, whole_x = math.modf(float(location[0]))
    frac_y, whole_y = math.modf(float(location[1]))

    # computing constant distances
    d_0_25 = d_0_to_1(0.25)
    d_0_75 = d_0_to_1(0.75)
    d_1_25 = d_1_to_2(1.25)
    d_1_75 = d_1_to_2(1.75)

    cent_pixel_x = whole_x + 0.5
    cent_pixel_y = whole_y + 0.5

    if frac_x >= 0.5 and frac_y >= 0.5:       # point at top-right of pixel


    elif frac_x < 0.5 and frac_y >= 0.5:        # point at top-left of pixel
        distnace_matrix = [[d_1_75 * d_1_75 * img_file[whole_x - 2][whole_y + 2], d_0_75 * d_1_75 * img_file[whole_x - 1][whole_y + 2], d_0_25 * d_1_75 * img_file[whole_x][whole_y + 2], d_1_25 * d_1_75 * img_file[whole_x + 1][whole_y + 2]],
                           [d_1_75 * d_0_75 * img_file[whole_x - 2][whole_y + 1], d_0_75 * d_0_75 * img_file[whole_x - 1][whole_y + 1], d_0_25 * d_0_75 * img_file[whole_x][whole_y + 1], d_1_25 * d_1_75 * img_file[whole_x + 1][whole_y + 1]],
                           [d_1_75 * d_0_25 * img_file[whole_x - 2][whole_y], d_0_75 * d_0_25 * img_file[whole_x - 1][whole_y], d_0_25 * d_0_25 * img_file[whole_x][whole_y], d_1_25 * d_0_25] * img_file[whole_x + 1][whole_y],
                           [d_1_75 * d_1_25 * img_file[whole_x - 2][whole_y - 1], d_0_75 * d_1_25 * img_file[whole_x - 1][whole_y - 1], d_0_25 * d_1_25 * img_file[whole_x][whole_y - 1], d_1_25 * d_1_25 * img_file[whole_x + 1][whole_y - 1]]]
                        
    elif frac_x >= 0.5 and frac_y < 0.5:        # point at bottom-right of pixel
        distnace_matrix = [[d_1_25 * d_1_25 * img_file[whole_x - 1][whole_y + 1], d_0_25 * d_1_25 * img_file[whole_x][whole_y + 1], d_0_75 * d_1_25 * img_file[whole_x + 1][whole_y + 1], d_1_75 * d_1_25 * img_file[whole_x + 2][whole_y + 1]],
                           [d_1_25 * d_0_25 * img_file[whole_x - 1][whole_y], d_0_25 * d_0_25 * img_file[whole_x][whole_y], d_0_75 * d_0_25 * img_file[whole_x + 1][whole_y], d_1_75 * d_0_25 * img_file[whole_x + 2][whole_y]],
                           [d_1_25 * d_0_75 * img_file[whole_x - 1][whole_y - 1], d_0_25 * d_0_75 * img_file[whole_x][whole_y - 1], d_0_75 * d_0_75 * img_file[whole_x + 1][whole_y - 1], d_1_75 * d_0_75 * img_file[whole_x + 2][whole_y - 1]],
                           [d_1_25 * d_1_75 * img_file[whole_x - 1][whole_y - 2], d_0_25 * d_1_75 * img_file[whole_x][whole_y - 2], d_0_75 * d_1_75 * img_file[whole_x + 1][whole_y - 2], d_1_75 * d_1_75 * img_file[whole_x + 2][whole_y - 2]]]


    else frac_x < 0.5 and frac_y < 0.5:         # point at bottom-left of pixel              


def d_0_to_1(d):
    return 1.5 * pow(abs(d), 3) - 2.5 * pow(abs(d), 2) + 1

def d_1_to_2(d):
    return -0.5 * pow(abs(d), 3) + 2.5 * pow(abs(d), 2) -4 * d + 2



def tranform_the_image(img_file, new_img_file, matrix, rows, cols, quality):
    for row in range(rows):
        for col in range(cols):
            pixel_old_location = [row, col, 1]
            pixel_new_location = np.matmul(matrix, pixel_old_location)          # multiply tranformation matrix with the vector of the pixel location
            # checks which of the quality the user wants
            if quality == 'N':
                pixel_value = translate_to_nearest(pixel_new_location, img_file, rows ,cols)

            elif quality == 'B':
                pixel_value = translate_to_bilinear(pixel_new_location, img_file)

            elif quality == 'C':
                pixel_value = translate_to_cubic(pixel_new_location, img_file)

            else:
                sys.exit("Illegal input")
            new_img_file[row][col] = pixel_value


def multiplicate_matrices_and_inverse(trans_file, rows, cols):
    matrix = [[1, 0, 0],
              [0, 1, 0],
              [0, 0, 1]]                  # init In matrix for the multiplications 

    x_center = round(rows/2)                                    # x axis for center of the image
    y_center = round(cols/2)                                    # y axis for center of the image

    move_to_0_0_coordinates = [[1, 0, float(-x_center)],
                               [0, 1, float(-y_center)],
                               [0, 0, 1]]    # translation for moving to 0,0 coordinates

    back_to_middle = [[1, 0, float(x_center)],
                      [0, 1, float(y_center)],
                      [0, 0, 1]]               # translation for moving back to center

    file = open(trans_file, 'r')
    lines = file.readlines()                                    # read lines fron transformation file
    file.close()

    for line in lines:                                          # creates transformation matrix by multiplicating all transfromations
        line = line.split(' ')
        if line[0] == 'S':
            matrix = np.matmul(move_to_0_0_coordinates, matrix)          # moving to 0,0 coordinates
            matrix = np.matmul([[float(line[1]), 0, 0],
                                [0, float(line[2]), 0], 
                                [0, 0, 1]],
                                matrix) # scailing the image
            matrix = np.matmul(back_to_middle, matrix)                   # moving back to center

        elif line[0] == 'R':
            angle = line[1]
            matrix = np.matmul(move_to_0_0_coordinates, matrix)          # moving to 0,0 coordinates
            matrix = np.matmul([[math.cos(float(angle)), -math.sin(float(angle)), 0],
                                [math.sin(float(angle)), math.cos(float(angle)), 0],
                                [0, 0, 1]],
                                matrix)  # rotating the image
            matrix = np.matmul(back_to_middle, matrix)                   # moving back to center

        elif line[0] == 'T':
            matrix = np.matmul([[1, 0, float(line[1])],
                                [0, 1, float(line[2])],
                                [0, 0, 1]],
                                matrix)     # translating the image
        else:
            sys.exit("Illegal transformation file")

    matrix = inv(matrix)                                        # do the inverse to the transformation matrix  
    return matrix

def main(): 
    # reads input from user:
    img_file_name = sys.argv[1]     # reads input - name of image file
    trans_file = sys.argv[2]        # reads input - name of transformation file
    quality = sys.argv[3]           # reads input - char of quality - N, B or C

    # TODO:needs to check if input is legal

    # loading files
    img_file = cv.imread(img_file_name, cv.IMREAD_GRAYSCALE)          # loading original image
    cv.imwrite('./new_image.jpg', img_file)                           # saving new file of image
    new_img_file = cv.imread('new_image.jpg', cv.IMREAD_GRAYSCALE)    # loading new image
    rows, cols = new_img_file.shape                               # assigning rows and cols of new image


    # show the image before manipulating
    cv.namedWindow("Before", cv.WINDOW_NORMAL)
    cv.imshow("Before", img_file)

    matrix = multiplicate_matrices_and_inverse(trans_file, rows, cols)                          # multiplication and inverse the transformation matrix

    tranform_the_image(img_file, new_img_file, matrix, rows, cols, quality)

    # show the image after manipulating
    cv.namedWindow("After", cv.WINDOW_NORMAL)
    cv.imshow("After", new_img_file)
    cv.waitKey()

if __name__=="__main__": 
    main() 