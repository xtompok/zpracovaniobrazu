//
//  ZOProjectorController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 19.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOProjectorView.h"
#import "ZOProjProtocol"


@interface ZOProjectorController : NSWindowController <ProjectorProtocol> {

	IBOutlet ZOProjectorView * projView;
	IBOutlet NSPanel * projPanel;
	NSWindow * projWindow;
	
}



@end
