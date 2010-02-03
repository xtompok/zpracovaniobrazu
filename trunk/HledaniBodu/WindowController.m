//
//  WindowController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#import "ZOTransform.h"
#import "ZO2PointTransform.h"
#import "ZOImageView.h"

#import "WindowController.h"

#import <CocoaSequenceGrabber/CocoaSequenceGrabber.h>
#import "ConfigController.h"

#define STDOUTPRINT if([printToStdButton state]==NSOnState)

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
	
	pyProg = [[NSTask alloc]init];
	
	NSPipe *outPipe = [NSPipe pipe];
	NSPipe *inPipe  = [NSPipe pipe];
	pyOut = [outPipe fileHandleForReading];
	pyIn  = [inPipe fileHandleForWriting];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
			selector:@selector(modeSetter:) 
			name:NSFileHandleDataAvailableNotification
			object:pyOut];
	[pyOut waitForDataInBackgroundAndNotify];
	
	NSBundle *myBundle;
	myBundle = [NSBundle mainBundle];
	NSString *pyPath;
	pyPath = [myBundle pathForResource:@"Zobrazovac" ofType:@"py"];
	NSArray * pyArgs;
	pyArgs = [NSArray arrayWithObject:@"c"];
	NSLog(@"%@",pyPath);
	
	
	[pyProg setStandardOutput:outPipe];
	[pyProg setStandardInput:inPipe];
	[pyProg setLaunchPath:pyPath];
	[pyProg setArguments:pyArgs];
	[pyProg launch];
	
	// Show the window
	[self showWindow:nil];
	
	//[self Calibrate:self];
}

// CSGCamera delegate

- (void)camera:(CSGCamera *)aCamera didReceiveFrame:(CSGImage *)aFrame;
{
	lastImage=aFrame;
	
	if (!running) return;
	if (mode=='n') return;
	
	outPoint=[self getLightestPointFromImage:lastImage];
	
	[imageView setAnImage:lastImage];
	
	[imageView setPoint:outPoint];
	[imageView setNeedsDisplay:YES];
		
/*	[self drawSquareAtX:kalibCamArray[4][0] andY:kalibCamArray[4][1] withRadius:5];
	[self drawSquareAtX:kalibCamArray[1][0] andY:kalibCamArray[1][1] withRadius:5];
	[self drawSquareAtX:kalibCamArray[2][0] andY:kalibCamArray[2][1] withRadius:5];
	[self drawSquareAtX:kalibCamArray[3][0] andY:kalibCamArray[3][1] withRadius:5];
*/	
	STDOUTPRINT printf("x=%d, y=%d\n",(int)outPoint.x,(int)outPoint.y);
	//printf("msindex=%d\n",maxScoreIndex);
	
	NSPoint transPoint;
	transPoint=[transformObject transformPoint:outPoint];
	transPoint=[transform2Object transformPoint:outPoint];
	if (mode='g') {
		[pyIn writeData:[self makeDataFromInt:(int)transPoint.x]];
		[self writeChar:','];
		[pyIn writeData:[self makeDataFromInt:(int)transPoint.y]];
		[self writeChar:'\n'];
	}
	
	//[imageView2 setImage:lastImage];
	
	//outPoint=[transformObject transformPoint:outPoint];
	//printf("%c\n",mode);
	STDOUTPRINT printf("xt=%d, yt=%d",(int)transPoint.x,(int)transPoint.y);
	mode='n';
}

// NSWindow delegate

