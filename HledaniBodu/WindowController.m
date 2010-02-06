//
//  WindowController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#define STDOUTPRINT if([printToStdButton state]==NSOnState)

#import "ZOTransform.h"
#import "ZO2PointTransform.h"
#import "ZOPoint.h"
#import "ZOImageView.h"
#import "ZOProjectorView.h"


#import "WindowController.h"

#import <CocoaSequenceGrabber/CocoaSequenceGrabber.h>
#import "ConfigController.h"


@implementation WindowController

// Init and dealloc

- (void)dealloc;
{
	[camera release];
	
	[super dealloc];
}

- (void)awakeFromNib;
{
	size=NSMakeSize(320, 240);
	
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
	
	urCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	ulCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	lrCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	llCalPoint = [[ZOPoint alloc] initWithPoint:NSMakePoint(1, 1)];
	
	
	calLabelsArray = [[NSArray alloc] initWithObjects:
					  (NSTextField *) ulLabel,
					  (NSTextField *) urLabel,
					  (NSTextField *) lrLabel,
					  (NSTextField *) llLabel,nil];
	
	calPointsArray = [[NSArray alloc] initWithObjects:
					  (ZOPoint *) ulCalPoint,
					  (ZOPoint *) urCalPoint,
					  (ZOPoint *) lrCalPoint,
					  (ZOPoint *) llCalPoint,
					  nil];
	
	int windowLevel;
	NSRect screeenRect;
	NSScreen *aScreen;
	
	NSLog(@"screens: %i",[[NSScreen screens]count]);
	
	if ([[NSScreen screens]count]>1)
	{
		aScreen = [[NSScreen screens] objectAtIndex:1];
		windowLevel = CGShieldingWindowLevel();
		screeenRect = [aScreen frame];
		
		projWindow = [[NSWindow alloc] initWithContentRect:screeenRect
												 styleMask:NSBorderlessWindowMask
												   backing:NSBackingStoreBuffered
													 defer:NO screen: [NSScreen mainScreen]];
		[projWindow setLevel:windowLevel];
		[projWindow setBackgroundColor:[NSColor blueColor]];
		[projWindow makeKeyAndOrderFront:nil];
		
		// Load our content view
		[projPanel setFrame:screeenRect display: YES];
		[projWindow setContentView:[projPanel contentView]];
	}	
	
	rmin=120;
	rmax=255;
	gmin=120;
	gmax=255;
	bmin=120;
	bmax=255;
	
	mode='n';
	running=YES;
	
	kalibCamArrayindex=0;
	kalibCamArray[0][0]=100;
	kalibCamArray[0][1]=100;
	
	// Show the window
	[self showWindow:nil];
	
	//[self Calibrate:self];
}

// CSGCamera delegate

- (void)camera:(CSGCamera *)aCamera didReceiveFrame:(CSGImage *)aFrame;
{
	lastImage=aFrame;
	
	if (!running) return;
	//if (mode=='n') return;
	
	outPoint=[self getLightestPointFromImage:lastImage];
	
	[imageView setAnImage:lastImage];
	
	[imageView setPoint:outPoint];
	[imageView setNeedsDisplay:YES];
	
	[projView setPoint1:outPoint];
	[projView setNeedsDisplay:YES];
			
	STDOUTPRINT printf("x=%d, y=%d\n",(int)outPoint.x,(int)outPoint.y);
	//printf("msindex=%d\n",maxScoreIndex);
	
	NSPoint transPoint;
	transPoint=[transformObject transformPoint:outPoint];
	transPoint=[transform2Object transformPoint:outPoint];
	
	
	//outPoint=[transformObject transformPoint:outPoint];
	//printf("%c\n",mode);
	STDOUTPRINT printf("xt=%d, yt=%d",(int)transPoint.x,(int)transPoint.y);
	//mode='n';
}

// NSWindow delegate

- (void)windowWillClose:(NSNotification *)notification;
{
	[projWindow orderOut:self];
	[camera stop];
}

-(NSPoint)getLightestPointFromImage:(NSImage *)anImage
{
	NSBitmapImageRep * origRep;
	
	origRep = [[anImage representations] lastObject];
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
			&&(origbuffer[i]>rmin)
			//&&(origbuffer[i+1]<gmax)
			&&(origbuffer[i+1]>gmin)
			//&&(origbuffer[i+2]<bmax)
			&&(origbuffer[i+2]>bmin)
			) {
			[self getSumSquareAtIndex:i toArray:(int *)&aScore];
			
			if (aScore[0]>maxScore[0]) {
				maxScore[0]=aScore[0];
				maxScore[1]=aScore[1];
				maxScore[2]=aScore[2];
				maxScoreIndex=i;
				
			}
		}
	}
	
	[maxSumSquareLabel setStringValue:
	 [NSString stringWithFormat:@"%d,%d,%d",
	  maxScore[0],
	  maxScore[1],
	  maxScore[2]]];
	
	if ( (maxScore[0]<[rMinSlider intValue])
		&&(maxScore[1]<[gMinSlider intValue])
		&&(maxScore[2]<[bMinSlider intValue])
		) 
	{
		maxScore[0]=0;
		maxScore[1]=0;
		maxScore[2]=0;
		maxScoreIndex=i;
	}
	STDOUTPRINT printf("Sum: R: %.4d, G: %.4d, B:%.4d\n",maxScore[0],maxScore[1],maxScore[2]);
	STDOUTPRINT printf("Max: R: %.3d, G: %.3d, B:%.3d\n",
					   origbuffer[maxScoreIndex],
					   origbuffer[maxScoreIndex+1],
					   origbuffer[maxScoreIndex+2]);

	NSPoint aPoint;
	aPoint=[self getPixelCoordinatesAtIndex:maxScoreIndex];
	aPoint.x=aPoint.x/size.width;
	aPoint.y=aPoint.y/size.height;
	return aPoint;

}



