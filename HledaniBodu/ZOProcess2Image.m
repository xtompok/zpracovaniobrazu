//
//  ZOProcessImage.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 23.3.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProcess2Image.h"


@implementation ZOProcess2Image

@synthesize minPointR;
@synthesize minPointG;
@synthesize minPointB;

@synthesize maxPointR;
@synthesize maxPointG;
@synthesize maxPointB;

@synthesize minInnerR;
@synthesize minInnerG;
@synthesize minInnerB;

@synthesize maxInnerR;
@synthesize maxInnerG;
@synthesize maxInnerB;

@synthesize minOuterR;
@synthesize minOuterG;
@synthesize minOuterB;

@synthesize maxOuterR;
@synthesize maxOuterG;
@synthesize maxOuterB;

@synthesize maxScoreR;
@synthesize maxScoreG;
@synthesize maxScoreB;

@synthesize maxR;
@synthesize maxG;
@synthesize maxB;

-(id)initWithSize:(NSSize)aSize
{
	if (![super init])
		return nil;
	size.width=aSize.width;
	size.height=aSize.height;
	delka=size.width*size.height*4;
	
	//[settingsController setProcess2Image:self];
	
	NSLog(@"Process image v.2 initialized");
	
	return self;
	
}

-(NSPoint)getThePointFromImage:(NSImage *)anImage
{
	NSBitmapImageRep * origRep;
	int i;
	int maxScoreIndex;
	struct colResults res;
	
	// Get from image an array of bytes
	origRep = [[anImage representations] lastObject];
	origbuffer = [origRep bitmapData];
	
	maxScoreR=maxScoreG=maxScoreB=0;
	maxScoreIndex=0;

	//printf("Min:%.3d,%.3d,%.3d\nMax:%.3d,%.3d,%.3d\n",minPointR,maxPointR,minInnerR,maxInnerR,minOuterR,maxOuterR);

	for(i=0;i<delka;i+=4)
	{	// Testing point itself
		if (1
			&&(origbuffer[i]>=minPointR)
			&&(origbuffer[i+1]>=minPointG)
			&&(origbuffer[i+2]>=minPointB)
			
			&&(origbuffer[i]<=maxPointR)
			&&(origbuffer[i+2]<=maxPointG)
			&&(origbuffer[i+1]<=maxPointB)
			) 
		{

			// Compute cross sum
			res=[self sumCrossAtIndex:i];

			if (1
				// Test inner cross
				&&(res.innerR>=minInnerR)
				&&(res.innerG>=minInnerG)
				&&(res.innerB>=minInnerB)
				
				&&(res.innerR<=maxInnerR)
				&&(res.innerG<=maxInnerG)
				&&(res.innerB<=maxInnerB) 
				
				//Test outer cross
				&&(res.outerR>=minOuterR)
				&&(res.outerG>=minOuterG)
				&&(res.outerB>=minOuterB)
				
				&&(res.outerR<=maxOuterR)
				&&(res.outerG<=maxOuterG)
				&&(res.outerB<=maxOuterB)
				) {
				// Find maximum
				if (res.innerR>maxScoreR) 
				{
					maxScoreR=res.innerR;
					maxScoreG=res.outerG;
					maxScoreB=res.outerB;
					maxScoreIndex=i;
				}
				
			}
		}

	}
	
	// Color of found point
	maxR=origbuffer[maxScoreIndex];
	maxG=origbuffer[maxScoreIndex+1];
	maxB=origbuffer[maxScoreIndex+2];
	printf("Max: R: %.3d, G: %.3d, B:%.3d\n",maxR,maxG,maxB);
	
	// Compute standard coordinates
	NSPoint aPoint;
	aPoint=[self pixelCoordinatesAtIndex:maxScoreIndex];
	aPoint.x=aPoint.x/size.width;
	aPoint.y=aPoint.y/size.height;
	//printf("%f,%f",aPoint.x,aPoint.y);
	return aPoint;
	
}



/* Index -> Coordinates */
/* --------------------- */
// Return coordinates as NSPoint object of point with supplied index

-(NSPoint)pixelCoordinatesAtIndex:(int)index
{
	NSPoint souradnice;
	souradnice.x=(int)(index%((int)size.width*4))/4;
	souradnice.y=(int)(index/(size.width*4));
	return souradnice;
}

/* Computing cross method */
/*------------------------*/

// Computes average of inner (I) and outer (O) cross around point (P)
/*
 ...O...
 .......
 ...I...
 O.IPI.O
 ...I...
 .......
 ...O...
 */
-(struct colResults)sumCrossAtIndex:(int)index;
{
	int radek;
	int innDelitel;
	int outDelitel;
	int i;
	int outerRange;
	struct colResults res;
	
	res.innerR=res.innerG=res.innerB=0;
	res.outerR=res.outerG=res.outerB=0;
	
	radek=size.width*4;
	outerRange=5;
	innDelitel=0;
	outDelitel=0;
	
	// Upper outer point
	i=index-outerRange*radek;
	if (i>=0) 
	{
		res.outerR+=origbuffer[i];
		res.outerG+=origbuffer[i+1];
		res.outerB+=origbuffer[i+2];
		outDelitel++;
	}
	
	// Lower outer point
	i=index+outerRange*radek;
	if (i<delka) 
	{
		res.outerR+=origbuffer[i];
		res.outerG+=origbuffer[i+1];
		res.outerB+=origbuffer[i+2];
		outDelitel++;
	}
	
	// Left outer point
	i=index-12;
	if ((i>=0)&&((i%(int)size.width)<(index%(int)size.width))) 
	{
		res.outerR+=origbuffer[index-12];
		res.outerG+=origbuffer[index-11];
		res.outerB+=origbuffer[index-10];
		outDelitel++;
	}
	
	// Right outer point
	i=index+12;
	if ((i<delka)&&((i%(int)size.width)>(index%(int)size.width)))
	{
		res.outerR+=origbuffer[index+12];
		res.outerG+=origbuffer[index+13];
		res.outerB+=origbuffer[index+14];
		outDelitel++;
	}
		
	// Upper inner point
	i=index-radek;
	if (i>=0) 
	{
		res.innerR+=origbuffer[i];
		res.innerG+=origbuffer[i+1];
		res.innerB+=origbuffer[i+2];
		innDelitel++;
	}
	
	// Lower inner point
	i=index+radek;
	if (i<delka) 
	{
		res.innerR+=origbuffer[i];
		res.innerG+=origbuffer[i+1];
		res.innerB+=origbuffer[i+2];
		innDelitel++;
	}
	
	// Left inner point
	i=index-4;
	if ((i>=0)&&((i%(int)size.width)<(index%(int)size.width)))
	{
		res.innerR+=origbuffer[index-4];
		res.innerG+=origbuffer[index-3];
		res.innerB+=origbuffer[index-2];
		innDelitel++;
	}
	
	// Right inner point
	i=index+4;
	if ((i<delka)&&((i%(int)size.width)>(index%(int)size.width)))
	{
		res.innerR+=origbuffer[index+4];
		res.innerG+=origbuffer[index+5];
		res.innerB+=origbuffer[index+6];
		innDelitel++;
	}
	

	// Average results
	res.innerR/=innDelitel;
	res.innerG/=innDelitel;
	res.innerB/=innDelitel;
	
	res.outerR/=outDelitel;
	res.outerG/=outDelitel;
	res.outerB/=outDelitel;
	
	//printf("Inner - R: %d, G: %d, B: %d\nOuter - R: %d, G: %d, B: %d\n",res.innerR,res.innerG,res.innerB,res.outerR,res.outerG,res.outerB);

	
	return res;
}

@end
