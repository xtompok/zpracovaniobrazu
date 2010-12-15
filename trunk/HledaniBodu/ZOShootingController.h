//
//  ZOShootingController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//



#import <Cocoa/Cocoa.h>
#import "ZOProtocols.h"
#import "ZOShootingView.h"

/*!
	@header		ZOShootingController
	@abstract   Window controller for shooting balloons
	@discussion This controller provides communication layer between application and ZOShootingView.
				It conforms to ProjectorProtocol, gets point from WindowController a serves it to
				ZOShooting View. It also interacts with GUI, sends ZOShootingView data for game and
				resets and pauses the game.
 */

@interface ZOShootingController : NSWindowController<ProjectorProtocol> {
	NSPoint point1;
	NSPoint point2;
	
	int maxBalloons;
	int maxLost;
	int maxShots;
	int minSize;
	int maxiSize;
	
	BOOL startByLaser;
	BOOL isPaused;
	
	float maxSpeed;
	float speed;
	
	NSWindow *projWindow;
	IBOutlet NSPanel *shootPanel;
	IBOutlet ZOShootingView *shootView;

}
/*!
    @method     
    @abstract   Resets the game and sets new data
    @discussion This method sends ZOShootingController message resetGameWithData with GAMEDATA
				structure created from GUI.
*/
-(IBAction)resetClicked:(id)sender;
/*!
    @method     
    @abstract   Pauses the game
    @discussion This method sends ZOShootingController message setPaused and toggles isPaused.
*/
-(IBAction)pauseClicked:(id)sender;
/*! 
	@property
	@abstract Maximum number of balloons on the screen
*/ 
@property	int maxBalloons;
/*! 
 @property
 @abstract Maximum number of lost balloons
 */ 
@property	int maxLost;
/*! 
 @property
 @abstract Maximum number of shots needed to destroy the balloon
 */ 
@property	int maxShots;
/*! 
 @property
 @abstract Minimal size of balloon
 */ 
@property	int minSize;
/*! 
 @property
 @abstract Maximal size of balloon
 */ 
@property	int maxiSize;

/*! 
 @property
 @abstract Maximal speed of balloon
 */ 
@property	float maxSpeed;
/*! 
 @property
 @abstract Speed of game
 */ 
@property	float speed;

@end
