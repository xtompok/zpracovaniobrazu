//
//  ZOCalibrateView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZOCalibrateView : NSView {
	int calPoint;
	int calPointSize;

}
-(void)setCalPoint:(int)index;
@end
