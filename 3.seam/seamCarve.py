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


# find a vertical seam, return indices
def findVerticalSeam(gradientList, width, height):
	size = width*height

	# calculate gradient perculation
	for x in range(0, size):
		if(x < width):							# top side
			continue
		elif((x + 1) % width == 0): # right side
			g1 = gradientList[x - width]
			g2 = gradientList[x - width - 1]
			gradientList[x] = gradientList[x] + min(g1, g2)
		elif(x % width == 0): 			# left side
			g1 = gradientList[x - width]
			g2 = gradientList[x - width + 1]
			gradientList[x] = gradientList[x] + min(g1, g2)
		else:
			g1 = gradientList[x - width]
			g2 = gradientList[x - width - 1]
			g3 = gradientList[x - width + 1]
			gradientList[x] = gradientList[x] + min(g1, g2, g3)

	# generate the seam
	seam = []
	minSeamStartIndex = 0
	minSeamStart = posInf
	for y in range(size - width, size):
		if(gradientList[y] < minSeamStart):
			minSeamStart = gradientList[y]
			minSeamStartIndex = y
	seam.append(minSeamStartIndex)

	seamIndex = minSeamStartIndex
	while(seamIndex >= width):
		g1 = gradientList[seamIndex - width]
		g2 = posInf if(seamIndex % width == 0) else gradientList[seamIndex - width - 1]
		g3 = posInf if((seamIndex+1) % width == 0) else gradientList[seamIndex - width + 1]
		ming = min(g1,g2,g3)
		if(g1 == ming):
			seam.append(seamIndex - width)
			seamIndex = seamIndex - width
		elif(g2 == ming):
			seam.append(seamIndex - width - 1)
			seamIndex = seamIndex - width - 1
		elif(g3 == ming):
			seam.append(seamIndex - width + 1)
			seamIndex = seamIndex - width + 1

	return seam

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


def removeSeam(seam, image, width, height):
  pass


fileName = sys.argv[1]
amountToCarve = int(sys.argv[2])

try:
	# load the image
	im = Image.open(fileName)
	pixels = list(im.getdata())
	w,h = im.size

	for i in range(0,amountToCarve):
		
		# precompute gradient at matrix
		gradientList = generateGradients(w,h,pixels)

		# find the seam
		seam = findVerticalSeam(gradientList, w, h)

		assert(len(seam) == h)

		# remove the seam
		decrease = 0
		for s in seam:
			pixels.pop(s - decrease)
			#decrease = decrease + 1

		assert(len(pixels) == ((w-1)*h))
		w = w - 1

		print (str(100*i/amountToCarve) + "%")


	# save the image
	im2 = Image.new(im.mode, (len(pixels)/h, h))
	im2.putdata(pixels)
	im2.save(fileName+"-test.jpg")
		

    
except IOError, e:
    print >> sys.stderr, "%s: %s\n\nCannot open/understand %s" % (sys.argv[0], str(e), fileName)