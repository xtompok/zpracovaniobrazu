//
//  ZOCalibrate.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 23.3.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"
#import "ZOProcessImage.h"
#import "ZOCalibrationData.h"

@interface ZOCalibrate : NSObject {
	
	ZOProcessImage * procImage;
	ZOCalibrationData * calData;
	
	NSSize size;
	NSImage * lastImage;
	
	ZOPoint * ulCalPoint;
	ZOPoint * urCalPoint;
	ZOPoint * llCalPoint;
	ZOPoint * lrCalPoint;
	
	NSTimer * calTimer;
	int calPointsArrayIndex;
	
	NSArray * calPointsArray;
	int maxRed;
	int maxGreen;
	int maxBlue;
}

-(id)initWithSize:(NSSize)aSize;
-(NSString *)description;

-(void)calibrate;
-(void)setLastImage:(NSImage *)anImage;
-(NSArray *)calibrationArray;

-(ZOCalibrationData *)calibrationData;

-(void)setMinValues:(int *)minValues;
-(void)setMaxValues:(int *)maxValues;
-(void)setMinSumValues:(int *)minSumValues;


@end
