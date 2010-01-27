//
//  ZO2PointTransform.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 27.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZO2PointTransform : NSObject {
	NSSize size;
	NSPoint PTB[2];
	double PTD[2];
	NSPoint CP[4];
	double g,h,m,n;

}

-(id)initWithCalibrationArray:(int *)calArray andSize:(NSSize)aSize;
-(NSPoint)transformPoint:(NSPoint)point;

@end
