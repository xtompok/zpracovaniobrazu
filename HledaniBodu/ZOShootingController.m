//
//  ZOShootingController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOShootingController.h"


@implementation ZOShootingController

@synthesize numBalloons;
@synthesize maxLost;
@synthesize maxSpeed;


-(id)init
{
	if (![super init])
		return nil;
	
	NSLog(@"Shooting Controller initialized");
	return self;
}


-(void)setPoint1:(NSPoint)aPoint
{
	[shootView setPoint1:aPoint];
}
-(void)setPoint2:(NSPoint)aPoint
{
	[shootView setPoint2:aPoint];
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
		
		[shootPanel setFrame:screeenRect display: YES];
		[projWindow setContentView:[shootPanel contentView]];
	}
		
}
-(void)leftFullscreen
{
	[projWindow orderOut:self];
}
-(void)showSettingsWindow
{
}



@end
