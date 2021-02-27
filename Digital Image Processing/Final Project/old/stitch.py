# USAGE
# python stitch.py img1 img2

# import the necessary packages
#from panorama import Stitcher
import argparse
import imutils
import cv2
import sys
import numpy as np

class Stitcher:
	def __init__(self):
		# determine if we are using OpenCV v3.X
		self.isv3 = imutils.is_cv3()

	def stitch(self, images, ratio=0.75, reprojThresh=4.0,
		showMatches=False):
		# unpack the images, then detect keypoints and extract
		# local invariant descriptors from them
		(imageB, imageA) = images
		(kpsA, featuresA) = self.detectAndDescribe(imageA)
		(kpsB, featuresB) = self.detectAndDescribe(imageB)

		# match features between the two images
		M = self.matchKeypoints(kpsA, kpsB,
			featuresA, featuresB, ratio, reprojThresh)

		# if the match is None, then there aren't enough matched
		# keypoints to create a panorama
		if M is None:
			return None

		# otherwise, apply a perspective warp to stitch the images
		# together
		(matches, H, status) = M
		a = np.array([[0, 0], [imageA.shape[1], 0], [0, imageA.shape[0]],[imageA.shape[1], imageA.shape[0]]], dtype='float32')
		a = np.array([a])
		dst = cv2.perspectiveTransform(a, H)
		print(a)
		print(dst)
		dff = max(abs(imageA.shape[1] - dst[0][1][0]), abs(imageA.shape[1] - dst[0][3][0]))
		dff = dff - (imageB.shape[1] - imageA.shape[1])
		while imageA.shape[1] + imageB.shape[1] - int(dff) < imageB.shape[1]:
			dff = dff / 2
		print(dff)
		result = cv2.warpPerspective(imageA, H,
			(imageA.shape[1] + imageB.shape[1] - int(dff), imageA.shape[0]))
		result[0:imageB.shape[0], 0:imageB.shape[1]] = imageB

		# check to see if the keypoint matches should be visualized
		if showMatches:
			vis = self.drawMatches(imageA, imageB, kpsA, kpsB, matches,
				status)

			# return a tuple of the stitched image and the
			# visualization
			return (result, vis)

		# return the stitched image
		return result

	def detectAndDescribe(self, image):
		# convert the image to grayscale
		gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

		# check to see if we are using OpenCV 3.X
		if self.isv3:
			# detect and extract features from the image
			descriptor = cv2.xfeatures2d.SIFT_create()
			(kps, features) = descriptor.detectAndCompute(image, None)

		# otherwise, we are using OpenCV 2.4.X
		else:
			# detect keypoints in the image
			detector = cv2.SIFT_create()
			#detector = cv2.FeatureDetector_create("SIFT")
			kps = detector.detect(gray)

			# extract features from the image
			extractor = cv2.SIFT_create()
			(kps, features) = extractor.compute(gray, kps)

		# convert the keypoints from KeyPoint objects to NumPy
		# arrays
		kps = np.float32([kp.pt for kp in kps])

		# return a tuple of keypoints and features
		return (kps, features)

	def matchKeypoints(self, kpsA, kpsB, featuresA, featuresB,
		ratio, reprojThresh):
		# compute the raw matches and initialize the list of actual
		# matches
		matcher = cv2.DescriptorMatcher_create("BruteForce")
		rawMatches = matcher.knnMatch(featuresA, featuresB, 2)
		matches = []

		# loop over the raw matches
		for m in rawMatches:
			# ensure the distance is within a certain ratio of each
			# other (i.e. Lowe's ratio test)
			if len(m) == 2 and m[0].distance < m[1].distance * ratio:
				matches.append((m[0].trainIdx, m[0].queryIdx))

		# computing a homography requires at least 4 matches
		if len(matches) > 4:
			# construct the two sets of points
			ptsA = np.float32([kpsA[i] for (_, i) in matches])
			ptsB = np.float32([kpsB[i] for (i, _) in matches])

			# compute the homography between the two sets of points
			(H, status) = cv2.findHomography(ptsA, ptsB, cv2.RANSAC,
				reprojThresh)

			# return the matches along with the homograpy matrix
			# and status of each matched point
			return (matches, H, status)

		# otherwise, no homograpy could be computed
		return None

	def drawMatches(self, imageA, imageB, kpsA, kpsB, matches, status):
		# initialize the output visualization image
		(hA, wA) = imageA.shape[:2]
		(hB, wB) = imageB.shape[:2]
		vis = np.zeros((max(hA, hB), wA + wB, 3), dtype="uint8")
		vis[0:hA, 0:wA] = imageA
		vis[0:hB, wA:] = imageB

		# loop over the matches
		for ((trainIdx, queryIdx), s) in zip(matches, status):
			# only process the match if the keypoint was successfully
			# matched
			if s == 1:
				# draw the match
				ptA = (int(kpsA[queryIdx][0]), int(kpsA[queryIdx][1]))
				ptB = (int(kpsB[trainIdx][0]) + wA, int(kpsB[trainIdx][1]))
				cv2.line(vis, ptA, ptB, (0, 255, 0), 1)

		# return the visualization
		return vis

# construct the argument parse and parse the arguments
img1_name = sys.argv[1]                      # name of image file #1
img2_name = sys.argv[2]                      # name of image file #2
img1 = cv2.imread(img1_name)
img2 = cv2.imread(img2_name)

"""
ap = argparse.ArgumentParser()
ap.add_argument("-l", "--list", nargs='+', required=True,
	help="path to the first image")
args = vars(ap.parse_args())
"""
# load the two images and resize them to have a width of 400 pixels
# (for faster processing)
"""
img_urls = args["list"]
images = [cv2.imread(img_url) for img_url in args["list"]]
"""
images = [img1, img2]
for idx,img in enumerate(images):
    images[idx] = imutils.resize(img, width=400)

# stitch the images together to create a panorama
cur_img = images[0]
imgs_to_process = images[1:]
imgs_len = len(imgs_to_process)
for i in range(imgs_len):
    print("stitching")
    stitcher = Stitcher()
    (result, vis) = stitcher.stitch((cur_img, imgs_to_process[i]), showMatches=True)
    cur_img = imutils.resize(result, width=400)
result = cur_img
    

# show the images
cv2.imshow("Keypoint Matches", vis)
cv2.imshow("Result", result)
cv2.waitKey(0)