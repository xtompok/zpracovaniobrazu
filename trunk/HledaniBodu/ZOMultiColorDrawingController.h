//
//  ZOMultiColorDrawingController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.10.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOMultiColorDrawingView.h"
#import "ZOProtocols"


@interface ZOMultiColorDrawingController : NSWindowController {
	
	float blueWidth;
	float greenWidth;
	float yellowWidth;
	
	IBOutlet ZOMultiColorDrawingView * drawView;
	IBOutlet NSPanel * drawPanel;
	NSWindow * projWindow;

}

-(void)setBlueWidth:(float)aWidth;
-(void)setGreenWidth:(float)aWidth;
-(void)setYellowWidth:(float)aWidth;

-(NSString *)generateString;

-(IBAction)resetDrawing:(id)sender;
-(IBAction)saveBezier:(id)sender;

@property (readonly) float blueWidth;
@property (readonly) float greenWidth;
@property (readonly) float yellowWidth;


@end
