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
	
	float width;
	IBOutlet ZOProjDrawingView * drawView;
	IBOutlet NSPanel * drawPanel;
	NSWindow * projWindow;

}

-(void)setWidth:(float)aWidth;

-(IBAction)resetDrawing:(id)sender;
-(IBAction)saveBezier:(id)sender;

@property (readonly) float width;

@end
