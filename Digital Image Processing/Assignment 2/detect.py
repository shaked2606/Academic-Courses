import sys
import cv2 as cv
import math
import numpy as np

def detect_lines(img_file, threshold_img, output_filename):
    # limits of threshold image
    width, height = threshold_img.shape

    # initiliazes array of angles between -90 to 90 degrees and converts to radians
    thetas_arr = np.deg2rad(np.arange(-90.0, 90.0))

    # computes the maximum diagonal (depends on image limits)
    diagonal = np.ceil(np.sqrt(pow(width, 2) + pow(height, 2)))

    # initiliazes array of possible range of diagonal - between minus diagonal len to plus diagonal len
    rhos_arr = np.linspace(int(-diagonal), int(diagonal), int(diagonal * 2))

    # initiliazes array of cos(theta)
    cos_t = np.cos(thetas_arr)
    # initiliazes array of sin(theta)
    sin_t = np.sin(thetas_arr)

    # computes length of arrays of angles and rhos
    num_thetas = len(thetas_arr)
    num_rhos = 2 * diagonal

    # initiliazes accumulator array that will counts lines occurences depends on threshold image
    accumulator = np.zeros((int(num_rhos), int(num_thetas)))

    # initiliazes arrays of x and y coordinates of white points in the threshold image
    y_white_pts, x_white_pts = np.nonzero(threshold_img) 
    num_white_pts = len(x_white_pts)

    # iterates over white points and computes all lines 
    for i in range(len(x_white_pts)):
        x = x_white_pts[i]
        y = y_white_pts[i]

        for t in range(int(num_thetas)):
            cos_x = x * cos_t[t]
            sin_y = y * sin_t[t]
            # computes vertical to the line from the (0, 0)
            rho = round(cos_x + sin_y) + diagonal
            accumulator[int(rho), int(t)] += 1

    # opening output file for writing the results
    output_file = open(output_filename, "w+")

    # saves global max value of accumulator for peeking relevent lines
    global_max_ind = np.unravel_index(np.argmax(accumulator, axis=None), accumulator.shape)
    r = global_max_ind[0]
    t = global_max_ind[1]
    global_max_val = accumulator[r][t]
    accumulator[r][t] = 0
    num_lines = 0

    # iterates over current maximum of the acc array, and checks if it above 75% of the global maximum value
    while True:
        temp_max_ind = np.unravel_index(np.argmax(accumulator, axis=None), accumulator.shape)
        r = temp_max_ind[0]
        t = temp_max_ind[1]
        temp_max_val = accumulator[r][t]
        # A line hypothesis with less than 1% of the edge points is not valid line
        if (temp_max_val >= 0.01 * num_white_pts) and (temp_max_val >= 0.75 * global_max_val):
            accumulator[r][t] = 0
            rho = rhos_arr[int(r)]
            theta = thetas_arr[int(t)]
            cos_t = np.cos(theta)
            sin_t = np.sin(theta)

            # initiliaze min and max of x and y for searching the start point and end point
            min_x = height
            min_y = width
            max_x = 0
            max_y = 0

            # initiliaze 2 points that will represent the line start point and end point
            x1 = 0
            y1 = 0
            x2 = 0
            y2 = 0

            # searching for start point and end point of the line by finding max and min value of x
            # if line has infinite slope, we need to save min and max value of y either to save properly the right start and end points (if not we will lose one point because the x's are equal)
            for i in range(len(x_white_pts)):
                x = x_white_pts[i]
                y = y_white_pts[i]
                # checks if point is on the line
                if int(rho) == int(x * cos_t + y * sin_t):
                    if min_x > x:
                        min_x = x
                        x1 = min_x
                        y1 = y
                    if max_x < x:
                        max_x = x
                        x2 = max_x
                        y2 = y
                    if min_y > y:
                        min_y = y
                    if max_y < y:
                        max_y = y

            # checks if there are lines that coincide with this line:
            infinite_slope_case = False
            dist_flag = False
            infinite_slope_case, dist_flag, offset_in_file = check_for_coincide_lines(output_file, max_x, min_x, min_y, max_y, x1, y1, x2, y2, infinite_slope_case, dist_flag)
            
            # no other line is coincide:
            num_lines = draw_line(infinite_slope_case, dist_flag, img_file, min_x, min_y, max_y, output_file, offset_in_file, x1, y1, x2, y2, num_lines)
        else:
            break

    return output_file, num_lines

