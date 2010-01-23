//
//  ConfigController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 8.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ConfigController : NSView {
	IBOutlet NSSlider * rSlider;
	IBOutlet NSSlider * gSlider;
	IBOutlet NSSlider * bSlider;
	IBOutlet NSButton * togetherButton;
	IBOutlet NSButton * printStdoutButton;
	
	int rValue;
	

}

//@property NSSlider * rSlider;
//@property NSSlider * gSlider;
//@property NSSlider * bSlider;
//@property NSButton * togetherButton;
//@property NSButton * printStdoutButton;

@end
