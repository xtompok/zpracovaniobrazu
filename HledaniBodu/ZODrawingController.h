//
//  ZODrawingController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 19.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOProjDrawingView.h"
#import "ZOProtocols"

@interface ZODrawingController : NSWindowController <ProjectorProtocol> {
	IBOutlet NSSlider * widthSlider;
	IBOutlet NSTextField * widthField;
	
	IBOutlet ZOProjDrawingView * drawView;
	IBOutlet NSPanel * drawPanel;
	NSWindow * projWindow;

}
-(IBAction)widthSliderMoved:(id)sender;
-(IBAction)resetDrawing:(id)sender;


@end
