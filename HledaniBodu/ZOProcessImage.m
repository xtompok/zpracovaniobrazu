//
//  ZOProcessImage.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 23.3.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProcessImage.h"


@implementation ZOProcessImage

@synthesize minRValue;
@synthesize minGValue;
@synthesize minBValue;

@synthesize maxRValue;
@synthesize maxGValue;
@synthesize maxBValue;

@synthesize minRSumValue;
@synthesize minGSumValue;
@synthesize minBSumValue;

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
	 	
	NSLog(@"Process image initialized");
	
	return self;

}

-(NSPoint)getThePointFromImage:(NSImage *)anImage
{
	NSBitmapImageRep * origRep;
	int i;
	int maxScoreIndex;
	int aScore[3];
	
	// Get an array of bytes from image
	origRep = [[anImage representations] lastObject];
	origbuffer = [origRep bitmapData];
	
	maxScoreR=maxScoreG=maxScoreB=0;
	maxScoreIndex=0;
	
	for(i=0;i<delka;i+=4)
	{
		if (1 // Test point
			&&(origbuffer[i]<maxRValue)
			&&(origbuffer[i+1]<maxGValue)
			&&(origbuffer[i+2]<maxBValue)
			) 
		{
			if (1
				&&(origbuffer[i]>minRValue)
				&&(origbuffer[i+2]>minBValue)
				&&(origbuffer[i+1]>minGValue)
				) 
			{	// Compute sum square
				[self sumSquareAtIndex:i toArray:(int *)&aScore];
				
				//Find maximum score
				if (aScore[0]>maxScoreR) 
				{
					maxScoreR=aScore[0];
					maxScoreG=aScore[1];
					maxScoreB=aScore[2];
					maxScoreIndex=i;
					
				}
			}				
		}
	}
	
	
	//Coloring throwed-away pixels
	for(i=0;i<delka;i+=4)
	{
		//origbuffer[i] = origbuffer[i+1] = origbuffer[i+2] = (origbuffer[i]>  150? 255: 0);
		
		if (1
			&&(origbuffer[i]<maxRValue)
			&&(origbuffer[i+1]<maxGValue)
			&&(origbuffer[i+2]<maxBValue)
			) 
		{
			if (1
				&&(origbuffer[i]>minRValue)
				&&(origbuffer[i+2]>minBValue)
				&&(origbuffer[i+1]>minGValue)
				) 
			{}
			else 
			{
				origbuffer[i]=255;
				origbuffer[i+1]=250;
				origbuffer[i+2]=250;
			}
			
			
		}
		else 
		{
			origbuffer[i]=0;
			origbuffer[i+1]=0;
			origbuffer[i+2]=0;
		}
		
	}
	
	
	// Testing sum value
	if ((maxScoreR<minRSumValue)
		||(maxScoreG<minGSumValue)
		||(maxScoreB<minBSumValue)
		) 
	{
		maxScoreR=0;
		maxScoreG=0;
		maxScoreB=0;
		maxScoreIndex=0;
	}
	
	// Getting colors of found point
	maxR=origbuffer[maxScoreIndex];
	maxG=origbuffer[maxScoreIndex+1];
	maxB=origbuffer[maxScoreIndex+2];
	//printf("Max: R: %.3d, G: %.3d, B:%.3d\n",maxR,maxG,maxB);
	
	// Normalising point 
	NSPoint aPoint;
	aPoint=[self pixelCoordinatesAtIndex:maxScoreIndex];
	aPoint.x=aPoint.x/size.width;
	aPoint.y=aPoint.y/size.height;
	
	//printf("%f,%f",aPoint.x,aPoint.y);
	return aPoint;
	
}



/* Index -> Coordinates */
/* --------------------- */
// Return coordinates as NSSize object of point with supplied index

-(NSPoint)pixelCoordinatesAtIndex:(int)index
{
	NSPoint souradnice;
	souradnice.x=(int)(index%((int)size.width*4))/4;
	souradnice.y=(int)(index/(size.width*4));
	return souradnice;
}

/* Sum square */
/* ---------- */

//Return sum of 5x5 square around supplied point in array with 3 numbers - 
// - one number for each color, point is defined by index
-(void)sumSquareAtIndex:(int)index toArray:(int *)sum
{
	int ulIndex;
	int lrIndex;
	int i,j;
	sum[0]=sum[1]=sum[2]=0;  
	ulIndex=index-2*size.width*4-2*4;
	if (ulIndex<0) {
		return;
	}
	lrIndex=ulIndex+5*size.width*4+2*4;
	if (lrIndex>=delka) {
		return;
	}
	
	for (j=0;j<5;j++)
	{
		for (i=ulIndex;i<(ulIndex+5*4);i+=4)
		{
			sum[0]+=origbuffer[i];
			sum[1]+=origbuffer[i+1];
			sum[2]+=origbuffer[i+2];
		}
		ulIndex+=size.width*4;
	}
	//printf("ulindex=%d, lrindex=%d",ulIndex,lrIndex);
}


@end
