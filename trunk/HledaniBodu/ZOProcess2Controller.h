//
//  ZOProcess2Controller.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOProcess2Controller
    @abstract   Controller for ZOProcess2Image class
	@discussion This controller is used for communication with ZOProcess2Image
				class. It has a GUI for setting minimal and maximal brightnesses
				of point, its neighbours and four points in the distance, saving
				and loading the setting to or from disk.
*/


#import <Cocoa/Cocoa.h>
#import "ZOProcess2Image.h"


@interface ZOProcess2Controller : NSWindowController {
	IBOutlet ZOProcess2Image * procImage;
	
	int minPointR;
	int minPointG;
	int minPointB;
	BOOL isMinPointTogether;
	
	int maxPointR;
	int maxPointG;
	int maxPointB;
	BOOL isMaxPointTogether;
	
	
	int minInnerR;
	int minInnerG;
	int minInnerB;
	BOOL isMinInnerTogether;
	
	int maxInnerR;
	int maxInnerG;
	int maxInnerB;
	BOOL isMaxInnerTogether;
	
	
	int minOuterR;
	int minOuterG;
	int minOuterB;
	BOOL isMinOuterTogether;
	
	int maxOuterR;
	int maxOuterG;
	int maxOuterB;
	BOOL isMaxOuterTogether;


}
/*!
    @method     
    @abstract   Shows settings window
    @discussion This methods handles the notification and shows the window with
				sliders to set parametres of image processing and saving and 
				loading them.
*/

-(void)handleShowSettingsWindow:(NSNotification *)aNotify;

// Saving data
/*!
 @method     
 @abstract   Returns path, where to save the settings
 @discussion This method returns the NSString with path in Application Support
			 folder, where the settings could be saved.
 */
- (NSString *) pathForDataFile;
/*!
 @method     
 @abstract   Saves the settings to disk
 @discussion This method makes a dictionary from settings using method 
			 dictionaryWithConfigValues and saves it to the path returned 
			 from method pathForDataFile.
 */
- (IBAction) saveDataToDisk:(id) sender;
/*!
 @method     
 @abstract   Loads the settings from disk
 @discussion This method takes a dictionary of settings from given path
			 from method pathForDataFile and sets the variables to the 
			 loaded values.
 */
- (IBAction) loadDataFromDisk:(id) sender;
/*!
 @method     
 @abstract   Makes a dictionary from settings.
 @discussion This method takes all config variables and saves it as NSNumber
			 objects into NSMutableDictionary object, which is returned.
 */
-(NSMutableDictionary *)dictionaryWithConfigValues;

// Setters
/*!
 @method     
 @abstract   Sends minimal red value of point from GUI to ZOProcess2Image.
 */
-(void)setMinPointR:(int)aR;
/*!
 @method     
 @abstract   Sends minimal green value of point from GUI to ZOProcess2Image.
 */
-(void)setMinPointG:(int)aG;
/*!
 @method     
 @abstract   Sends minimal blue value of point from GUI to ZOProcess2Image.
 */
-(void)setMinPointB:(int)aB;

/*!
 @method     
 @abstract   Sends maximal red value of point from GUI to ZOProcess2Image.
 */
-(void)setMaxPointR:(int)aR;
/*!
 @method     
 @abstract   Sends maximal green value of point from GUI to ZOProcess2Image.
 */
-(void)setMaxPointG:(int)aG;
/*!
 @method     
 @abstract   Sends maximal blue value of point from GUI to ZOProcess2Image.
 */
-(void)setMaxPointB:(int)aB;


/*!
 @method     
 @abstract   Sends minimal red value of inner points from GUI to ZOProcess2Image.
 */
-(void)setMinInnerR:(int)aR;
/*!
 @method     
 @abstract   Sends minimal green value of inner points from GUI to ZOProcess2Image.
 */
-(void)setMinInnerG:(int)aG;
/*!
 @method     
 @abstract   Sends minimal blue value of inner points from GUI to ZOProcess2Image.
 */
-(void)setMinInnerB:(int)aB;

/*!
 @method     
 @abstract   Sends maximal red value of inner points from GUI to ZOProcess2Image.
 */
