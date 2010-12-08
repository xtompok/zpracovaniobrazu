//
//  ZOShootingView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOBaloon.h"

typedef struct {	
	int maxBalloons;
	float maxSpeed;
	int maxLost;
	float delay;
	int maxShots;
	int minSize;
	int maxiSize;
} GAMEDATA;

@interface ZOShootingView : NSView {
	int width;
	int height;
	
	NSPoint point1;
	NSPoint point2;
	
	int maxLost;
	float maxSpeed;
	int numBalloons;
	int maxShots;
	
	float delay;
	BOOL paused;
	
	int minSize;
	int maxiSize;
	
	NSMutableArray *balloonsArray;
	
	NSTimer *timer;
	
	NSColor * color;
	
	int lostBalloons;
	int score;

}
-(float)randFrom:(float)a to:(float)b;
-(void)setPoint1:(NSPoint) aPoint;
-(void)setPoint2:(NSPoint)aPoint;

-(void)resetGameWithData:(GAMEDATA *) aData;

-(void)timerExpired:(NSTimer *)aTimer;

-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;
-(void)setPaused:(BOOL) isPaused;

-(void)insertBalloonAtIndex:(int)i;
@end
