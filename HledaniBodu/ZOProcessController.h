//
//  ZOProcessController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOProcessImage.h"


@interface ZOProcessController : NSWindowController {
	
	IBOutlet ZOProcessImage * procImage;
	
	//Config outlets
	IBOutlet NSSlider *rMinSlider;
	IBOutlet NSSlider *gMinSlider;
	IBOutlet NSSlider *bMinSlider;
	
	IBOutlet NSSlider *rMaxSlider;
	IBOutlet NSSlider *gMaxSlider;
	IBOutlet NSSlider *bMaxSlider;
	
	IBOutlet NSSlider *rMinSumSlider;
	IBOutlet NSSlider *gMinSumSlider;
	IBOutlet NSSlider *bMinSumSlider;
	
	IBOutlet NSTextField *rMinLabel;
	IBOutlet NSTextField *gMinLabel;
	IBOutlet NSTextField *bMinLabel;
	
	IBOutlet NSTextField *rMaxLabel;
	IBOutlet NSTextField *gMaxLabel;
	IBOutlet NSTextField *bMaxLabel;
	
	IBOutlet NSTextField *rMinSumLabel;
	IBOutlet NSTextField *gMinSumLabel;
	IBOutlet NSTextField *bMinSumLabel;
	
	IBOutlet NSButton *minTogetherButton;
	IBOutlet NSButton *minTogetherSumButton;
	IBOutlet NSButton *maxTogetherButton;
	
	IBOutlet NSTextField *maxSumSquareLabel;

	

}

//Configuration action
-(IBAction)sumSquareSliderMoved:(id)sender;
-(IBAction)minSliderMoved:(id)sender;
-(IBAction)maxSliderMoved:(id)sender;


@end
