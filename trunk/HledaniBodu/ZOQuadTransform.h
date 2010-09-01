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
	float d0;
	float d1;
	float d2;
	float d3;
	float d4;
	float d5;
	float d6;
	float d7;

}

@end
