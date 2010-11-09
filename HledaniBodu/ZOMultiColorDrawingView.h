//
//  ZOMultiColorDrawingView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.10.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOMultiColorDrawingView : NSView {

	NSArray * pathArray;
	
	NSPoint point1;
	NSPoint point2;
	bool drawing;
	
	float blueLineWidth;
	float greenLineWidth;
	float yellowLineWidth;
	
	int pathIndex;
	
	NSRect blueColorRect;
	NSRect greenColorRect;
	NSRect yellowColorRect;
	NSRect resetRect;
	NSRect pauseRect;
	
	int resetCountdown;
	bool paused;
	bool onPaused;
	
}

-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;
-(void)setPoint1:(NSPoint)aPoint;
-(void)setPoint2:(NSPoint)aPoint;
-(void)resetDrawing;

@property float blueLineWidth;
@property float greenLineWidth;
@property float yellowLineWidth;


@property (readonly) NSArray * pathArray;

@end
