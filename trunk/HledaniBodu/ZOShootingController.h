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
	int maxShots;
	int minSize;
	int maxiSize;
	
	float maxSpeed;
	float speed;
	
	NSWindow *projWindow;
	IBOutlet NSPanel *shootPanel;
	IBOutlet ZOShootingView *shootView;

}
-(IBAction)resetClicked:(id)sender;

@property	int maxBalloons;
@property	int maxLost;
@property	int maxShots;
@property	int minSize;
@property	int maxiSize;
	
@property	float maxSpeed;
@property	float speed;

@end
