//
//  ZODrawingController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 19.5.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

/*!
    @header ZODrawingController
    @abstract   Controller for drawing.
    @discussion This is a controller for one color drawing. It conforms to Projector protocol and has 
				its GUI for configuration the drawing. It also can save drawed images to disk to process
				with bezpath2svg.pl.
*/


#import <Cocoa/Cocoa.h>
#import "ZOProjDrawingView.h"
#import "ZOProtocols.h"

@interface ZODrawingController : NSWindowController <ProjectorProtocol> {
	
	float width;
	IBOutlet ZOProjDrawingView * drawView;
	IBOutlet NSPanel * drawPanel;
	NSWindow * projWindow;

}
/*!
    @method     
    @abstract   Sets width of drawed line
    @discussion Tells ZODrawingView to change width of drawed line to given value.
*/

-(void)setWidth:(float)aWidth;
/*!
    @method     
    @abstract   Resets drawing
    @discussion Tells ZODrawingView to reset current drawed path.
*/
-(IBAction)resetDrawing:(id)sender;
/*!
    @method     
    @abstract   Saves drawed path to disk.
    @discussion Opens dialog for saving files and saves description of currently drawed path to
				provided file. This colud be used for conversion to SVG using bezpath2svg.pl.
*/

-(IBAction)saveBezier:(id)sender;

@property (readonly) float width;

@end
