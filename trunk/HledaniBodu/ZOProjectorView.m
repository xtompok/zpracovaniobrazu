//
//  ZOProjectorView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProjectorView.h"


@implementation ZOProjectorView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        calPointSize=20;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor blackColor] set];
	NSRectFill ( [self bounds] );
	
	switch (calPoint) {
		case 1:
			[[NSColor whiteColor] set];
			NSRectFill(NSMakeRect(0,
								  0,
								  calPointSize,  calPointSize));
			break;
		case 2:
			[[NSColor whiteColor] set];
			NSRectFill(NSMakeRect([self bounds].size.width-calPointSize,
								  0,
								  calPointSize,  calPointSize));
			break;
		case 3:
			[[NSColor whiteColor] set];
			NSRectFill(NSMakeRect([self bounds].size.width-calPointSize,
								  [self bounds].size.height-calPointSize,
								  calPointSize,  calPointSize));
			break;
		case 4:
			[[NSColor whiteColor] set];
			NSRectFill(NSMakeRect(0,
								  [self bounds].size.height-calPointSize,
								  calPointSize,  calPointSize));
			break;
		default:
			[[NSColor whiteColor ] set];
			[[self crossAtPoint:point1] stroke ];
			
			[[NSColor yellowColor ] set];
			[[self crossAtPoint:point2] stroke ];
			break;
	}
}

-(void)setPoint1:(NSPoint)aPoint
{
	point1.x = aPoint.x*[self bounds].size.width;
	point1.y = aPoint.y*[self bounds].size.height;
}

-(void)setPoint2:(NSPoint)aPoint
{
	point2.x = aPoint.x*[self bounds].size.width;
	point2.y = aPoint.y*[self bounds].size.height;
}

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
-(void)setCalPoint:(int)index
{
	calPoint=index;
	[self setNeedsDisplay:YES];
}

- (BOOL)isFlipped
{
	return YES;
}

@end
