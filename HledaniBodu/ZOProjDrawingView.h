//
//  ZOProjectorView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"


@interface ZOProjDrawingView : NSView {
	NSMutableArray * pointArray;
	NSPoint point1;
	NSPoint point2;
	int calPoint;
	int calPointSize;
	bool drawing;
	int magic;
	bool nakresleno;
	
}

-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;
-(void)setPoint1:(NSPoint)aPoint;
-(void)setPoint2:(NSPoint)aPoint;
-(void)resetDrawing;

@end

