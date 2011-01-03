//
//  ZOCalibrateController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOCalibrateController
    @abstract   Controller for calibration
    @discussion This controller implements calibration of the camera. 
				It tells calibration view to show points, handles the
				timer and posts notification, when the calibration is
				completed.
*/


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

/*!
    @method     
    @abstract   Sets the resolution of the camera.
*/

-(void)setSize:(NSSize)aSize;

/*!
    @method     
    @abstract   Starts the calibraiton
    @discussion When this method is called, it takes the calibration view to
				fullscreen and starts calibration timer.
*/

-(void)calibrate;

/*!
    @method     
    @abstract   Returns a string with calibration points.
    @discussion This method returns a string with description of each calibration
				point nad its coordinates.
*/

-(NSString *)description;

/*!
    @method     
    @abstract   Returns array of calibration points.
    @discussion Returns array of four normalised ZOPoints in order: Upper left
	point, upper right point, lower right point, lower left point.
*/

-(NSArray *)calibrationArray;
/*!
    @method     
    @abstract   Returns ZOCalibrationData object with calibration data.
    @discussion This methods returns the object of ZOCalibrationData, which is
				described in its own class.
*/

-(ZOCalibrationData *)calibrationData;
/*!
 @property    
 @abstract   Property for setting found point.
 @discussion This property is used to tell the class, what point was found.
 */

@property NSPoint point;

@end
