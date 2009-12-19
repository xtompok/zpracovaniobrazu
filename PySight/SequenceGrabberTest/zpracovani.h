//
//  zpracovani.h
//  SequenceGrabberTest
//
//  Created by Tomáš Pokorný on 17.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface zpracovani : NSObject {
	NSSize size;
	int length;
	int i;
	unsigned char pixel[4];
	unsigned char * buffer;

}
@property(readonly) unsigned char * buffer;
+(zpracovani*)createBufferfromArray:(unsigned char *)abuffer withsize:(NSSize)asize lenght:(int)alength;
-(id)initWithBuffer:(unsigned char *)abuffer withsize:(NSSize)asize lenght:(int)alength;
-(void)inverseColor;
-(void)moduleWithNumber:(int)modul;
-(void)makeChanges;
-(void)dealloc;

@end

//int getPixelAddress(int x,int y);