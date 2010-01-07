//
//  TestController.h
//  SequenceGrabberTest
//
//  Created by Tim Omernick on 3/18/05.
//  Copyright 2005 Tim Omernick. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CSGCamera;

@interface TestController : NSWindowController
{
	IBOutlet NSImageView *cameraView;
	
	CSGCamera *camera;
}

@end
