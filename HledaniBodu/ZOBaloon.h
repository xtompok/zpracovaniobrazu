//
//  ZOBaloon.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOBaloon : NSObject {
	NSPoint origin;
	float speed;
	NSColor * color;
	float radius;
}
-(id)initWithOrigin:(NSPoint) anOrigin Radius:(float) aRadius andSpeed:(float)aSpeed;
-(void)move;
-(NSBezierPath *)balloonPath;

@end
