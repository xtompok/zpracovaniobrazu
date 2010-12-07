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
	int shots;
	
	NSBezierPath * shape;
}
-(id)initWithOrigin:(NSPoint) anOrigin 
			 Radius:(float) aRadius 
			  Speed:(float)aSpeed 
		   andColor:(NSColor *)aColor;
-(void)move;
-(NSBezierPath *)balloonPath;
-(void)shooted;

@property int shots;
@property (assign) NSColor * color;
@end
