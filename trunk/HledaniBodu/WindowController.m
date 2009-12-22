//
//  WindowController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#import "WindowController.h"

#import <CocoaSequenceGrabber/CocoaSequenceGrabber.h>


@implementation WindowController

@synthesize rmin;
@synthesize rmax;
@synthesize gmin;
@synthesize gmax;
@synthesize bmin;
@synthesize bmax;

// Init and dealloc

- (void)dealloc;
{
	[camera release];
	
	[super dealloc];
}

- (void)awakeFromNib;
{
	size.height=240;
	size.width=320;
	
	delka=size.width*size.height*4;
	
	// Start recording
	camera = [[CSGCamera alloc] init];
	[camera setDelegate:self];
	[camera startWithSize:size];
	
	
	// Make sure we don't distort the video as the user resizes the window
	NSWindow *window = [self window];
	/*[[window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
	[[window standardWindowButton:NSWindowZoomButton] setHidden:YES];
	[[window standardWindowButton:NSWindowCloseButton] setHidden:YES];
	NSColor*	translucent = [NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.6] ;
	[window setBackgroundColor:translucent];*/
	[window setAspectRatio:[window frame].size];
	
	
	
	// Show the window
	[self showWindow:nil];
}

// CSGCamera delegate

- (void)camera:(CSGCamera *)aCamera didReceiveFrame:(CSGImage *)aFrame;
{
	origRep = [[aFrame representations] lastObject];
	[origRep getBitmapDataPlanes:(unsigned char **)&origbuffer];
	
	int i;
	int maxScore[3];
	maxScore[0]=maxScore[1]=maxScore[2]=0;
	int maxScoreIndex;
	maxScoreIndex=0;
	int aScore[3];
	for(i=0;i<delka;i+=4)
	{
		if (1
			//&&(origbuffer[i]<rmax)
			//&&(origbuffer[i]>rmin)
			//&&(origbuffer[i+1]<gmax)
			//&&(origbuffer[i+1]>gmin)
			//&&(origbuffer[i+2]<bmax)
			//&&(origbuffer[i+2]>bmin)
			) {
			[self getSumSquareAtIndex:i toArray:(int *)&aScore];
			if (aScore[1]>maxScore[1]) {
				maxScore[0]=aScore[0];
				maxScore[1]=aScore[1];
				maxScore[2]=aScore[2];
				maxScoreIndex=i;
			}
		}
	}
	origbuffer[maxScoreIndex]=255;
	origbuffer[maxScoreIndex+1]=255;
	origbuffer[maxScoreIndex+2]=255;
	printf("msindex=%d\n",maxScoreIndex);
	int pole[3];
	[self getSumSquareAtX:160 andY:120 toArray:(int *)&pole];
	printf("%d\n",pole[0]);
	[self getSumSquareAtIndex:160000 toArray:(int *)&pole];
	printf("%d\n",pole[0]);
	[cameraView setImage:aFrame];
}

// NSWindow delegate

- (void)windowWillClose:(NSNotification *)notification;
{
	[camera stop];
}

-(int)getPixelIndexAtX:(int)x andY:(int)y
{
	int index;
	index=y*size.width*4+x*4;
	return index;

}
-(void)getSumSquareAtX:(int)x andY:(int)y toArray:(int *)sum
{
	int luCorIndex;
	int i,j;
	sum[0]=sum[1]=sum[2]=0;
	if ([self getPixelIndexAtX:(x+2) andY:(y+2)]>delka) 
	{
		return;
	} else if ([self getPixelIndexAtX:(x-2) andY:(y-2)]<0) {
		return;
	}
	for (j=0;j<5;j++)
	{
		luCorIndex=[self getPixelIndexAtX:(x-2) andY:(y-2+j)];
		for (i=luCorIndex;i<luCorIndex+5;i++)
		{
			sum[0]+=origbuffer[i];
			sum[1]+=origbuffer[i+1];
			sum[2]+=origbuffer[i+2];
		}
	}

}
-(void)getSumSquareAtIndex:(int)index toArray:(int *)sum
{
	int ulIndex;
	int lrIndex;
	int i,j;
	sum[0]=sum[1]=sum[2]=0;  
	ulIndex=index-2*size.width*4-2;
	if (ulIndex<0) {
		return;
	}
	lrIndex=ulIndex+5*size.width*4+2;
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

-(NSSize)getPixelCoordinatesAtIndex:(int)index
{
	NSSize souradnice;
	souradnice.width=index%(int)size.width;
	souradnice.height=(int)(index/size.width);
	return souradnice;
}


@end

