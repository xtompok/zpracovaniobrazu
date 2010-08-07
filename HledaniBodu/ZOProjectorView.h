//
//  ZOProjectorView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"


@interface ZOProjectorView : NSView {
	NSPoint point1,point2;
	bool drawing;

}

-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;
-(void)setPoint1:(NSPoint)aPoint;
-(void)setPoint2:(NSPoint)aPoint;

@end
