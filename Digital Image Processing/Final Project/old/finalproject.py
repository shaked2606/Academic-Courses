import sys
import numpy as np
import cv2 as cv
import imutils

def stitch(img1, img2):
    ratio = 0.75
    # reprojThresh = the maximum pixel allowed by the RANSAC algorithm
    reprojThresh = 4.0

    # finding keypoints in the images and extracting local invariant descriptors from them
    (key_points1, descriptors1) = findAndExtract(img1)
    (key_points2, descriptors2) = findAndExtract(img2)

    # matching the descriptors between the two images (img1, img2)
    matches_bundle = matching(key_points1, key_points2, descriptors1,
                              descriptors2, ratio, reprojThresh)

    # not enough matched keypoints to create a panorama
    if matches_bundle is None:
        # meaning this is a torn image, stitching it together
        output_img = cv.hconcat([img2, img1])

    # we found matched keypoints to create a panorama so we apply a perspective warp to stitch the images together
    else:
        (matches, hom_matrix, mask) = matches_bundle
        arr = np.array([[0, 0], [img1.shape[1], 0], [0, img1.shape[0]], [
            img1.shape[1], img1.shape[0]]], dtype='float32')
        arr = np.array([arr])

        # performs the perspective matrix transformation of vectors
        transformed = cv.perspectiveTransform(arr, hom_matrix)
        spot = max(abs(img1.shape[1] - transformed[0][1][0]),
                   abs(img1.shape[1] - transformed[0][3][0]))
        spot = spot - (img2.shape[1] - img1.shape[1])
        while img1.shape[1] + img2.shape[1] - int(spot) < img2.shape[1]:
            spot = spot / 2

        # transforming the image using the homography matrix
        output_img = cv.warpPerspective(img1, hom_matrix,
                                        (img1.shape[1] + img2.shape[1] - int(spot), img1.shape[0]))
        output_img[0:img2.shape[0], 0:img2.shape[1]] = img2

    # returning the stitched image
    return output_img

# finds keypoints and extracts local invariant descriptors from the two images
def findAndExtract(img):

    # finding and extracting descriptors from the image
    descriptor = cv.xfeatures2d.SIFT_create()
    (key_points, descriptors) = descriptor.detectAndCompute(img, None)

    # turning keypoints to numpy arrays
    key_points = np.float32([key_point.pt for key_point in key_points])

    return (key_points, descriptors)

# match the descriptors between the two images
def matching(key_points1, key_points2, descriptors1, descriptors2,
             ratio, reprojThresh):
    # creating the matches and starting a best matches list
    matcher = cv.DescriptorMatcher_create("BruteForce")
    matches = matcher.knnMatch(descriptors1, descriptors2, 2)
    best_matches = []

    for match in matches:
        # Lowe's ratio test: testing if the distance is within the ratio we set of each other
        if len(match) == 2 and match[0].distance < match[1].distance * ratio:
            best_matches.append((match[0].trainIdx, match[0].queryIdx))

    # creating a homography only if there are at least 4 matches
    if len(best_matches) > 4:
        # building two sets of points
        points1 = np.float32([key_points1[i] for (_, i) in best_matches])
        points2 = np.float32([key_points2[i] for (i, _) in best_matches])

        # creating the homography between the points sets
        (hom_matrix, mask) = cv.findHomography(points1, points2, cv.RANSAC,
                                               reprojThresh)

        # return the best matches list, the homograpy matrix and the status of matched points
        return (best_matches, hom_matrix, mask)

    # if there aren't more than 4 good matches, then no homograpy could be created
    return None


# asumming the command "pip install opencv-contrib-python" was ran in the cmd before program execution (command line)
# we expect images to be supplied as input in left-to-right order
# assuming legal input of images
# Run program with the command "python finalproject.py image1_name image2_name output_name_file_for_the_stitched_image"
def main():
    # reading input from user:
    # reads input - name of image file #1
    img1_name = sys.argv[1]
    # reads input - name of image file #2
    img2_name = sys.argv[2]
    # reads input - name of output file
    output_filename = sys.argv[3]

    # loading original images
    img1 = cv.imread(img1_name)
    img2 = cv.imread(img2_name)

    # checking if the images files are valid (if the files exist)
    if (img1 is None) or (img2 is None):
        sys.exit("Illegal images files")

    # resizing the second image to match the size of the first one in order for them to match for stitching
    """
    min_size = min(img1.shape[0], img2.shape[0])
    img_list_resize = [cv.resize(img1, (int(img1.shape[1] * min_size / img1.shape[0]), min_size), interpolation=cv.INTER_CUBIC),
                    cv.resize(img2, (int(img2.shape[1] * min_size / img2.shape[0]), min_size), interpolation=cv.INTER_CUBIC)]
    img1 = img_list_resize[0]
    img2 = img_list_resize[1]
    """

    imageA = imutils.resize(img1, width=400)
    imageB = imutils.resize(img2, width=400)
    # displays the original image #1
    cv.imshow("Original image #1", img1)

    # displays the original image #2
    cv.imshow("Original image #2", img2)

    # stitching the images together as a panorama
    output_img = stitch(img1, img2)

    # save stitched image to output image
    cv.imwrite("./" + output_filename + ".jpg", output_img)

    # displays the stitched image
    cv.imshow("Final output image", output_img)
    cv.waitKey()


if __name__ == "__main__":
    main()
