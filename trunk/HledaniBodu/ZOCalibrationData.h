//
//  ZOCalibrationData.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 14.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOCalibrationData
    @abstract   Class for storing calibration data
    @discussion This class is designed to save data from calibration. It can
				save the array of calibration points and some other things.
*/


#import <Cocoa/Cocoa.h>


@interface ZOCalibrationData : NSObject {
	NSArray *calPointsArray;
	int maxR;
	int maxG;
	int maxB;
	
}

/*!
    @method     
    @abstract   Inits the calibration data
    @discussion This method is used to create new calibration data object with given 
				array of points and color.
	@param anArray The NSArray * with four ZOPoints representing the corners of the 
				   projector screen in this order: upper left, upper right, lower right,
				   lower left. 
*/

-(id)initWithCalArray:(NSArray *) anArray 
			   maxRed:(int) aRed 
				Green:(int) aGreen 
			  andBlue:(int) aBlue;
/*!
    @method     
    @abstract   Returns the calibration array.
*/

-(NSArray *)calPointsArray;
/*!
 @property     
 @abstract   Returns the red part of color.
 */
@property(readonly) int maxR;
/*!
 @property     
 @abstract   Returns the green part of color.
 */
@property(readonly) int maxG;
/*!
 @property     
 @abstract   Returns the blue part of color.
 */
@property(readonly) int maxB;


@end
