//
//  ZOMultiColorDrawingController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.10.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOMultiColorDrawingController.h"


@implementation ZOMultiColorDrawingController


@synthesize blueWidth;
@synthesize greenWidth;
@synthesize yellowWidth;

-(id)init
{
	if (![super init])
		return nil;

	NSLog(@"Drawing Controller initialized");
	return self;
}


// Using Key-Value coding to control from GUI


-(void)setBlueWidth:(float)aWidth
{
	blueWidth=aWidth;
	[drawView setBlueLineWidth:aWidth];
}
-(void)setGreenWidth:(float)aWidth
{
	greenWidth=aWidth;
	[drawView setGreenLineWidth:aWidth];
}
-(void)setYellowWidth:(float)aWidth
{
	yellowWidth=aWidth;
	[drawView setYellowLineWidth:aWidth];
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
	NSLog(@"Drawing controller went fullscreen");
	
}

-(void)leftFullscreen
{
	[projWindow orderOut:self];
}

-(void)showSettingsWindow
{
	[self showWindow:nil];
}

-(NSString *)generateString
{
	return [NSString stringWithFormat:@"%@\n%@\n%@",
			[[drawView pathArray] objectAtIndex:0],
			[[drawView pathArray] objectAtIndex:1],
			[[drawView pathArray] objectAtIndex:2]];
}


-(IBAction)saveBezier:(id)sender
{
	NSSavePanel *sp;
	int runResult;
	
	/* create or get the shared instance of NSSavePanel */
	sp = [NSSavePanel savePanel];
	
	/* display the NSSavePanel */
	runResult = [sp runModalForDirectory:NSHomeDirectory() file:@""];
	
	/* if successful, save file under designated name */
	if (runResult == NSOKButton) {
		if (![[self generateString]
			  writeToFile:[sp filename] atomically:YES encoding:NSUTF8StringEncoding error:nil])
		{}
	}
	NSLog(@"Drawing saved.");
	
}


@end
