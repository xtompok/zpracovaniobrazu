//
//  TestController.m
//  SequenceGrabberTest
//
//  Created by Tim Omernick on 3/18/05.
//  Copyright 2005 Tim Omernick. All rights reserved.
//

#import "TestController.h"

#import <CocoaSequenceGrabber/CocoaSequenceGrabber.h>
#import "zpracovani.h"

@implementation TestController

// Init and dealloc

- (void)dealloc;
{
	[camera release];
	
	[super dealloc];
}

- (void)awakeFromNib;
{
	// Start recording
	camera = [[CSGCamera alloc] init];
	[camera setDelegate:self];
	[camera startWithSize:NSMakeSize(320, 240)];
	
	size.height=240;
	size.width=320;
	//outputbuffer=malloc(sizeof(char)*320*240*4);

	// Make sure we don't distort the video as the user resizes the window
	NSWindow *window = [self window];
	[[window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
	[[window standardWindowButton:NSWindowZoomButton] setHidden:YES];
	[[window standardWindowButton:NSWindowCloseButton] setHidden:YES];
	NSColor*	translucent = [NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.6] ;
	[window setBackgroundColor:translucent];
	[window setAspectRatio:[window frame].size];
	
	
	
	// Show the window
	[self showWindow:nil];
}

// CSGCamera delegate

- (void)camera:(CSGCamera *)aCamera didReceiveFrame:(CSGImage *)aFrame;
{
	[cameraView setImage:aFrame];
	//NSArray * pole;
	//pole=;
	origRep = [[aFrame representations] lastObject];
	[origRep getBitmapDataPlanes:(unsigned char **)&origbuffer];
	
	int i;
	for(i=0;i<307200;i++)
	{
		outputbuffer[i]=origbuffer[i];
		/*if (((i+1)%4)!=0) {
			//outputbuffer[i]=255-outputbuffer[i];
			outputbuffer[i]%=50;
		}*/
	}
	
	pracImg = [[zpracovani alloc] initWithBuffer:outputbuffer withsize:size lenght:307200];
	[pracImg inverseColor];
	[pracImg moduleWithNumber:50];
	//zpracBuf=(unsigned char *)pracImg.buffer;
	
	//outputbufptr=&outputbuffer[0];
	outputbufptr=&pracImg.buffer[0];
	outrepptr=&outputbufptr;
	editRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:(unsigned char **)&outputbufptr//outrepptr 
						pixelsWide:(NSInteger)size.width 
						pixelsHigh:(NSInteger)size.height 
						bitsPerSample:8 
						samplesPerPixel:4
						hasAlpha:YES
						isPlanar:NO 
						colorSpaceName:NSCalibratedRGBColorSpace 
						bytesPerRow:320*4
						bitsPerPixel:32 ];
	editImage = [[NSImage alloc] initWithSize:size];
	[editImage addRepresentation:editRep];
	[editView setImage:editImage];
	[editImage release];
	[editRep release];
}

// NSWindow delegate

- (void)windowWillClose:(NSNotification *)notification;
{
	[camera stop];
}

@end
