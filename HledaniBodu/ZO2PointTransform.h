//
//  ZO2PointTransform.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 27.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
//  Detailní popis v pomerova_transformace.pdf
//  Detailed info in pomerova_transformace.pdf


#import <Cocoa/Cocoa.h>


@interface ZO2PointTransform : NSObject {

	NSPoint PTB[2];	//Pomocné transformační body - Helping transformation points
	double PTD[4]; //Pomocné transformační délky - Helping transformation lengths
	NSPoint CP[4]; //Kalibrační body - Calibration points
	double g,h,k,l; //Koeficienty přímek - Line coeficients

}

-(id)initWithCalibrationArray:(NSArray *)calArray;
-(NSPoint)transformPoint:(NSPoint)point;

@end
