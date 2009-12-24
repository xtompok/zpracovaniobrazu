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
@synthesize mode;
@synthesize xout;
@synthesize yout;

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
	
	mode='n';
	
	
	NSTask *pyProg;
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
	pyPath = [myBundle pathForResource:@"main" ofType:@"py"];
	NSArray * pyArgs;
	pyArgs = [NSArray arrayWithObject:@"c"];
	NSLog(@"%@",pyPath);
	
	
	[pyProg setStandardOutput:outPipe];
	[pyProg setStandardInput:inPipe];
	[pyProg setLaunchPath:pyPath];
	//[pyProg setLaunchPath:@"/Users/jethro/Progrmy/NSTaskTest/build/Debug/repeater.py"];
	[pyProg setArguments:pyArgs];
	[pyProg launch];
	
	
	// Show the window
	[self showWindow:nil];
}

// CSGCamera delegate

- (void)camera:(CSGCamera *)aCamera didReceiveFrame:(CSGImage *)aFrame;
{
	if (mode=='n') return;
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
	origbuffer[maxScoreIndex]=0;
	origbuffer[maxScoreIndex+1]=0;
	origbuffer[maxScoreIndex+2]=0;
	NSSize souradnice;
	souradnice=[self getPixelCoordinatesAtIndex:maxScoreIndex];
	xout=(int)souradnice.width;
	yout=(int)souradnice.height;
	printf("x=%d, y=%d\n",xout,yout);
	//printf("msindex=%d\n",maxScoreIndex);
	[cameraView setImage:aFrame];
	if (mode='c') {
		[pyIn writeData:[self makeDataFromInt:xout]];
		[self writeSep];
		[pyIn writeData:[self makeDataFromInt:yout]];
		[self writeLF];
	}else if (mode='g') {
		[pyIn writeData:[self makeDataFromInt:xout]];
		[self writeSep];
		[pyIn writeData:[self makeDataFromInt:yout]];
		[self writeLF];
	}
	printf("%c\n",mode);
	mode='n';
	
	printf("%c\n",mode);
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

-(NSSize)getPixelCoordinatesAtIndex:(int)index
{
	NSSize souradnice;
	souradnice.width=(int)(index%((int)size.width*4))/4;
	souradnice.height=(int)(index/(size.width*4));
	return souradnice;
}

-(void)modeSetter:(NSNotification *)aNotification
{
	printf("Prisla zadost\n");
	NSFileHandle * fileHandle;
	fileHandle =(NSFileHandle *) [aNotification object];
	NSData * aData;
	aData = [fileHandle availableData];
	unsigned char * znaky;
	znaky =(unsigned char *) [aData bytes];
	if (sizeof(znaky)==0) {
		return;
	}
	printf("Prisel znak %c s kodem %d\n",znaky[0],znaky[0]);
	switch (znaky[0]) {
		case 'g':
			mode='g';
			break;
		case 'c':
			mode='c';
			break;
		default:
			NSLog(@"Prijat chybny znak");
			break;
	}
	[fileHandle waitForDataInBackgroundAndNotify];



}

-(void)writeLF
{
	unsigned char lf;
	lf='\n';
	[pyIn writeData:[NSData dataWithBytes:&lf length:1] ];

}

-(void)writeSep
{
	unsigned char sep;
	sep=',';
	[pyIn writeData:[NSData dataWithBytes:&sep length:1] ];
	
}

-(NSData *)makeDataFromInt:(int)cislo
{
	NSString * string = [NSString stringWithFormat:@"%d",cislo];
	NSLog(@"\n String=%@\n",string);
	NSData *myData=[string dataUsingEncoding:NSUTF8StringEncoding];
	return myData;
}
@end

