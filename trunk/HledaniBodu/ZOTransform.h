//
//  ZOTransform.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 13.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOTransform : NSObject {
	double PTK[4][2]; //Pomocné pole transformačních konstant pro poměrovou transformaci
	NSSize size;

}

-(id)initWithCalibrationArray:(int *)calArray andSize:(NSSize)aSize;
-(NSPoint)transformPoint:(NSPoint)point;
-(double)getRightRootOfPolynomWithA:(double)a B:(double)b andC:(double)c;

@end
