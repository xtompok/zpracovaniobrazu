//
//  ZOImageView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
#import "ZOPoint.h"

#import "ZOImageView.h"


@implementation ZOImageView

// Initialize calPoints array
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		cp1 = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0)];
		cp2 = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0)];
		cp3 = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0)];
		cp4 = [[ZOPoint alloc] initWithPoint:NSMakePoint(0, 0)];
		
		calPoints = [[NSArray alloc] initWithObjects:
					 (ZOPoint *)cp1,
					 (ZOPoint *)cp2,
					 (ZOPoint *)cp3,
					 (ZOPoint *)cp4,
					 nil];
    }
    return self;
}

// Sets coalibration points
-(void)setCalPoints:(NSArray *)anArray
{
	int i;
	double x,y;
	if ([anArray count]==4)
	{

		for (i=0;i<4;i++)
		{
			x=[[anArray objectAtIndex:i] x]*[self bounds].size.width;
			y=[[anArray objectAtIndex:i] y]*[self bounds].size.height;
			[[calPoints objectAtIndex:i] setX:x];
			[[calPoints objectAtIndex:i] setY:y];
			
		} 	
	} else printf("Wrong array\n");

	
}

// Sets image for view
-(void)setAnImage:(NSImage *)anImage
{
	[image release];
	image=(NSImage *)anImage;
	[image retain];
}

// Sets a point where draw a cross
-(void)setPoint:(NSPoint)aPoint
{
	point.x = aPoint.x*[self bounds].size.width;
	point.y = aPoint.y*[self bounds].size.height;
}

// Returns path with cross
-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint
{
	int r;
	r=5;
	NSBezierPath *aPath;
	aPath=[NSBezierPath bezierPath];
	[aPath moveToPoint:NSMakePoint(aPoint.x-r, aPoint.y-r)];
	[aPath lineToPoint:NSMakePoint(aPoint.x+r, aPoint.y+r)];
	[aPath moveToPoint:NSMakePoint(aPoint.x-r, aPoint.y+r)];
	[aPath lineToPoint:NSMakePoint(aPoint.x+r, aPoint.y-r)];
	return aPath;
}

// Draws into view
- (void)drawRect:(NSRect)rect
{
	// Background
	[[NSColor grayColor] set];
	NSRectFill ( [self bounds] );
	
	// Image from camera
	[image compositeToPoint:NSMakePoint(0,[self bounds].size.height)
				  operation:NSCompositeSourceOver];
	
	
	// Lightest point
	[[NSColor redColor ] set];
	[[self crossAtPoint:point] stroke ];
	
	// Calibration points
	[[NSColor blueColor] set];
	int i;
	NSPoint aPoint;
	for(i=0;i<4;i++)
	{
		aPoint = [[calPoints objectAtIndex:i] pointValue];
		NSRectFill(NSMakeRect(aPoint.x, aPoint.y, 5, 5));
	}
}

// Coordinates are flipped
- (BOOL)isFlipped
{
	return YES;
}

@end