/* Coordinates <-> Index */
/* --------------------- */

// Return index of point with supplied coordinates
-(int)getPixelIndexAtX:(int)x andY:(int)y
{
	int index;
	index=y*size.width*4+x*4;
	return index;
}
// Return coordinates as NSSize object of point with supplied index
-(NSPoint)getPixelCoordinatesAtIndex:(int)index
{
	NSPoint souradnice;
	souradnice.x=(int)(index%((int)size.width*4))/4;
	souradnice.y=(int)(index/(size.width*4));
	return souradnice;
}


/* Sum squares */
/* ----------- */

//Return sum of 5x5 square around supplied point in array with 3 numbers - 
// - one number for each color, point is defined by coordinates
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

// Makes NSData object from supplied integer
-(NSData *)makeDataFromInt:(int)cislo
{
	NSString * string = [NSString stringWithFormat:@"%d",cislo];
	NSData *myData=[string dataUsingEncoding:NSUTF8StringEncoding];
	return myData;
}


/* GUI Interactivity */
/* ----------------- */

// Calibrates after click
-(IBAction)Calibrate:(id)sender
{	
	if (kalibCamArrayindex!=0) return;
	kalibCamArrayindex++;
	
	[calibrateButton setEnabled:NO];
	
	
	calTimer = [NSTimer scheduledTimerWithTimeInterval: 3
												target: self
											  selector: @selector(handleCalTimer:)
											  userInfo: nil
											   repeats: NO];
	NSLog(@"Calibrate!");
	//transform2Object = [[ZO2PointTransform alloc] initWithCalibrationArray:(int *)&kalibCamArray[1][0] andSize:size];
	//transformObject = [[ZOTransform alloc] initWithCalibrationArray:(int *)&kalibCamArray[1][0] andSize:size];
	
}


- (void) handleCalTimer: (NSTimer *) aTimer
{
	STDOUTPRINT printf("Timer has expired\n");

	[projView setCalPoint:kalibCamArrayindex];
	[projView setNeedsDisplay:YES];
	
	calTimer = [NSTimer scheduledTimerWithTimeInterval: 3
												target: self
											  selector: @selector(handleBlankTimer:)
											  userInfo: nil
											   repeats: NO];
                                                                 
} // handleTimer

-(void)handleBlankTimer:(NSTimer *)aTimer
{
	outPoint=[self getLightestPointFromImage:lastImage];
	
	[[calPointsArray objectAtIndex:(kalibCamArrayindex -1)] setPoint:outPoint];
	
	[[calLabelsArray objectAtIndex:(kalibCamArrayindex-1)] setStringValue:
	 [NSString stringWithFormat:@"%.3d,%.3d",
	  (int)(outPoint.x*size.width),
	  (int)(outPoint.y*size.height)]];
	
	kalibCamArrayindex++;
	
	[projView setCalPoint:0];
	[projView setNeedsDisplay:YES];
	
	if (kalibCamArrayindex>4) 
	{
		kalibCamArrayindex=0;
		[imageView setCalPoints:calPointsArray];
		[calibrateButton setEnabled:YES];
	}
	else 
	{
		calTimer = [NSTimer scheduledTimerWithTimeInterval: 3
													target: self
												  selector: @selector(handleCalTimer:)
												  userInfo: nil
												   repeats: NO];
	}

}


// Pause and resume running program
-(IBAction)RunAndPause:(id)sender
{
	if ([sender title]==@"Run") {
		running=YES;
		[sender setTitle:@"Pause"];
		NSLog(@"Running!");
	} else {
		running=NO;
		[sender setTitle:@"Run"];
		NSLog(@"Paused!");
	}
}

//Configuration
-(IBAction)sumSquareSliderMoved:(id)sender
{
	NSLog(@"%@",sender);
	if ([minTogetherButton state]==NSOffState) 
	{
		if (sender==rMinSlider) 
		{	
			[rMinLabel setIntValue:[rMinSlider intValue]];
		} 
		else if (sender==gMinSlider)
		{
			[gMinLabel setIntValue:[gMinSlider intValue]];
		} 
		else if (sender==bMinSlider) 
		{
			[bMinLabel setIntValue:[bMinSlider intValue]];
		}
		
	} else {
		if (sender==rMinSlider) 
		{
			[gMinSlider setIntValue:[rMinSlider intValue]];
			[bMinSlider setIntValue:[rMinSlider intValue]];
			
			[rMinLabel setIntValue:[rMinSlider intValue]];
			[gMinLabel setIntValue:[rMinSlider intValue]];
			[bMinLabel setIntValue:[rMinSlider intValue]];
		} 
		else if (sender==gMinSlider)
		{
			[rMinSlider setIntValue:[gMinSlider intValue]];
			[bMinSlider setIntValue:[gMinSlider intValue]];
			
			[rMinLabel setIntValue:[gMinSlider intValue]];
			[gMinLabel setIntValue:[gMinSlider intValue]];
			[bMinLabel setIntValue:[gMinSlider intValue]];
		} 
		else if (sender==bMinSlider) 
		{
			[rMinSlider setIntValue:[bMinSlider intValue]];
			[gMinSlider setIntValue:[bMinSlider intValue]];
			
			[rMinLabel setIntValue:[bMinSlider intValue]];
			[gMinLabel setIntValue:[bMinSlider intValue]];
			[bMinLabel setIntValue:[bMinSlider intValue]];
		}
	}
}

@end

