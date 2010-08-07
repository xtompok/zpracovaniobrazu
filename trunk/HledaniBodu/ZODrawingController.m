//
//  ZODrawingController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 19.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZODrawingController.h"


@implementation ZODrawingController

-(id)init
{
	if (![super init])
		return nil;
	NSLog(@"Drawing Controller initialized");
	return self;
}

-(IBAction)widthSliderMoved:(id) sender
{
	[widthField setIntValue:[sender intValue]];
	[drawView setLineWidth:[sender intValue]];
}
-(void)setPoint1:(NSPoint)aPoint
{
	[drawView setPoint1:aPoint];
	[drawView setNeedsDisplay:YES];

}
-(void)setPoint2:(NSPoint)aPoint
{
	[drawView setPoint2:aPoint];
	[drawView setNeedsDisplay:YES];

}
// Resets drawing
-(IBAction)resetDrawing:(id)sender
{
	[drawView resetDrawing];
}

// Cleanup before end
- (void)windowWillClose:(NSNotification *)notification;
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
		
		[drawPanel setFrame:screeenRect display: YES];
		[projWindow setContentView:[drawPanel contentView]];
		
		
	}	
}

-(void)leftFullscreen
{
	[projWindow orderOut:self];
}
@end
