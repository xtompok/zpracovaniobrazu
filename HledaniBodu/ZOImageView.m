//
//  ZOImageView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOImageView.h"


@implementation ZOImageView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void)setCalPoints:(NSArray *)anArray
{
	if ([anArray count]==4) {
		[calPoints release];
		calPoints = [NSArray arrayWithArray:anArray ];
	}
}

-(void)setAnImage:(NSImage *)anImage
{
	[image release];
	image=anImage;
}

-(void)setPoint:(NSPoint)aPoint
{
	point.x = aPoint.x*[self bounds].size.width;
	point.y = aPoint.y*[self bounds].size.height;
}

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

- (void)drawRect:(NSRect)rect
{
	NSLog(@"Starting drawing!");
	// setup basics
	[[NSColor grayColor] set];
	NSRectFill ( [self bounds] );
	
	//[image compositeToPoint:NSMakePoint(0,0)
	//			  operation:NSCompositeSourceOver];
	
	[[NSColor redColor ] set];
	[[self crossAtPoint:point] stroke ];
}

- (BOOL)isFlipped
{
	return YES;
}

@end
