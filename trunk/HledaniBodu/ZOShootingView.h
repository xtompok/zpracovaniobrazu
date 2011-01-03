//
//  ZOShootingView.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOShootingView
    @abstract   View class for shooting balloons.
    @discussion This class implements the balloon shooting game. In the class are
				included methods for drawing and application logic.
*/


#import <Cocoa/Cocoa.h>
#import "ZOBaloon.h"

/*!
    @struct 
    @abstract   Structure for game data
    @discussion This structure is used for send the game data from controller and
				could be used for saving game data. In this strucutre there are
				all settings usable in game.
    @field      maxBalloons The maximum number of balloons on the screen.
	@field		maxSpeed The maximum speed of balloon. In pixels per cycle.
	@field		maxLost	The maximum number of lost balloons. 
	@field		delay The delay between redarwing the screen and moving balloons.
	@field		maxShots The number of shots needed to destroy the balloon.
	@field		minSize	The minimum size of balloon. In pixels.
	@field		maxiSize The maximum size of balloon. In pixels.
*/

typedef struct {	
	int maxBalloons;
	float maxSpeed;
	int maxLost;
	float delay;
	int maxShots;
	int minSize;
	int maxiSize;
} GAMEDATA;

@interface ZOShootingView : NSView {
	int width;
	int height;
	
	NSPoint point1;
	NSPoint point2;
	
	int maxLost;
	float maxSpeed;
	int numBalloons;
	int maxShots;
	
	float delay;
	BOOL paused;
	
	int minSize;
	int maxiSize;
	
	NSMutableArray *balloonsArray;
	
	NSTimer *timer;
	
	NSColor * color;
	
	int lostBalloons;
	int score;

}
/*!
    @method     
    @abstract   Random float generator
    @discussion Generates random float in given range.
*/

-(float)randFrom:(float)a to:(float)b;
/*!
    @method     
    @abstract   Sets the first found point
    @discussion This method is called, when the point is found. The method transforms 
				the point into screen coordinates. It checks, if the point is in balloon
				and increments the number of shots for shooted balloons.
*/

-(void)setPoint1:(NSPoint) aPoint;
/*!
    @method     
    @abstract   Sets the second found point
    @discussion This method trasforms the point into screen coordinates and saves it.
*/

-(void)setPoint2:(NSPoint)aPoint;

/*!
    @method     
    @abstract   Resets the game with given data
    @discussion Gets the data from given GAMEDATA structure, saves it in the global variables,
				prepare new balloon array, resets score, invalidates timer and pauses the game.
*/


-(void)resetGameWithData:(GAMEDATA *) aData;

/*!
    @method     
    @abstract   Preparing things for draw
    @discussion This method is called every time, when the timer expires. It moves all balloons,
				replace the lost balloons with new and replace shooted balloons and increments score.
*/


-(void)timerExpired:(NSTimer *)aTimer;

/*!
    @method     
    @abstract   Makes a cross path
    @discussion This methods returns a NSBezierPath with cross on the given coordinates.
*/
-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint;
/*!
    @method     
    @abstract   Pauses or unpauses the game
    @discussion If the want to be paused, the timer is invalidated, if not, the timer is started.
*/

-(void)setPaused:(BOOL) isPaused;

/*!
    @method     
    @abstract   Inserts balloon into balloon array.
    @discussion This method generates new balloon and saves it on the selected position in balloonsArray.
*/


-(void)insertBalloonAtIndex:(int)i;
@end
