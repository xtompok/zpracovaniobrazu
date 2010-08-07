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
	ZOPoint * cp1;
	ZOPoint * cp2;
	ZOPoint * cp3;
	ZOPoint * cp4;
	

}

-(void)setImage:(NSImage *)anImage;
-(void)setCalPoints:(NSArray *)anArray;
-(void)setPoint:(NSPoint)aPoint;
-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;


@end
