//
//  ZOProjectorView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

/*!
    @header ZOProjDrawingView
    @abstract   View for single color drawing
    @discussion This class is used for single color drawing. It draws a NSBezierPath
				with one color and the cross on the found point coordinates.
*/


#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"


@interface ZOProjDrawingView : NSView {
	NSBezierPath * drawedPath;
	NSPoint point1;
	NSPoint point2;
	bool drawing;
	float lineWidth;
	
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
 screen, saves coordinates of lighted point and appeds it to drawed path.
 */
-(void)setPoint1:(NSPoint)aPoint;
/*!
 @method     
 @abstract   Sets second lighted point
 @discussion Now only converts coordinates and saves the point.
 */
-(void)setPoint2:(NSPoint)aPoint;
/*!
 @method     
 @abstract   Resets drawing
 @discussion This methods releases the drawed path and inits new. 
 paths.
 */
-(void)resetDrawing;
/*!
 @property     
 @abstract   Width of the path
 @discussion This property is used for setting the width of the line.
 */
@property float lineWidth;

/*!
 @property     
 @abstract   Returns drawed path
 @discussion This property is used to get the drawed path. 
 */
@property (readonly)  NSBezierPath * drawedPath;

@end

