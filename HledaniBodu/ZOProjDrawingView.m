//
//  ZOProjectorView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProjDrawingView.h"


@implementation ZOProjDrawingView

@synthesize lineWidth;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		drawedPath = [[NSBezierPath alloc] init];
		[drawedPath moveToPoint:NSMakePoint(0, 0)];
    }
	
	NSLog(@"Projector drawing View initialized");
	
    return self;
	
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor blackColor] set];
	NSRectFill ( [self bounds] );
	
	[[NSColor whiteColor ] set];
	[[self crossAtPoint:point1] stroke ];
	
	[[NSColor yellowColor ] set];
	[[self crossAtPoint:point2] stroke ];
	
	[[NSColor greenColor] set];
	[drawedPath setLineWidth:lineWidth];
	[drawedPath stroke];

}

-(void)setPoint1:(NSPoint)aPoint
{
	point1.x = aPoint.x*[self bounds].size.width;
	point1.y = aPoint.y*[self bounds].size.height;
	
	if ((point1.x==0)&&(point1.y==0))
	{
		drawing = NO;
	} 
	else 
	{
		if (drawing == NO)
		{
			[drawedPath moveToPoint:point1];
			drawing = YES;
		}
		else {
			[drawedPath lineToPoint:point1];
		}
		
	}
	
	[self setNeedsDisplay:YES];
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

-(void)setWidth:(int)aWidth
{
	lineWidth = aWidth;
}

-(void)resetDrawing
{
	NSLog(@"Reseting Drawing");
	[drawedPath release];
	drawedPath = [[NSBezierPath alloc] init];
	[drawedPath moveToPoint:NSMakePoint(0, 0)];
	drawing=NO;
}

- (BOOL)isFlipped
{
	return YES;
}

@end
