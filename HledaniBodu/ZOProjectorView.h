//
//  ZOProjectorView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOProjectorView
    @abstract   View for showing found point
    @discussion This class is used for viewing the found point.
*/


#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"


@interface ZOProjectorView : NSView {
	NSPoint point1,point2;
	bool drawing;

}

/*!
 @method     
 @abstract   Returns NSBezierPath with drawed cross
 @discussion This method is used to show ligted point on screen. It is a simple
 cross.
 */
-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;
/*!
 @method     
 @abstract   Sets first lighted point
 @discussion This method converts normalised coordinates to real coordinates of the
 screen and saves coordinates of lighted point.
 */

-(void)setPoint1:(NSPoint)aPoint;
/*!
 @method     
 @abstract   Sets first lighted point
 @discussion This method converts normalised coordinates to real coordinates of the
 screen and saves coordinates of lighted point.
 */
-(void)setPoint2:(NSPoint)aPoint;

@end