-(void)setMaxInnerR:(int)aR;
/*!
 @method     
 @abstract   Sends maximal green value of inner points from GUI to ZOProcess2Image.
 */
-(void)setMaxInnerG:(int)aG;
/*!
 @method     
 @abstract   Sends maximal blue value of inner points from GUI to ZOProcess2Image.
 */
-(void)setMaxInnerB:(int)aB;


/*!
 @method     
 @abstract   Sends minimal red value of outer points from GUI to ZOProcess2Image.
 */
-(void)setMinOuterR:(int)aR;
/*!
 @method     
 @abstract   Sends minimal green value of outer points from GUI to ZOProcess2Image.
 */
-(void)setMinOuterG:(int)aG;
/*!
 @method     
 @abstract   Sends minimal blue value of outer points from GUI to ZOProcess2Image.
 */
-(void)setMinOuterB:(int)aB;

/*!
 @method     
 @abstract   Sends maximal red value of outer points from GUI to ZOProcess2Image.
 */
-(void)setMaxOuterR:(int)aR;
/*!
 @method     
 @abstract   Sends maximal green value of outer points from GUI to ZOProcess2Image.
 */
-(void)setMaxOuterG:(int)aG;
/*!
 @method     
 @abstract   Sends maximal blue value of outer points from GUI to ZOProcess2Image.
 */
-(void)setMaxOuterB:(int)aB;

/*!
 @property  
 @abstract   Minimal red value of found point.
 */
@property(readonly) int  minPointR;
/*!
 @property  
 @abstract   Minimal green value of found point.
 */
@property(readonly) int  minPointG;
/*!
 @property  
 @abstract   Minimal blue value of found point.
 */
@property(readonly) int  minPointB;
/*!
 @property  
 @abstract   Are the minimal point config sliders moving together?
 */
@property BOOL isMinPointTogether;

/*!
 @property  
 @abstract   Maximal red value of found point.
 */
@property(readonly) int  maxPointR;
/*!
 @property  
 @abstract   Maximal green value of found point.
 */
@property(readonly) int  maxPointG;
/*!
 @property  
 @abstract   Maximal blue value of found point.
 */
@property(readonly) int  maxPointB;
/*!
 @property  
 @abstract   Are the maximal point config sliders moving together?
 */
@property BOOL isMaxPointTogether;

/*!
 @property  
 @abstract   Minimal red value of inner points.
 */
@property(readonly) int  minInnerR;
/*!
 @property  
 @abstract   Minimal green value of inner points.
 */
@property(readonly) int  minInnerG;
/*!
 @property  
 @abstract   Minimal blue value of inner points.
 */
@property(readonly) int  minInnerB;
/*!
 @property  
 @abstract   Are the minimal inner points config sliders moving together?
 */
@property BOOL isMinInnerTogether;

/*!
 @property  
 @abstract   Maximal red value of inner points.
 */
@property(readonly) int  maxInnerR;
/*!
 @property  
 @abstract   Maximal green value of inner points.
 */
@property(readonly) int  maxInnerG;
/*!
 @property  
 @abstract   Maximal blue value of inner points.
 */
@property(readonly) int  maxInnerB;
/*!
 @property  
 @abstract   Are the maximal inner points config sliders moving together?
 */
@property BOOL isMaxInnerTogether;

/*!
 @property  
 @abstract   Minimal red value of outer points.
 */
@property(readonly) int  minOuterR;
/*!
 @property  
 @abstract   Minimal green value of outer points.
 */
@property(readonly) int  minOuterG;
/*!
 @property  
 @abstract   Minimal blue value of outer points.
 */
@property(readonly) int  minOuterB;
/*!
 @property  
 @abstract   Are the minimal outer points config sliders moving together?
 */
@property BOOL isMinOuterTogether;

/*!
 @property  
 @abstract   Maximal red value of outer points.
 */
@property(readonly) int  maxOuterR;
/*!
 @property  
 @abstract   Maximal green value of outer points.
 */
@property(readonly) int  maxOuterG;
/*!
 @property  
 @abstract   Maximal blue value of outer points.
 */
@property(readonly) int  maxOuterB;
/*!
 @property  
 @abstract   Are the maximal outer points config sliders moving together?
 */
@property BOOL isMaxOuterTogether;

@end
