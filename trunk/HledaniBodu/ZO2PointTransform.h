//
//  ZO2PointTransform.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 27.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
//  Detailní popis v pomerova_transformace.pdf
//  Detailed info in pomerova_transformace.pdf
/*!
 @header ZO2PointTransform
 @abstract   Class for 2 point transform
 @discussion This class is used for transforming points from camera 
 using two point transform. Description of this transform
 could be found in documentation of project. This class conforms
 to protocol TransformProtocol. 
 */


#import <Cocoa/Cocoa.h>
#import "ZOPoint.h"
#import "ZOProtocols.h"


@interface ZO2PointTransform : NSObject <TransformProtocol> {

	NSPoint PTB[2];	//Pomocné transformační body - Helping transformation points
	double PTD[4]; //Pomocné transformační délky - Helping transformation lengths
	NSPoint CP[4]; //Kalibrační body - Calibration points
	double g,h,k,l; //Koeficienty přímek - Line coeficients

}

@end