- (void)windowWillClose:(NSNotification *)notification;
{
	[pyProg terminate];
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
	origbuffer[maxScoreIndex]=0;
	origbuffer[maxScoreIndex+1]=0;
	origbuffer[maxScoreIndex+2]=0;
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

/* Communication with Python */
/* ------------------------- */

// Sets the mode for getting pixel - c for calibration, g for normal processing
// If is the other char, prints NSLog, don't raise exception
-(void)modeSetter:(NSNotification *)aNotification
{
	//printf("Prisla zadost\n");
	NSFileHandle * fileHandle;
	NSData * aData;
	unsigned char * znaky;
	fileHandle =(NSFileHandle *) [aNotification object];
	aData = [fileHandle availableData];
	znaky =(unsigned char *) [aData bytes];
	if (sizeof(znaky)==0) {
		return;
	}
	STDOUTPRINT printf("Prisel znak %c s kodem %d\n",znaky[0],znaky[0]);
	switch (znaky[0]) {
		case 'g':
			mode='g';
			break;
		case 'w':
			kalibCamArray[kalibCamArrayindex][0]=(int)outPoint.x;
			kalibCamArray[kalibCamArrayindex][1]=(int)outPoint.y;
			switch (kalibCamArrayindex) {
				case 1:
					[ulLabel setStringValue:
					 [NSString stringWithFormat:@"%.3d,%.3d",
					  kalibCamArray[1][0],
					  kalibCamArray[1][1]]];
					printf("1\n");
					break;
				case 2:
					[urLabel setStringValue:
					 [NSString stringWithFormat:@"%.3d,%.3d",
					  kalibCamArray[2][0],
					  kalibCamArray[2][1]]];
					printf("2\n");
					break;
				case 4:
					[llLabel setStringValue:
					 [NSString stringWithFormat:@"%.3d,%.3d",
					  kalibCamArray[4][0],
					  kalibCamArray[4][1]]];
					printf("4\n");
					break;
				case 3:
					[lrLabel setStringValue:
					 [NSString stringWithFormat:@"%.3d,%.3d",
					  kalibCamArray[3][0],
					  kalibCamArray[3][1]]];
					printf("3\n");
					break;
			}
			if (kalibCamArrayindex<4)
			{
				kalibCamArrayindex++;
				mode='g';
				printf("++\n");
			} else {
				[transformObject release];
				transformObject = [[ZOTransform alloc] initWithCalibrationArray:(int *)&kalibCamArray[1][0] andSize:NSMakeSize(800, 600)];
				[transform2Object release];
				transform2Object = [[ZO2PointTransform alloc] initWithCalibrationArray:(int *)&kalibCamArray[1][0] andSize:NSMakeSize(800, 600)];
				
				kalibCamArrayindex=0;
			}
			break;
		default:
			NSLog(@"Prijat chybny znak %c s kodem %d",znaky[0],znaky[0]);
			
			break;
	}
	[fileHandle waitForDataInBackgroundAndNotify];
}
// Makes NSData object from supplied integer
-(NSData *)makeDataFromInt:(int)cislo
{
	NSString * string = [NSString stringWithFormat:@"%d",cislo];
	NSData *myData=[string dataUsingEncoding:NSUTF8StringEncoding];
	return myData;
}
// Writes to NSPipe pyIn supplied char
-(void)writeChar:(unsigned char)znak
{
	[pyIn writeData:[NSData dataWithBytes:&znak length:1]];
}
/* Drawing into image */
/* ------------------ */

// Draws square at coordinates with supplied radius
-(void)drawSquareAtX:(int)x andY:(int)y withRadius:(int)r
{
	int luCorIndex;
	int i,j;
	if ([self getPixelIndexAtX:(x+r/2) andY:(y+r/2)]>delka) 
	{
		return;
	} else if ([self getPixelIndexAtX:(x-r/2) andY:(y-r/2)]<0) {
		return;
	}
	for (j=0;j<r;j++)
	{
		luCorIndex=[self getPixelIndexAtX:(x-r/2) andY:(y-r/2+j)];
		for (i=luCorIndex;i<luCorIndex+r*4;i+=4)
		{
			origbuffer[i]=0;
			origbuffer[i+1]=255;
			origbuffer[i+2]=255;
		}
	}
	

}

/* GUI Interactivity */
/* ----------------- */

// Calibrates after click
-(IBAction)Calibrate:(id)sender
{
	[self writeChar:'c'];
	[self writeChar:'\n'];
	NSLog(@"Calibrate!");
	//transform2Object = [[ZO2PointTransform alloc] initWithCalibrationArray:(int *)&kalibCamArray[1][0] andSize:size];
	//transformObject = [[ZOTransform alloc] initWithCalibrationArray:(int *)&kalibCamArray[1][0] andSize:size];
	
	
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

