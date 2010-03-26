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

-(id)initWithSize:(NSSize)aSize
{
	if (![super init])
		return nil;
	size.width=aSize.width;
	size.height=aSize.height;
	delka=size.width*size.height*4;
	printf("Delka=%d\n",delka);
	origbuffer=(unsigned char *)malloc(delka*sizeof(char));
	
	minRValue=120;
	
	maxRValue=255;
	maxGValue=255;
	maxBValue=255;

	return self;

}

-(NSPoint)getLightestPointFromImage:(NSImage *)anImage
{
	NSBitmapImageRep * origRep;
	
	origRep = [[anImage representations] lastObject];
	[origRep getBitmapDataPlanes:(unsigned char **)&origbuffer];
	
	int i;
	maxScoreR=maxScoreG=maxScoreB=0;
	int maxScoreIndex;
	maxScoreIndex=0;
	int aScore[3];
	for(i=0;i<delka;i+=4)
	{
		if (1
			&&(origbuffer[i]<maxRValue)
			&&(origbuffer[i]>minRValue)
			&&(origbuffer[i+1]<maxGValue)
			&&(origbuffer[i+1]>minGValue)
			&&(origbuffer[i+2]<maxBValue)
			&&(origbuffer[i+2]>minBValue)
			) 
		{
			[self getSumSquareAtIndex:i toArray:(int *)&aScore];
			
			if (aScore[0]>maxScoreR) 
			{
				maxScoreR=aScore[0];
				maxScoreG=aScore[1];
				maxScoreB=aScore[2];
				maxScoreIndex=i;
				
			}
			
		}
	}
	
	
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
	printf("Max: R: %.3d, G: %.3d, B:%.3d\n",
					   origbuffer[maxScoreIndex],
					   origbuffer[maxScoreIndex+1],
					   origbuffer[maxScoreIndex+2]);
	
	NSPoint aPoint;
	aPoint=[self getPixelCoordinatesAtIndex:maxScoreIndex];
	aPoint.x=aPoint.x/size.width;
	aPoint.y=aPoint.y/size.height;
	
	printf("%f,%f",aPoint.x,aPoint.y);
	return aPoint;
	
}



/* Index -> Coordinates */
/* --------------------- */
// Return coordinates as NSSize object of point with supplied index

-(NSPoint)getPixelCoordinatesAtIndex:(int)index
{
	NSPoint souradnice;
	souradnice.x=(int)(index%((int)size.width*4))/4;
	souradnice.y=(int)(index/(size.width*4));
	return souradnice;
}

/* Sum square */
/* ----------- */

//Return sum of 5x5 square around supplied point in array with 3 numbers - 
// - one number for each color, point is defined by index
-(void)getSumSquareAtIndex:(int)index toArray:(int *)sum
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
