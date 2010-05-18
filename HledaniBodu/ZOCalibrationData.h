//
//  ZOCalibrationData.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 14.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOCalibrationData : NSObject {
	NSArray *calPointsArray;
	int maxR;
	int maxG;
	int maxB;
	
}
-(id)initWithCalArray:(NSArray *) anArray 
			   maxRed:(int) aRed 
				Green:(int) aGreen 
			  andBlue:(int) aBlue;
-(NSArray *)calPointsArray;
@property(readonly) int maxR;
@property(readonly) int maxG;
@property(readonly) int maxB;


@end
