//
//  ZOTransform.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 13.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"
#import "ZOProtocols"


@interface ZOTransform : NSObject <TransformProtocol> {
	double PTK[4][2]; //Pomocné pole transformačních konstant pro poměrovou transformaci

}

-(double)getRightRootOfPolynomWithA:(double)a B:(double)b andC:(double)c;

@end
