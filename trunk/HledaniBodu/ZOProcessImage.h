//
//  ZOProcessImage.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 23.3.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOProcessImage : NSObject {
	
	NSSize size;
	int delka;
	
	int minRSumValue;
	int minGSumValue;
	int minBSumValue;
	
	int minRValue;
	int minGValue;
	int minBValue;
	
	int maxRValue;
	int maxGValue;
	int maxBValue;
	
	int maxScoreR;
	int maxScoreG;
	int maxScoreB;
	
	unsigned char * origbuffer;
	

}
@property int minRSumValue;
@property int minGSumValue;
@property int minBSumValue;

@property int minRValue;
@property int minGValue;
@property int minBValue;

@property int maxRValue;
@property int maxGValue;
@property int maxBValue;

@property(readonly) int maxScoreR;
@property(readonly) int maxScoreG;
@property(readonly) int maxScoreB;



-(id)initWithSize:(NSSize)aSize;
-(NSPoint)getLightestPointFromImage:(NSImage *)anImage;
-(void)getSumSquareAtIndex:(int)index toArray:(int *)sum;
-(NSPoint)getPixelCoordinatesAtIndex:(int)index;

@end
