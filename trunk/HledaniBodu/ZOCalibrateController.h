//
//  ZOCalibrateController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOCalibrateView.h"
#import "ZOPoint.h"
#import "ZOCalibrationData.h"


@interface ZOCalibrateController : NSWindowController {
	
	ZOCalibrationData * calData;
	
	NSPoint point;
	NSSize size;
	
	ZOPoint * ulCalPoint;
	ZOPoint * urCalPoint;
	ZOPoint * llCalPoint;
	ZOPoint * lrCalPoint;
	
	NSTimer * calTimer;
	float calTime;
	int calPointsArrayIndex;
	
	NSArray * calPointsArray;
	int maxRed;
	int maxGreen;
	int maxBlue;
	
	NSWindow *calWindow;
	
	IBOutlet NSPanel *calPanel;
	IBOutlet ZOCalibrateView *calView;
}

-(void)setSize:(NSSize)aSize;
-(void)calibrate;

-(NSString *)description;

-(NSArray *)calibrationArray;
-(ZOCalibrationData *)calibrationData;

@property NSPoint point;

@end
