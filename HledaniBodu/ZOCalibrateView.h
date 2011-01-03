//
//  ZOCalibrateView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOCalibrateView
    @abstract   View for calibration
    @discussion This view is used to show calibration points or blank the screen.
*/


#import <Cocoa/Cocoa.h>


@interface ZOCalibrateView : NSView {
	int calPoint;
	int calPointSize;

}
/*!
    @method     
    @abstract   Sets the calibration point
    @discussion When this method is called, the calibration point is showed
	@param index The index of calibration point: 0 -- upper left, 1 -- upper
				right, 2 -- lower right, 3 -- lower left, other -- blank screen
*/

-(void)setCalPoint:(int)index;
@end
