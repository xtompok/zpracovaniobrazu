//
//  ZOImageView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 3.2.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOImageView : NSView {
	NSImage *image;
	NSArray *calPoints;
	NSPoint point;

}

-(void)setAnImage:(NSImage *)anImage;
-(void)setCalPoints:(NSArray *)anArray;
-(void)setPoint:(NSPoint)aPoint;
-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;


@end
