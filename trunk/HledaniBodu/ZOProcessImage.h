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
	NSImage * baseImage;
	
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
	
	int maxR;
	int maxG;
	int maxB;
	
	unsigned char * origbuffer;	

}
-(id)initWithSize:(NSSize)aSize;
-(NSPoint)getLightestPointFromImage:(NSImage *)anImage;
-(void)sumSquareAtIndex:(int)index toArray:(int *)sum;
-(NSPoint)pixelCoordinatesAtIndex:(int)index;
-(void)setBaseImage:(NSImage *)anImage;


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

@property(readonly) int maxR;
@property(readonly) int maxG;
@property(readonly) int maxB;

@end
