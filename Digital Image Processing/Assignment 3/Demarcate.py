import sys
import cv2 as cv
import numpy as np

def compute_relative_demarcate_size(max_component):
    # decide what is the demarcate size depends on the max component size (letter size and demarcation needs to be relative to each other)
    demarcate_size = 0
    if (max_component >= 250):
        demarcate_size = 0.16
    elif (max_component >= 150):
        demarcate_size = 0.153
    elif (max_component >= 120):
        demarcate_size = 0.135
    else:
        demarcate_size = 0.128
    return demarcate_size

def write_img_without_demarcation(edited_img, max_component, demarcate_size, labels, components, sizes):
    for i in range(0, components - 1):
        # check if the relative between the component to the max component is larger than the demarcate size we compute before, if so - the component (letter) is colored in black
        if (sizes[i] / max_component) >= demarcate_size:
            edited_img[labels == i + 1] = 0
    return edited_img

def remove_demarcation(img):
    # convert image to binary
    ret, threshold_file = cv.threshold(img, 127, 255, cv.THRESH_BINARY_INV)
    # get stats of components in image, so we can get information on the sizes of the components (letters and demarcation)
    components, labels, stats, centroids = cv.connectedComponentsWithStats(threshold_file, connectivity=8)
    sizes = stats[1:, -1]
    edited_img = np.ones((labels.shape))

    # find the max component in the image for computing the difference between the letters and the demarcation in the image
    max_component = 0
    # just iterates over the sizes and gets the maximum size component 
    for i in range(0, components - 1):
        if sizes[i] >= max_component:
            max_component = sizes[i]

    # computing what is the minimal bound which is enough size for letter, depends on max component (max letter size)
    demarcate_size = compute_relative_demarcate_size(max_component)

    # write image without demarcation
    edited_img = write_img_without_demarcation(edited_img, max_component, demarcate_size, labels, components, sizes)
    return edited_img


# to run the program type: python .\Demarcate.py in_image out_image
def main(): 
    # reads input from user:
    img_file_name = sys.argv[1]     # reads input - name of image file
    output_filename = sys.argv[2]        # reads input - name of output file

    # loading original image
    img = cv.imread(img_file_name, cv.IMREAD_GRAYSCALE)        

    # check if image file name is valid (if file is exist)
    if img is None:
        sys.exit("Illegal image file")

    # displays the original image
    cv.namedWindow("Original image", cv.WINDOW_NORMAL)
    cv.imshow("Original image", img)

    # function that remove the demarcation from the input image
    edited_img = remove_demarcation(img)

    # save image without demarcation to output image
    cv.imwrite("./" + output_filename + ".jpg", (255*edited_img))
    
    # displays the output image without the demarcation
    cv.namedWindow("Image without the demarcation", cv.WINDOW_NORMAL)
    cv.imshow("Image without the demarcation", edited_img)

    cv.waitKey()

if __name__=="__main__":
    main()