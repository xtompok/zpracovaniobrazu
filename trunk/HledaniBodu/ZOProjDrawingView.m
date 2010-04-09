//
//  ZOProjectorView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProjDrawingView.h"


@implementation ZOProjDrawingView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        calPointSize=20;
		myMutaryOfBrushStrokes	= [[NSMutableArray alloc]init];
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
	
	if ([myMutaryOfBrushStrokes count] == 0) {
		return;
	} // end if
	
	 
	 // This is Quartz	
	 NSGraphicsContext	*	tvarNSGraphicsContext	= [NSGraphicsContext currentContext];
	 CGContextRef			tvarCGContextRef		= (CGContextRef) [tvarNSGraphicsContext graphicsPort];
	 
	 NSUInteger tvarIntNumberOfStrokes	= [myMutaryOfBrushStrokes count];
	 
	 NSUInteger i;
	 for (i = 0; i < tvarIntNumberOfStrokes; i++) {
	 
	 CGContextSetRGBStrokeColor(tvarCGContextRef,0,255,0,128);
	 CGContextSetLineWidth(tvarCGContextRef, (3.0) );
	 
	 myMutaryOfPoints	= [myMutaryOfBrushStrokes objectAtIndex:i];
	 
	 NSUInteger tvarIntNumberOfPoints	= [myMutaryOfPoints count];				// always >= 2
	 ZOPoint * tvarLastPointObj			= [myMutaryOfPoints objectAtIndex:0];
	 CGContextBeginPath(tvarCGContextRef);
	 CGContextMoveToPoint(tvarCGContextRef,[tvarLastPointObj x],[tvarLastPointObj y]);
	 
	 NSUInteger j;
	 for (j = 1; j < tvarIntNumberOfPoints; j++) {  // note the index starts at 1
	 ZOPoint * tvarCurPointObj			= [myMutaryOfPoints objectAtIndex:j];
	 CGContextAddLineToPoint(tvarCGContextRef,[tvarCurPointObj x],[tvarCurPointObj y]);	
	 } // end for
	 
	 CGContextDrawPath(tvarCGContextRef,kCGPathStroke);
	 
	 } // end for
}

-(void)setPoint1:(NSPoint)aPoint
{
	//NSLog(@"X: %f, Y:%f",aPoint.x,aPoint.y);
	point1.x = aPoint.x*[self bounds].size.width;
	point1.y = aPoint.y*[self bounds].size.height;
	if ((point1.x==0)&&(point1.y==0)) 
	{
		drawing=NO;
	} else 
	{
		if (!drawing) 
		{
			myMutaryOfPoints	= [[NSMutableArray alloc]init];
			[myMutaryOfBrushStrokes addObject:myMutaryOfPoints];
		}
		drawing=YES;
	}
	if (drawing)
	{
		ZOPoint * tvarMyPointObj		= [[ZOPoint alloc]initWithPoint:point1];
		
		[myMutaryOfPoints addObject:tvarMyPointObj];
	}
	//printf("%d drawing",drawing);
	
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
	[myMutaryOfBrushStrokes release];
	myMutaryOfBrushStrokes	= [[NSMutableArray alloc]init];
}

- (BOOL)isFlipped
{
	return YES;
}

@end
