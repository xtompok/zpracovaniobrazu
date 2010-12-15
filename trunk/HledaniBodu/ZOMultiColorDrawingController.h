//
//  ZOMultiColorDrawingController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 18.10.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

/*!
    @header ZOMultiColorDrawingController
    @abstract   Controller for multi color drawing.
    @discussion This class provides the interface between prcessing the image and drawing the color
				picture. It conforms to Projector protocol. It gets the point from the WindowController
				and sends it to the Viewing class. It also has a GUI for setting parametres of drawing.
*/

#import <Cocoa/Cocoa.h>
#import "ZOMultiColorDrawingView.h"
#import "ZOProtocols.h"


@interface ZOMultiColorDrawingController : NSWindowController<ProjectorProtocol> {
	
	float blueWidth;
	float greenWidth;
	float yellowWidth;
	
	IBOutlet ZOMultiColorDrawingView * drawView;
	IBOutlet NSPanel * drawPanel;
	NSWindow * projWindow;

}
/*!
    @method     
    @abstract   Sets the width of blue line.
    @discussion Sends the width of blue line to ZOMultiColorDrawingView.
*/

-(void)setBlueWidth:(float)aWidth;
/*!
 @method     
 @abstract   Sets the width of green line.
 @discussion Sends the width of green line to ZOMultiColorDrawingView.
 */
-(void)setGreenWidth:(float)aWidth;
/*!
 @method     
 @abstract   Sets the width of yellow line.
 @discussion Sends the width of yellow line to ZOMultiColorDrawingView.
 */
-(void)setYellowWidth:(float)aWidth;

/*!
    @method     
    @abstract   Return descriptions of drawed paths.
	@discussion Returns NSString * with concatenated descriptions of the NSBezierPaths 
				saved in pathArray. 
*/

-(NSString *)generateString;

/*!
    @method     
    @abstract   Resets drawing
    @discussion Sends view a message to reset the drawing.
*/

-(IBAction)resetDrawing:(id)sender;

/*!
    @method     
    @abstract   Saves the drawed path to disk
    @discussion Gets the desriptions of drawed paths using generateString and saves it
				to disk. It opens a dialog where to save it. The output file could be
				converted to SVG using bezpath2svg.pl
*/

-(IBAction)saveBezier:(id)sender;

/*!
 @property     
 @abstract   Width of the blue line	
 @discussion This property could be used to get the width of the blue path.
 */
@property (readonly) float blueWidth;
/*!
 @property     
 @abstract   Width of the green line	
 @discussion This property could be used to get the width of the green path.
 */
@property (readonly) float greenWidth;
/*!
 @property     
 @abstract   Width of the yellow line	
 @discussion This property could be used to get the width of the yellow path.
 */
@property (readonly) float yellowWidth;


@end
