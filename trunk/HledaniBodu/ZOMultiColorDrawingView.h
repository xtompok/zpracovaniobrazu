//
//  ZOMultiColorDrawingView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.10.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOMultiColorDrawingView
    @abstract   View for multi color drawing
    @discussion This view is used for drawing with three colors. It is driven by 
				ZOMultiColorDrawingController. It draws three NSBezierPath elements
				with different colors, squares for changing color of drawing, pausing
				and resetting the drawing.
*/

#import <Cocoa/Cocoa.h>


@interface ZOMultiColorDrawingView : NSView {

	NSArray * pathArray;
	
	NSPoint point1;
	NSPoint point2;
	bool drawing;
	
	float blueLineWidth;
	float greenLineWidth;
	float yellowLineWidth;
	
	int pathIndex;
	
	NSRect blueColorRect;
	NSRect greenColorRect;
	NSRect yellowColorRect;
	NSRect resetRect;
	NSRect pauseRect;
	
	int resetCountdown;
	bool paused;
	bool onPaused;
	
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
				screen, saves coordinates of lighted point and appeds it to apropriate 
				drawed path.
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
    @discussion This methods releases NSArray of drawed paths and inits with new empty 
				paths.
*/

-(void)resetDrawing;

/*!
 @property     
 @abstract   Width of blue path
 @discussion This property is used for setting width of blue line.
 */
@property float blueLineWidth;
/*!
 @property     
 @abstract   Width of green path
 @discussion This property is used for setting width of green line.
 */
@property float greenLineWidth;
/*!
 @property     
 @abstract   Width of yellow path
 @discussion This property is used for setting width of yellow line.
 */
@property float yellowLineWidth;

/*!
 @property     
 @abstract   NSArray of drawed paths
 @discussion This property is used to get the drawed paths. It contains three
			 NSBezierPaths, one for each color. 
 */
@property (readonly) NSArray * pathArray;

@end
