//
//  ZOBaloon.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOBaloon
    @abstract   Class for storing balloons
    @discussion This class is designed to store almost everything about balloons,
				which are used in ZOShootingView as object for shooting. 
*/

#import <Cocoa/Cocoa.h>


@interface ZOBaloon : NSObject {
	NSPoint origin;
	float speed;
	NSColor * color;
	float radius;
	int shots;
	
	NSBezierPath * shape;
}
/*!
    @method     
    @abstract   Inits balloon with given arguments
    @discussion This method is used to initialize one balloon. It has all needed
				parameters to determine all attributes of ballon
	@param anOrigin The point, where will the balloon appear. In screen coordinates.
	@param aSize Size of the balloon.
	@param aSpeed Speed of the ballon. In pixels per one iteration.
	@param aColor NSColor * with color of balloon.
*/

-(id)initWithOrigin:(NSPoint) anOrigin 
			 Size:(float) aSize
			  Speed:(float)aSpeed 
		   andColor:(NSColor *)aColor;
/*!
    @method     
    @abstract   Tells balloon to move
    @discussion After calling this method, balloon moves up its speed.
*/

-(void)move;
/*
    @method     
    @abstract   Returns balloon path.
    @discussion Returns balloon path, which is shifted into its real coordinates on the screen.
*/

-(NSBezierPath *)balloonPath;
/*!
    @method     
    @abstract   Tells ballon that it was shooted.
    @discussion This method is used to tell balloon, that the laser pointer shooted into
				the balloon. Balloon increments its shoot counter, which is accessible 
				with the shots property.
*/

-(void)shooted;

/*!
    @property     
    @abstract   Number of shots.
    @discussion This is number of shots shooted in this balloon. It could be incremented 
				with calling method shooted.
*/
@property int shots;

/*!
 @property   color
 @abstract   Access the balloon color
 @discussion This method could be used to set the color of the balloon.
 */

@property (assign) NSColor * color;
@end