def draw_line(infinite_slope_case, dist_flag, img_file, min_x, min_y, max_y, output_file, offset_in_file, x1, y1, x2, y2, num_lines):
    if infinite_slope_case and not dist_flag:
        num_lines +=1
        cv.line(img_file, (min_x, min_y),(min_x, max_y), (0, 255, 0), 2)
        output_file.seek(offset_in_file)
        output_file.write("%d %d %d %d\n" %(min_x, min_y, min_x, max_y))
    if not infinite_slope_case and not dist_flag:
        num_lines +=1
        cv.line(img_file, (x1, y1),(x2, y2), (0, 255, 0), 2)
        output_file.seek(offset_in_file)
        output_file.write("%d %d %d %d\n" %(x1, y1, x2, y2))
    return num_lines

def check_for_coincide_lines(output_file, max_x, min_x, min_y, max_y, x1, y1, x2, y2, infinite_slope_case, dist_flag):
    offset_in_file = output_file.tell()
    output_file.seek(0)
    lines = output_file.readlines()
    # go over all lines in file, and checks if there aer lines that coincide with this line (start and end points of the line)
    for line in lines:
        stripped_line = line.strip().split()
        x1_line = int(stripped_line[0])
        y1_line = int(stripped_line[1])
        x2_line = int(stripped_line[2])
        y2_line = int(stripped_line[3])

        if max_x == min_x:
            dist1 = math.sqrt((x1_line - min_x) ** 2 + (y1_line - min_y) ** 2)  # euclidean distance
            dist2 = math.sqrt((x1_line - min_x) ** 2 + (y1_line - max_y) ** 2)
            dist3 = math.sqrt((x2_line - min_x) ** 2 + (y2_line - min_y) ** 2)
            dist4 = math.sqrt((x2_line - min_x) ** 2 + (y2_line - max_y) ** 2)
            # Any two different lines or circles may intersect, but not coincide (they should be at least five pixels apart)
            if dist1 < 5.0 and dist2 < 5.0 and dist3 < 5.0 and dist4 < 5.0:
                infinite_slope_case = True
                dist_flag = True
                break

        else: # for lines with finite slope - draw line and write the start and end point to output file
            dist1 = math.sqrt((x1_line - x1) ** 2 + (y1_line - y1) ** 2) # euclidean distance
            dist2 = math.sqrt((x1_line - x2) ** 2 + (y1_line - y2) ** 2)
            dist3 = math.sqrt((x2_line - x1) ** 2 + (y2_line - y1) ** 2)
            dist4 = math.sqrt((x2_line - x2) ** 2 + (y2_line - y2) ** 2)
            # Any two different lines or circles may intersect, but not coincide (they should be at least five pixels apart)
            if (dist1 < 5.0 and dist2 < 5.0) or (dist3 < 5.0 and dist4 < 5.0):
                dist_flag = True
                break
    return infinite_slope_case, dist_flag, offset_in_file


def detect_circles(img_file, threshold_img, output_file):
    offset_of_end_of_lines_in_file = output_file.tell()
    # limits of threshold image
    width, height = threshold_img.shape

    # computes max radius depends on limits of the image
    max_radius = math.floor(min(width, height) / 2)

    # initiliazes array of angles
    thetas_arr = np.deg2rad(np.arange(0.0, 360.0))
    # initiliazes array of cos(t)
    cos_t = np.cos(thetas_arr)
    # initiliazes array of sin(t)
    sin_t = np.sin(thetas_arr)
    # computes len of  angles array
    num_thetas = len(thetas_arr)

    # initiliazes array of accumulator of (a, b, r)
    accumulator = np.zeros((int(height), int(width), int(max_radius)))

    y_white_pts, x_white_pts = np.nonzero(threshold_img)  # (row, col) indexes to edges
    num_white_pts = len(x_white_pts)
    # iterates over white points and detect circles that the white point is on perimeter
    for i in range(len(x_white_pts)):
        x = x_white_pts[i]
        y = y_white_pts[i]

        for ir in range(1, int(max_radius)):
            for it in range(num_thetas):
                # computes center of circle
                a = int(math.floor(x - ir * cos_t[it]))
                b = int(math.floor(y - ir * sin_t[it]))
                left = [a - ir, b]
                right = [a + ir, b]
                top = [a, b + ir]
                bottom = [a, b - ir]

                # checks if circle is inside the image
                if left[1] >= 0 and right[1] < width and top[0] >= 0 and bottom[0] < height:
                    accumulator[a][b][ir] += 1

    # get the global max value of the acc array for peeking relevant circles
    global_max_ind = np.unravel_index(np.argmax(accumulator, axis=None), accumulator.shape)
    a = global_max_ind[0]
    b = global_max_ind[1]
    r = global_max_ind[2]
    global_max_val = accumulator[a][b][r]
    accumulator[a][b][r] = 0

    num_circles = 0

    # iterates over current maximum of the acc array, and checks if it above 75% of the global maximum value
    while True:
        temp_max_ind = np.unravel_index(np.argmax(accumulator, axis=None), accumulator.shape)
        a = temp_max_ind[0]
        b = temp_max_ind[1]
        r = temp_max_ind[2]
        temp_max_val = accumulator[a][b][r]
        # A valid circle should fall entirely within the image and secure the votes of at least 1% of the edge points
        if (temp_max_val >= 0.01 * num_white_pts) and (temp_max_val >= 0.75 * global_max_val):
            accumulator[a][b][r] = 0

            # Any two different lines or circles may intersect, but not coincide (they should be at least five pixels apart)
            dist_flag = False
            dist_flag, offset_in_file = check_for_coincide_circles(output_file, offset_of_end_of_lines_in_file, a, b, dist_flag)
            # no other circle is coincide
            if not dist_flag:
                num_circles = draw_circle_and_write_to_file(img_file, a, b, r, output_file, offset_in_file, num_circles)
        else:
            break
    return output_file, num_circles

