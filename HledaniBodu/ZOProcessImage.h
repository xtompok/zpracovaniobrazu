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
	unsigned char * origbuffer;
	
	int minRSumValue;
	int minGSumValue;
	int minBSumValue;


}
-(id)initWithSize:(NSSize)aSize;
-(NSPoint)getLightestPointFromImage:(NSImage *)anImage;
-(void)getSumSquareAtIndex:(int)index toArray:(int *)sum;
-(NSPoint)getPixelCoordinatesAtIndex:(int)index;

@end
