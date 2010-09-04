//
//  ZODrawingController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 19.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZODrawingController.h"


@implementation ZODrawingController

@synthesize width;

-(id)init
{
	if (![super init])
		return nil;
	NSLog(@"Drawing Controller initialized");
	return self;
}


// Using Key-Value coding to control from GUI
-(void)setWidth:(float)aWidth
{
	width=aWidth;
	[drawView setLineWidth:aWidth];
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

-(IBAction)saveBezier:(id)sender
{
	NSSavePanel *sp;
	int runResult;
	
	/* create or get the shared instance of NSSavePanel */
	sp = [NSSavePanel savePanel];
	
	/* set up new attributes */
	//[sp setAccessoryView:drawView];
	//[sp setRequiredFileType:@"txt"];
	
	/* display the NSSavePanel */
	runResult = [sp runModalForDirectory:NSHomeDirectory() file:@""];
	
	/* if successful, save file under designated name */
	if (runResult == NSOKButton) {
		if (![[[drawView drawedPath] description] writeToFile:[sp filename] atomically:YES encoding:NSUTF8StringEncoding error:nil])
			NSBeep();
	}
	NSLog(@"Drawing saved.");

}

@end