def draw_circle_and_write_to_file(img_file, a, b, r, output_file, offset_in_file, num_circles):
    num_circles += 1
    # draw the circle on the original image
    cv.circle(img_file, (a, b), r, (0, 255, 0), 2)

    output_file.seek(offset_in_file)
    # calculating xi, yi, Ri and write it to output file
    output_file.write("%d %d %d\n" %(a, b, r))
    return num_circles

def check_for_coincide_circles(output_file, offset_of_end_of_lines_in_file, a, b, dist_flag):
    offset_in_file = output_file.tell()
    output_file.seek(offset_of_end_of_lines_in_file)
    lines = output_file.readlines()
    for line in lines:
        stripped_line = line.strip().split()
        a_line = int(stripped_line[0])
        b_line = int(stripped_line[1])
        dist = math.sqrt((a_line - a) ** 2 + (b_line - b) ** 2) # euclidean distance
        if dist < 5.0:
            dist_flag = True
    return dist_flag, offset_in_file

# to run the program type: python .\detect.py image output
def main(): 
    # reads input from user:
    img_file_name = sys.argv[1]     # reads input - name of image file
    output_filename = sys.argv[2]        # reads input - name of output file

    # loading original image
    img_file = cv.imread(img_file_name, cv.IMREAD_GRAYSCALE)        

    # check if image file name is valid (file is exist)
    if img_file is None:
        sys.exit("Illegal image file")

    # displays the original image (I)
    cv.namedWindow("Original image", cv.WINDOW_NORMAL)
    cv.imshow("Original image", img_file)

    # Apply edge detection filter (Sobel) on the image I to obtain a response image, R
    g_x = cv.Sobel(img_file, cv.CV_64F, 1, 0, ksize=3)
    g_y = cv.Sobel(img_file, cv.CV_64F, 0, 1, ksize=3)
    response_img = cv.addWeighted(cv.convertScaleAbs(g_x), 0.5, cv.convertScaleAbs(g_y), 0.5, 0)
    
    # Threshold the image R to convert it to binary image, B
    ret, threshold_img = cv.threshold(response_img, 100, 255, cv.THRESH_BINARY + cv.THRESH_OTSU)

    # displays the binary image (B)
    cv.namedWindow("Binary image", cv.WINDOW_NORMAL)
    cv.imshow("Binary image", threshold_img)

    # detects the lines and circles in the image B
    # writes output lines and circles to an output file
    # detect lines
    output_file, num_lines = detect_lines(img_file, threshold_img, output_filename)

    # detect circles
    output_file, num_circles = detect_circles(img_file, threshold_img, output_file)

    # opening output file for appending the num of lines and circles to the beginning of the file
    output_file.seek(0)
    lines = output_file.readlines()
    output_file.seek(0)
    output_file.write("%d %d\n" %(num_lines, num_circles))
    for line in lines:
        output_file.write(line)
    output_file.close()

    # displays the detected lines and circles on top of the original image
    cv.namedWindow("lines and circles on original image", cv.WINDOW_NORMAL)
    cv.imshow("lines and circles on original image", img_file)

    cv.waitKey()

if __name__=="__main__":
    main()