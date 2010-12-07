//
//  ZOShootingController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZOProtocols"
#import "ZOShootingView.h"

@interface ZOShootingController : NSWindowController<ProjectorProtocol> {
	NSPoint point1;
	NSPoint point2;
	
	int numBalloons;
	int maxLost;
	float maxSpeed;
	
	NSWindow *projWindow;
	IBOutlet NSPanel *shootPanel;
	IBOutlet ZOShootingView *shootView;

}

@property int numBalloons;
@property int maxLost;
@property float maxSpeed;

@end
