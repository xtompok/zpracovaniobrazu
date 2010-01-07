//
//  TestController.m
//  SequenceGrabberTest
//
//  Created by Tim Omernick on 3/18/05.
//  Copyright 2005 Tim Omernick. All rights reserved.
//

#import "TestController.h"

#import <CocoaSequenceGrabber/CocoaSequenceGrabber.h>

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
	[camera startWithSize:NSMakeSize(640, 480)];
	
	// Make sure we don't distort the video as the user resizes the window
	NSWindow *window = [self window];
	[window setAspectRatio:[window frame].size];
	
	// Show the window
	[self showWindow:nil];
}

// CSGCamera delegate

- (void)camera:(CSGCamera *)aCamera didReceiveFrame:(CSGImage *)aFrame;
{
	[cameraView setImage:aFrame];
}

// NSWindow delegate

- (void)windowWillClose:(NSNotification *)notification;
{
	[camera stop];
}

@end
