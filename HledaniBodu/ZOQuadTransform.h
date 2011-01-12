//
//  ZOQuadTransform.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 25.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

/*!
    @header ZOQuadTransform
    @abstract   Class for quadrilateral transform
    @discussion This class is used for transforming points from camera 
				using quadrilateral transform. Description of this transform
				could be found in documentation of project. This class conforms
				to protocol TransformProtocol. 
*/


#import <Cocoa/Cocoa.h>
#import "ZOProtocols.h"
#import "ZOPoint.h"


@interface ZOQuadTransform : NSObject <TransformProtocol> {
	float m0;
	float m1;
	float m2;
	float m3;
	float m4;
	float m5;
	float m6;
	float m7;
	float m8;

}

@end
