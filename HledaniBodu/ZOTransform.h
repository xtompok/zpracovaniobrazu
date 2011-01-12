//
//  ZOTransform.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 13.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
 @header ZOTransform
 @abstract   Class for ratio transformation
 @discussion This class is used for transforming points from camera 
 using ratio transformation. Description of this transform
 could be found in documentation of project. This class conforms
 to protocol TransformProtocol. 
 */

#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"
#import "ZOProtocols.h"


@interface ZOTransform : NSObject <TransformProtocol> {
	double PTK[4][2]; //Pomocné pole transformačních konstant pro poměrovou transformaci

}

/*!
    @method     
    @abstract   Returns right root of quadratic polynom
    @discussion This method computes roots of quadratic polynom and returns the
				root in range 0,5. If the discriminant is negative, returns -100.
				If the root is out  of range, returns 0.
*/


-(double)getRightRootOfPolynomWithA:(double)a B:(double)b andC:(double)c;

@end
