//
//  ZOShootingView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOBaloon.h"



@interface ZOShootingView : NSView {
	int width;
	int height;
	
	NSPoint point1;
	NSPoint point2;
	
	int maxLost;
	float maxSpeed;
	int numBalloons;
	NSMutableArray *balloonsArray;
	
	NSTimer *timer;

}
-(void)resetGame;
-(float)randFrom:(float)a to:(float)b;
-(void)setPoint1:(NSPoint) aPoint;
-(void)setPoint2:(NSPoint)aPoint;

-(void)timerExpired:(NSTimer *)aTimer;

@end
