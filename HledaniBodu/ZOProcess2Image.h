//
//  ZOProcess2Image.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 5.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOProtocols"

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

-(NSPoint)pixelCoordinatesAtIndex:(int)index;
-(struct colResults)sumCrossAtIndex:(int)index;

@property int minPointR;
@property int minPointG;
@property int minPointB;

@property int maxPointR;
@property int maxPointG;
@property int maxPointB;

@property int minInnerR;
@property int minInnerG;
@property int minInnerB;

@property int maxInnerR;
@property int maxInnerG;
@property int maxInnerB;

@property int minOuterR;
@property int minOuterG;
@property int minOuterB;

@property int maxOuterR;
@property int maxOuterG;
@property int maxOuterB;

@property int maxScoreR;
@property int maxScoreG;
@property int maxScoreB;

@property int maxR;
@property int maxG;
@property int maxB;

@end
