//
//  ZOPoint.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 5.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOPoint
    @abstract   Simple object to store point.
    @discussion This class is used, when it is needed to use points as objects (i.e. in NSArray), 
				so the standard NSPoint can't be used.
*/


#import <Cocoa/Cocoa.h>


@interface ZOPoint : NSObject {
	float x;
	float y;
}
/*!
    @method     
    @abstract   Init with given NSPoint
*/

-(id)initWithPoint:(NSPoint)aPoint;
/*!
 @method     
 @abstract   Returns its value as NSPoint
 */
-(NSPoint)pointValue;
/*!
 @method     
 @abstract   Sets internal value to given NSPoint
 */
-(void)setPoint:(NSPoint)aPoint;
/*!
 @method     
 @abstract   Returns NSString with formated coordinates.
 */
-(NSString *)description;

/*! 
 @property
 @abstract X part of the point
 */ 
@property float x;
/*! 
 @property
 @abstract Y part of the point
 */ 
@property float y;


@end
