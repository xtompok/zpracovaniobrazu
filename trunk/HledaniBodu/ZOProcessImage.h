//
//  ZOProcessImage.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 23.3.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOProcessImage
    @abstract   Class for processing image
    @discussion This class is used to process the image. It computes
				the sum square of 5x5 points and gets the maximum sum
				square of all.
*/


#import <Cocoa/Cocoa.h>
#import "ZOProtocols.h"


@interface ZOProcessImage : NSObject <ProcessProtocol> {
	
	NSSize size;
	int delka;
	
	IBOutlet id controller;
	
	int minRSumValue;
	int minGSumValue;
	int minBSumValue;
	
	int minRValue;
	int minGValue;
	int minBValue;
	
	int maxRValue;
	int maxGValue;
	int maxBValue;
	
	int maxScoreR;
	int maxScoreG;
	int maxScoreB;
	
	int maxR;
	int maxG;
	int maxB;
	
	unsigned char * origbuffer;	

}
/*!
    @method     
    @abstract   Computes the sum square.
    @discussion This method computes the sum square around given index and 
				saves it to the given array.
	@param index Index of the point in image where compute the sum square.
	@param sum	Pointer to array of three integers, where are stored the
				results.
*/

-(void)sumSquareAtIndex:(int)index toArray:(int *)sum;
/*!
    @method     
    @abstract   Transforms index into coordinates.
    @discussion This methods transforms the index in array into real coordinates
				in image.
*/

-(NSPoint)pixelCoordinatesAtIndex:(int)index;

/*!
 @property     
 @abstract   Minimal red value of sum square.
 */
@property int minRSumValue;
/*!
 @property     
 @abstract   Minimal green value of sum square.
 */
@property int minGSumValue;
/*!
 @property     
 @abstract   Minimal blue value of sum square.
 */
@property int minBSumValue;

/*!
 @property     
 @abstract   Minimal red value of the point. If it is lower, sum square isn't computed.
 */
@property int minRValue;
/*!
 @property     
 @abstract   Minimal green value of the point. If it is lower, sum square isn't computed.
 */
@property int minGValue;
/*!
 @property     
 @abstract   Minimal blue value of the point. If it is lower, sum square isn't computed.
 */
@property int minBValue;

/*!
 @property     
 @abstract   Maximal red value of the point. If it is higher, sum square isn't computed.
 */
@property int maxRValue;
/*!
 @property     
 @abstract   Maximal green value of the point. If it is higher, sum square isn't computed.
 */
@property int maxGValue;
/*!
 @property     
 @abstract   Maximal blue value of the point. If it is higher, sum square isn't computed.
 */
@property int maxBValue;

/*!
 @property     
 @abstract   Maximal found score of sum square. Red part.
 */
@property(readonly) int maxScoreR;
/*!
 @property     
 @abstract   Maximal found score of sum square. Green part.
 */
@property(readonly) int maxScoreG;
/*!
 @property     
 @abstract   Maximal found score of sum square. Blue part.
 */
@property(readonly) int maxScoreB;

/*!
 @property     
 @abstract   Red part of found point.
 */
@property(readonly) int maxR;
/*!
 @property     
 @abstract   Green part of found point.
 */
@property(readonly) int maxG;
/*!
 @property     
 @abstract   Blue part of found point.
 */
@property(readonly) int maxB;

@end
