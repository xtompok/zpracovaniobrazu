//
//  ZOProjectorController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 19.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProjectorController.h"


@implementation ZOProjectorController
-(id)init
{
	if (![super init])
		return nil;
	return self;
}

-(void)setPoint1:(NSPoint)aPoint
{
	[projView setPoint1:aPoint];
	[projView setNeedsDisplay:YES];
	
}
-(void)setPoint2:(NSPoint)aPoint
{
	[projView setPoint2:aPoint];
	[projView setNeedsDisplay:YES];
	
}

// Cleanup before end
- (void)windowWillClose:(NSNotification *)notification;
{
	[projWindow orderOut:self];
}

-(void)leftFullscreen
{
	[projWindow orderOut:self];
}

-(void)goFullscreen
{
	int windowLevel;
	NSRect screeenRect;
	NSScreen *aScreen;
	
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

		[projPanel setFrame:screeenRect display: YES];
		[projWindow setContentView:[projPanel contentView]];
		
		
	}	
	NSLog(@"Projector controller went fullscreen");
}

-(void)showSettingsWindow
{}

@end
