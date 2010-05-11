//
//  ZOProjectorView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProjDrawingView.h"


@implementation ZOProjDrawingView

-(void)awakeFromNib {
	calPointSize=20;
	pointArray	= [[NSMutableArray alloc]init];
	NSLog(@"Awaken View!");
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        calPointSize=20;
		pointArray	= [[NSMutableArray alloc]init];
    }
	
    return self;
	
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor blackColor] set];
	NSRectFill ( [self bounds] );
	
	switch (calPoint) {
		case 1:
			[[NSColor redColor] set];
			NSRectFill(NSMakeRect(0,
								  0,
								  calPointSize,  calPointSize));
			break;
		case 2:
			[[NSColor redColor] set];
			NSRectFill(NSMakeRect([self bounds].size.width-calPointSize,
								  0,
								  calPointSize,  calPointSize));
			break;
		case 3:
			[[NSColor redColor] set];
			NSRectFill(NSMakeRect([self bounds].size.width-calPointSize,
								  [self bounds].size.height-calPointSize,
								  calPointSize,  calPointSize));
			break;
		case 4:
			[[NSColor redColor] set];
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
	
	
	NSUInteger i;
	NSPoint aPoint;
	NSBezierPath * aPath;
	aPath = [NSBezierPath bezierPath];
	[aPath moveToPoint:NSMakePoint(0, 0)];
	
	if ([pointArray count]==0) return;
	
	for (i=0; i< [pointArray count]; i++)
	{
		aPoint.x=[[pointArray objectAtIndex:i] x];
		aPoint.y=[[pointArray objectAtIndex:i] y];
		if ((aPoint.x==0)&&(aPoint.y==0))
		{
			drawing = NO;
		} 
		else 
		{
			if (drawing == NO)
			{
				[aPath moveToPoint:aPoint];
				drawing = YES;
			}
			else {
				[aPath lineToPoint:aPoint];
			}

		}
	}
	[[NSColor greenColor] set];
	[aPath stroke];

}

-(void)setPoint1:(NSPoint)aPoint
{
	point1.x = aPoint.x*[self bounds].size.width;
	point1.y = aPoint.y*[self bounds].size.height;
	
	[pointArray addObject:[[ZOPoint alloc]initWithPoint:point1]];
	
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

-(void)setCalPoint:(int)index
{
	calPoint=index;
	[self setNeedsDisplay:YES];
}

-(void)resetDrawing
{
	NSLog(@"Reseting Drawing");
	[pointArray removeAllObjects];
}

- (BOOL)isFlipped
{
	return YES;
}

@end
