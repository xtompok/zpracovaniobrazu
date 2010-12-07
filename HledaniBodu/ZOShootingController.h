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
	
	int maxBalloons;
	int maxLost;
	float maxSpeed;
	float speed;
	
	NSWindow *projWindow;
	IBOutlet NSPanel *shootPanel;
	IBOutlet ZOShootingView *shootView;

}
-(IBAction)resetClicked:(id)sender;

@property int maxBalloons;
@property int maxLost;
@property float maxSpeed;

@end
