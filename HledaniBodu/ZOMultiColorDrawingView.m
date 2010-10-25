//
//  ZOMultiColorDrawingView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.10.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOMultiColorDrawingView.h"


@implementation ZOMultiColorDrawingView

@synthesize blueLineWidth;
@synthesize greenLineWidth;
@synthesize yellowLineWidth;

@synthesize pathArray;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) 
	{
		
		pathArray = [[NSArray alloc] initWithObjects:
					 [[NSBezierPath alloc] init],
					 [[NSBezierPath alloc] init],
					 [[NSBezierPath alloc] init],
					 nil];
		pathIndex = 1;
		
		blueLineWidth = 1;
		greenLineWidth = 1;
		yellowLineWidth = 1;
		
		int i;
		for(i=0;i<[pathArray count];i++)
		{
			[[pathArray objectAtIndex:i] moveToPoint:NSMakePoint(0,0)];
		}
		
		blueColorRect = NSMakeRect(20, 20, 40, 40);
		greenColorRect = NSMakeRect(20, 80, 40, 40);
		yellowColorRect = NSMakeRect(20, 140, 40, 40);
		
		NSLog(@"Projector drawing View initialized");
		
		return self;
	} else 
	{
		return nil;
	}
	
	
}

// Drawing
- (void)drawRect:(NSRect)dirtyRect {
	// Background
    [[NSColor blackColor] set];
	NSRectFill ( [self bounds] );
	
	// First point
	[[NSColor whiteColor ] set];
	[[self crossAtPoint:point1] stroke ];
	
	// Second point
	[[NSColor yellowColor ] set];
	[[self crossAtPoint:point2] stroke ];

	
	// Blue color
	
	[[[NSColor blueColor] shadowWithLevel:0.5] set];
	NSRectFill(blueColorRect);
	[[NSColor blueColor] set];
	[[pathArray objectAtIndex:0] setLineWidth:blueLineWidth];
	[[pathArray objectAtIndex:0] stroke];
	
	// Green color
	
	[[[NSColor greenColor] shadowWithLevel:0.5] set];
	NSRectFill(greenColorRect);
	[[NSColor greenColor] set];
	[[pathArray objectAtIndex:1] setLineWidth:greenLineWidth];
	[[pathArray objectAtIndex:1] stroke];
	
	// Yellow 
	
	[[[NSColor yellowColor] shadowWithLevel:0.5] set];
	NSRectFill(yellowColorRect);
	[[NSColor yellowColor] set];
	[[pathArray objectAtIndex:2] setLineWidth:yellowLineWidth];
	[[pathArray objectAtIndex:2] stroke];
	
	
	
}

-(void)setPoint1:(NSPoint)aPoint
{
	point1.x = aPoint.x*[self bounds].size.width;
	point1.y = aPoint.y*[self bounds].size.height;
	
	if (NSPointInRect(point1, blueColorRect)) {
		pathIndex = 0;
		drawing = NO;
	} else if (NSPointInRect(point1, greenColorRect)) {
		pathIndex = 1;
		drawing = NO;
	} else if (NSPointInRect(point1, yellowColorRect)) {
		pathIndex = 2;
		drawing = NO;
	}
	
	// If point wasn't found, end the path
	if ((point1.x==0)&&(point1.y==0))
	{
		drawing = NO;
	} 
	else 
	{	// If the point was found, jump to it and start drawing
		if (drawing == NO)
		{
			[[pathArray objectAtIndex:pathIndex] moveToPoint:point1];
			drawing = YES;
		} // Or draw to next point
		else {
			[[pathArray objectAtIndex:pathIndex] lineToPoint:point1];
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

/*-(void)setWidth:(int)aWidth
{
	lineWidth = aWidth;
}
*/
-(void)resetDrawing
{
	NSLog(@"Reseting Drawing");
	int i;

	[pathArray release];
	
	pathArray = [[NSArray alloc] initWithObjects:
				 [[NSBezierPath alloc] init],
				 [[NSBezierPath alloc] init],
				 [[NSBezierPath alloc] init],
				 nil];
	
	
	for (i=0;i<[pathArray count];i++)
	{
		[[pathArray objectAtIndex:i] moveToPoint:NSMakePoint(0, 0)];
	}	
	drawing=NO;
}

- (BOOL)isFlipped
{
	return YES;
}
@end