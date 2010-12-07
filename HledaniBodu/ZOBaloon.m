//
//  ZOBaloon.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOBaloon.h"

@implementation ZOBaloon

@synthesize shots;
@synthesize color;


-(id)initWithOrigin:(NSPoint) anOrigin 
			 Radius:(float) aRadius 
			  Speed:(float)aSpeed
		   andColor:(NSColor *)aColor
{
	if (![super init])
		return nil;
	origin.x = anOrigin.x;
	origin.y = anOrigin.y;
	
	speed = aSpeed;
	radius = aRadius;
	
	color = aColor;
	
	shape = [[NSBezierPath alloc] init];
	[shape appendBezierPathWithOvalInRect:NSMakeRect(0,0, 2*radius, 2*radius)];
	return self;
	
}

-(void)move
{
	origin.y+=speed;
}

-(NSBezierPath *)balloonPath
{

	NSAffineTransform * shift;
	shift = [NSAffineTransform transform];
	[shift translateXBy:origin.x yBy:origin.y];
	return [shift transformBezierPath:shape];
}
-(void)shooted
{
	shots++;
}
@end
