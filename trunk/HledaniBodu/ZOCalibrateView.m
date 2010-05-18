//
//  ZOCalibrateView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOCalibrateView.h"


@implementation ZOCalibrateView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		calPointSize=10;
		calPoint=-1;
	}
	
	NSLog(@"Calibration View initialized");
	
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor blackColor] set];
	NSRectFill ( [self bounds] );
		
	// Draw calibration points
	switch (calPoint) {
		case 0:
			[[NSColor redColor] set];
			NSRectFill(NSMakeRect(0,
								  0,
								  calPointSize,  calPointSize));
			break;
		case 1:
			[[NSColor redColor] set];
			NSRectFill(NSMakeRect([self bounds].size.width-calPointSize,
								  0,
								  calPointSize,  calPointSize));
			break;
		case 2:
			[[NSColor redColor] set];
			NSRectFill(NSMakeRect([self bounds].size.width-calPointSize,
								  [self bounds].size.height-calPointSize,
								  calPointSize,  calPointSize));
			break;
		case 3:
			[[NSColor redColor] set];
			NSRectFill(NSMakeRect(0,
								  [self bounds].size.height-calPointSize,
								  calPointSize,  calPointSize));
			break;
	}
}

// Sets calibration point or 0
-(void)setCalPoint:(int)index
{
	calPoint=index;
	[self setNeedsDisplay:YES];
}

// x axis is flipped
- (BOOL)isFlipped
{
	return YES;
}

@end
