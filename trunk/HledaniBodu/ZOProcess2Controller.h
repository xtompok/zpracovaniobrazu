//
//  ZOProcess2Controller.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOProcess2Image.h"


@interface ZOProcess2Controller : NSWindowController {
	IBOutlet ZOProcess2Image * procImage;
	
	IBOutlet NSButton * minPointTogetherButton;
	IBOutlet NSSlider * minPointRSlider;
	IBOutlet NSSlider * minPointGSlider;
	IBOutlet NSSlider * minPointBSlider;
	IBOutlet NSTextField * minPointRLabel;
	IBOutlet NSTextField * minPointGLabel;
	IBOutlet NSTextField * minPointBLabel;

	IBOutlet NSButton * maxPointTogetherButton;
	IBOutlet NSSlider * maxPointRSlider;
	IBOutlet NSSlider * maxPointGSlider;
	IBOutlet NSSlider * maxPointBSlider;
	IBOutlet NSTextField * maxPointRLabel;
	IBOutlet NSTextField * maxPointGLabel;
	IBOutlet NSTextField * maxPointBLabel;

	
	IBOutlet NSButton * minInnerTogetherButton;
	IBOutlet NSSlider * minInnerRSlider;
	IBOutlet NSSlider * minInnerGSlider;
	IBOutlet NSSlider * minInnerBSlider;
	IBOutlet NSTextField * minInnerRLabel;
	IBOutlet NSTextField * minInnerGLabel;
	IBOutlet NSTextField * minInnerBLabel;

	IBOutlet NSButton * maxInnerTogetherButton;
	IBOutlet NSSlider * maxInnerRSlider;
	IBOutlet NSSlider * maxInnerGSlider;
	IBOutlet NSSlider * maxInnerBSlider;
	IBOutlet NSTextField * maxInnerRLabel;
	IBOutlet NSTextField * maxInnerGLabel;
	IBOutlet NSTextField * maxInnerBLabel;

	
	IBOutlet NSButton * minOuterTogetherButton;
	IBOutlet NSSlider * minOuterRSlider;
	IBOutlet NSSlider * minOuterGSlider;
	IBOutlet NSSlider * minOuterBSlider;
	IBOutlet NSTextField * minOuterRLabel;
	IBOutlet NSTextField * minOuterGLabel;
	IBOutlet NSTextField * minOuterBLabel;

	IBOutlet NSButton * maxOuterTogetherButton;
	IBOutlet NSSlider * maxOuterRSlider;
	IBOutlet NSSlider * maxOuterGSlider;
	IBOutlet NSSlider * maxOuterBSlider;
	IBOutlet NSTextField * maxOuterRLabel;
	IBOutlet NSTextField * maxOuterGLabel;
	IBOutlet NSTextField * maxOuterBLabel;


}
-(IBAction)minPointSliderMoved:(id)sender;
-(IBAction)maxPointSliderMoved:(id)sender;

-(IBAction)minInnerSliderMoved:(id)sender;
-(IBAction)maxInnerSliderMoved:(id)sender;

-(IBAction)minOuterSliderMoved:(id)sender;
-(IBAction)maxOuterSliderMoved:(id)sender;


@end
