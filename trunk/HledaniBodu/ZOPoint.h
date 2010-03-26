//
//  ZOPoint.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 5.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOPoint : NSObject {
	//NSPoint point;
	float x;
	float y;
}

-(id)initWithPoint:(NSPoint)aPoint;
-(NSPoint)pointValue;
-(void)setPoint:(NSPoint)aPoint;
-(NSString *)description;

@property float x;
@property float y;


@end
