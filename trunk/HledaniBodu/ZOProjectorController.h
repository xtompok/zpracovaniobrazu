//
//  ZOProjectorController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 19.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

/*!
    @header ZOProjectorController
    @abstract   Controller for viewing found point
    @discussion This class only sends viewer the found point. It has no callable methods
				except the protocol methods.
*/


#import <Cocoa/Cocoa.h>
#import "ZOProjectorView.h"
#import "ZOProtocols.h"



@interface ZOProjectorController : NSWindowController <ProjectorProtocol> {

	IBOutlet ZOProjectorView * projView;
	IBOutlet NSPanel * projPanel;
	NSWindow * projWindow;
	
}



@end
