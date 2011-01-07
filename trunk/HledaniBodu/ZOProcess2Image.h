//
//  ZOProcess2Image.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 5.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
 @header ZOProcessImage
 @abstract   Class for processing image
 @discussion This class is used to process the image. It computes brightness of
			 the four points around processed points and four points in distance
			 5 from processed point. From values in selected range it returns
             maximum brighted point.
			 
 */


#import <Cocoa/Cocoa.h>
#import "ZOProtocols.h"

struct colResults {
	int innerR;
	int innerG;
	int innerB;
	int outerR;
	int outerG;
	int outerB;
};

@interface ZOProcess2Image : NSObject <ProcessProtocol> {

	NSSize size;
	int delka;
		
	int minPointR;
	int minPointG;
	int minPointB;

	int maxPointR;
	int maxPointG;
	int maxPointB;

	int minInnerR;
	int minInnerG;
	int minInnerB;

	int maxInnerR;
	int maxInnerG;
	int maxInnerB;
	
	int minOuterR;
	int minOuterG;
	int minOuterB;

	int maxOuterR;
	int maxOuterG;
	int maxOuterB;
	
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
    @abstract   Computes real coordinates.
    @discussion This method computes real coordinates in image from given index.
*/

-(NSPoint)pixelCoordinatesAtIndex:(int)index;
/*!
    @method     
    @abstract   Returns color results for given index.
    @discussion This method returns the colResults structure filled with computed
				average of inner and outer points.
*/
-(struct colResults)sumCrossAtIndex:(int)index;


/*!
 @property  
 @abstract   Minimal red value of found point.
 */
@property int  minPointR;
/*!
 @property  
 @abstract   Minimal green value of found point.
 */
@property int  minPointG;
/*!
 @property  
 @abstract   Minimal blue value of found point.
 */
@property int  minPointB;

/*!
 @property  
 @abstract   Maximal red value of found point.
 */
@property int  maxPointR;
/*!
 @property  
 @abstract   Maximal green value of found point.
 */
@property int  maxPointG;
/*!
 @property  
 @abstract   Maximal blue value of found point.
 */
@property int  maxPointB;

/*!
 @property  
 @abstract   Minimal red value of inner points.
 */
@property int  minInnerR;
/*!
 @property  
 @abstract   Minimal green value of inner points.
 */
@property int  minInnerG;
/*!
 @property  
 @abstract   Minimal blue value of inner points.
 */
@property int  minInnerB;

/*!
 @property  
 @abstract   Maximal red value of inner points.
 */
@property int  maxInnerR;
/*!
 @property  
 @abstract   Maximal green value of inner points.
 */
@property int  maxInnerG;
/*!
 @property  
 @abstract   Maximal blue value of inner points.
 */
@property int  maxInnerB;

/*!
 @property  
 @abstract   Minimal red value of outer points.
 */
@property int  minOuterR;
/*!
 @property  
 @abstract   Minimal green value of outer points.
 */
@property int  minOuterG;
/*!
 @property  
 @abstract   Minimal blue value of outer points.
 */
@property int  minOuterB;

/*!
 @property  
 @abstract   Maximal red value of outer points.
 */
@property int  maxOuterR;
/*!
 @property  
 @abstract   Maximal green value of outer points.
 */
@property int  maxOuterG;
/*!
 @property  
 @abstract   Maximal blue value of outer points.
 */
@property int  maxOuterB;

/*!
 @property  
 @abstract   Red part of score of inner points of found point.
 */
@property int maxScoreR;
/*!
 @property  
 @abstract   Green part of score of inner points of found point.
 */
@property int maxScoreG;
/*!
 @property  
 @abstract   Blue part of score of inner points of found point.
 */
@property int maxScoreB;

/*!
 @property  
 @abstract   Red part of score of found point.
 */
@property int maxR;
/*!
 @property  
 @abstract   Green part of score of found point.
 */
@property int maxG;
/*!
 @property  
 @abstract   Blue part of score of found point.
 */
@property int maxB;

@end
