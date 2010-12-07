//
//  ZOBaloon.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOBaloon.h"


@implementation ZOBaloon
-(id)initWithOrigin:(NSPoint) anOrigin 
			 Radius:(float) aRadius 
		   andSpeed:(float)aSpeed
{
	if (![super init])
		return nil;
	origin.x = anOrigin.x;
	origin.y = anOrigin.y;
	speed = aSpeed;
	radius = aRadius;
	
	return self;
	
}

-(void)move
{
	origin.y+=speed;
}

-(NSBezierPath *)balloonPath
{

	return [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(origin.x, origin.y, 2*radius, 2*radius)];
}
@end
