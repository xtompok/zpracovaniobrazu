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

@interface ZOCalibrate : NSObject {
	
	ZOProcessImage * procImage;
	
	NSSize size;
	NSImage * lastImage;
	
	ZOPoint * ulCalPoint;
	ZOPoint * urCalPoint;
	ZOPoint * llCalPoint;
	ZOPoint * lrCalPoint;
	
	NSTimer * calTimer;
	NSArray * calPointsArray;
	int calPointsArrayIndex;

}

-(id)initWithSize:(NSSize)aSize;
-(void)calibrate;
-(void)setLastImage:(NSImage *)anImage;
-(NSArray *)someCalibrationArray;
-(NSString *)description;
-(void)setMinValues:(int *)minValues;
-(void)setMaxValues:(int *)maxValues;
-(void)setMinSumValues:(int *)minSumValues;


@end
