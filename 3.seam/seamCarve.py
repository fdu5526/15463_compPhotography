#!/usr/bin/python

import os, sys, math
from PIL import Image
from struct import *

posInf = float("inf")


# find sum of square distance between 2 pixels
def pixelDiff(pixel1, pixel2):
	r1,g1,b1 = pixel1
	r2,g2,b2 = pixel2

	r = r2 - r1
	g = g2 - g1
	b = b2 - b1

	return (r*r + g*g + b*b)


# create gradient matrix for the image
def generateGradients(width, height, pixels):
	size = width*height

	# initializes gradient
	gradient = [x for x in range(size)]

	# calculate gradient
	for x in range(0, size):
		if((x + 1) % width == 0):
			gradient[x] = posInf
		elif(x+width >= size):
			gradient[x] = 0.0
		else:
			g1 = pixelDiff(pixels[x], pixels[x+1])
			g2 = pixelDiff(pixels[x], pixels[x+width])
			gradient[x] = math.sqrt(g1 + g2)

	return gradient



# find a vertical seam, return indices
def findVerticalSeam(gradientList, width, height):
	size = width*height

	# calculate gradient perculation
	for x in range(width, size):
		g1 = gradientList[x - width]
		g2 = posInf if(x % width == 0) else gradientList[x - width - 1]
		g3 = posInf if((x + 1) % width == 0) else gradientList[x - width + 1]
		gradientList[x] = gradientList[x] + min(g1, g2, g3)

	# generate the seam starting piont
	minSeamStartIndex = 0
	minSeamStart = posInf
	for y in range(size - width, size):
		if(gradientList[y] < minSeamStart):
			minSeamStart = gradientList[y]
			minSeamStartIndex = y
	seam = [minSeamStartIndex]

	# generate rest of the seam
	seamIndex = minSeamStartIndex
	while(seamIndex >= width):
		g1 = gradientList[seamIndex - width]
		g2 = posInf if(seamIndex % width == 0) else gradientList[seamIndex - width - 1]
		g3 = posInf if((seamIndex+1) % width == 0) else gradientList[seamIndex - width + 1]
		ming = min(g1,g2,g3)
		bestIndex = seamIndex - width
		if(g2 == ming):
			bestIndex = seamIndex - width - 1
		elif(g3 == ming):
			bestIndex = seamIndex - width + 1
		seam.append(bestIndex)
		seamIndex = bestIndex

	return seam





fileName = sys.argv[1]
amountToCarve = int(sys.argv[2])

removeHorizontalSeams = True

try:
	# load the image
	im = Image.open(fileName)
	pixels = list(im.getdata())
	w,h = im.size

	# transpose for horizontal removal
	if(removeHorizontalSeams):
		newPixels = []
		for x in (reversed (range(0,w))):
			for y in ((range(0,h))):
				newPixels.append(pixels[y*w + x])
		pixels = newPixels
		w,h = h,w


	for i in range(0,amountToCarve):
		print (str(100*i/amountToCarve) + "%")

		# precompute gradient at matrix
		gradientList = generateGradients(w,h,pixels)
		# find the seam
		seam = findVerticalSeam(gradientList, w, h)

		#print(str(len(seam)) + " " + str(h))

		# remove the seam
		for s in seam:
			pixels.pop(s)
		w = w - 1
		

	if(removeHorizontalSeams):
		# transpose for horizontal removal
		if(removeHorizontalSeams):
			newPixels = []
			for x in ( (range(0,w))):
				for y in (reversed (range(0,h))):
					newPixels.append(pixels[y*w + x])
			pixels = newPixels
			w,h = h,w

	# save the image
	im2 = Image.new(im.mode, (w, h))
	im2.putdata(pixels)
	im2.save(fileName+"-test.jpg")
		

    
except IOError, e:
    print >> sys.stderr, "%s: %s\n\nCannot open/understand %s" % (sys.argv[0], str(e), fileName)