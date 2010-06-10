//
//  ZOProjectorView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProjectorView.h"


@implementation ZOProjectorView

// Initializes and sets size of calibration points
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
	
	NSLog(@"Projector View initialized");
	
    return self;
}

// Draws to projector
- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor blackColor] set];
	NSRectFill ( [self bounds] );
	
	// Draw calibration points if not 0
	[[NSColor whiteColor ] set];
	[[self crossAtPoint:point1] stroke ];
	
	[[NSColor yellowColor ] set];
	[[self crossAtPoint:point2] stroke ];
	
}

// Sets first point to draw
-(void)setPoint1:(NSPoint)aPoint
{
	point1.x = aPoint.x*[self bounds].size.width;
	point1.y = aPoint.y*[self bounds].size.height;
}

// Sets second point to draw
-(void)setPoint2:(NSPoint)aPoint
{
	point2.x = aPoint.x*[self bounds].size.width;
	point2.y = aPoint.y*[self bounds].size.height;
}

// Draws cross at set coordinates
-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint
{
	int r;
	r=10;
	NSBezierPath *aPath;
	aPath=[NSBezierPath bezierPath];
	[aPath moveToPoint:NSMakePoint(aPoint.x-r, aPoint.y-r)];
	[aPath lineToPoint:NSMakePoint(aPoint.x+r, aPoint.y+r)];
	[aPath moveToPoint:NSMakePoint(aPoint.x-r, aPoint.y+r)];
	[aPath lineToPoint:NSMakePoint(aPoint.x+r, aPoint.y-r)];
	return aPath;
}

// x axis is flipped
- (BOOL)isFlipped
{
	return YES;
}

@end
