//
//  ZOPoint.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 5.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOPoint : NSObject {
	NSPoint point;

}

-(id)initWithPoint:(NSPoint)aPoint;
-(double)xValue;
-(double)yValue;
-(NSPoint)pointValue;
-(void)setPoint:(NSPoint)aPoint;
-(void)setX:(double)theX;
-(void)setY:(double)theY;



@end
