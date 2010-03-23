//
//  ZOCalibrate.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 23.3.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"
#import "ZOProjectorView.h"
#import "ZOProcessImage.h"

@interface ZOCalibrate : NSObject {
	
	ZOProjectorView * projView;
	ZOProcessImage * procImage;
	
	ZOPoint * ulCalPoint;
	ZOPoint * urCalPoint;
	ZOPoint * llCalPoint;
	ZOPoint * lrCalPoint;
	
	NSSize size;
	NSImage * lastImage;
	
	NSTimer * calTimer;
	int calPointsArrayIndex;
	NSArray * calPointsArray;

}

-(id)initWithProjectorView:(ZOProjectorView *) aView andSize:(NSSize)aSize;
-(void)calibrate;
-(void)setLastImage:(NSImage *)anImage;
//-(NSArray *)calibrationArray;


@end
