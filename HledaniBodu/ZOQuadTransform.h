//
//  ZOQuadTransform.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 25.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOProtocols"
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
