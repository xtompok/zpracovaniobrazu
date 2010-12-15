//
//  ZOImageView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOImageView
    @abstract   View for showing image from camera
    @discussion This View is used to view image from camera and calibration
				points found in that image. It is also showed the found point
				from laser pointer.
*/


#import <Cocoa/Cocoa.h>


@interface ZOImageView : NSView {
	NSImage *image;
	NSArray *calPoints;
	NSPoint point;
	ZOPoint * cp1;
	ZOPoint * cp2;
	ZOPoint * cp3;
	ZOPoint * cp4;
	

}
/*!
    @method     
    @abstract   Sets image for viewing
    @discussion Sets an image from camera. It doesn't care on resolution
				image will be resized.
*/
-(void)setImage:(NSImage *)anImage;
/*!
 @method     
 @abstract   Sets calibration array
 @discussion Sets array of calibration points, which will be showed on
			 the image from camera as blue squares.
 @param anArray NSArray of four ZOPoints in this order on dataprojector:
		upper left, upper right, lower right, lower left.
 */
-(void)setCalPoints:(NSArray *)anArray;
/*!
    @method     
    @abstract   Sets found point
    @discussion Sets a point found in image. Point is normalised and it is shown as
				a red cross in the image.
*/

-(void)setPoint:(NSPoint)aPoint;
/*!
    @method     
    @abstract   Makes a cross.
    @discussion This method makes a NSBezierPath with cross on given coordinates.
				The path is returned.
*/

-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;


@end
