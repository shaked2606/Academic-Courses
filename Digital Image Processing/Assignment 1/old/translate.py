import sys
import cv2 as cv
import numpy as np
import math
from numpy.linalg import inv

def translate_to_nearest(location):
    x = round(int(location[0]))
    y = round(int(location[1]))
    return [x, y]

#def translate_to_bilinear(img_file, tran):


#def translate_to_cubic(img_file, tran):

def tranform_the_image(img_file, new_img_file, matrix, rows, cols, quality):
    for row in range(rows):
        for col in range(cols):
            pixel_old_location = [row, col, 1]
            pixel_new_location = np.matmul(matrix, pixel_old_location)          # multiply tranformation matrix with the vector of the pixel location

            # checks which of the quality the user wants
            if quality == 'N':
                pixel_new_location = translate_to_nearest(pixel_new_location)
           # elif quality == 'B':
           #     translate_to_bilinear(img_file, tran)
           # elif quality == 'C':
           #     translate_to_cubic(img_file, tran)
            else:
                sys.exit("Illegal input")

            x = pixel_new_location[0]
            y = pixel_new_location[1]
            new_img_file[row][col] = img_file[x][y]

def multiplicate_matrices_and_inverse(trans_file):
    matrix = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    file = open(trans_file, 'r')
    lines = file.readlines()
    file.close()
    for line in lines:
        line = line.split(' ')
        if line[0] == 'S':
            matrix = np.matmul(matrix, [[int(line[1]), 0, 0], [0, int(line[2]), 0], [0, 0, 1]])
            print(matrix)
        elif line[0] == 'R':
            matrix = np.matmul(matrix, [[math.cos(int(line[1])), math.sin(int(line[1])), 0], [-math.sin(int(line[1])), math.cos(int(line[1])), 0], [0, 0, 1]])
            print(matrix)
        elif line[0] == 'T':
            matrix = np.matmul(matrix, [[1, 0, 0], [0, 1, 0], [int(line[1]), int(line[2]), 1]])
            print(matrix)
        else:
            sys.exit("Illegal transformation file")

    matrix = inv(matrix)
    print(matrix)
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
    rows_n, cols_n = new_img_file.shape                               # assigning rows and cols of new image
    rows_o, cols_o = img_file.shape                                   # assigning rows and cols of original image


    # show the image before manipulating
    cv.namedWindow("Before", cv.WINDOW_NORMAL)
    cv.imshow("Before", img_file)

    matrix = multiplicate_matrices_and_inverse(trans_file)                          # multiplication and inverse the transformation matrix

    tranform_the_image(img_file, new_img_file, matrix, rows_n, cols_n, quality)

    # show the image after manipulating
    cv.namedWindow("After", cv.WINDOW_NORMAL)
    cv.imshow("After", new_img_file)
    cv.waitKey()

if __name__=="__main__": 
    main() 