//
//  ZOProcessController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*!
    @header ZOProcessController
    @abstract   Controller for ZOProcessImage
    @discussion This controller is used for communication with ZOProcessImage
				class. It has a GUI for setting minimal and maximal brightnesses
				of point and sum squares and saving and loading this data.
*/


#import <Cocoa/Cocoa.h>
#import "ZOProcessImage.h"


@interface ZOProcessController : NSWindowController {
	
	IBOutlet ZOProcessImage * procImage;
		
	IBOutlet NSTextField *maxSumSquareLabel;
	
	int minR;
	int minG;
	int minB;
	BOOL isMinTogether;
	
	int maxR;
	int maxG;
	int maxB;
	BOOL isMaxTogether;
	
	
	int minSumR;
	int minSumG;
	int minSumB;
	BOOL isSumTogether;

}
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

//Configuration action

/*!
    @method     
    @abstract   Shows settings window.
*/
-(void)handleShowSettingsWindow:(NSNotification *)aNotify;

/*!
    @method     
    @abstract   Sends minimal red sum square value from GUI to ZOProcessImage.
*/
-(void)setMinSumR:(int)aR;
/*!
 @method     
 @abstract   Sends minimal green sum square value from GUI to ZOProcessImage.
 */
-(void)setMinSumG:(int)aG;
/*!
 @method     
 @abstract   Sends minimal blue sum square value from GUI to ZOProcessImage.
 */
-(void)setMinSumB:(int)aB;

/*!
 @method     
 @abstract   Sends minimal red value from GUI to ZOProcessImage.
 */
-(void)setMinR:(int)aR;
/*!
 @method     
 @abstract   Sends minimal green value from GUI to ZOProcessImage.
 */
-(void)setMinG:(int)aG;
/*!
 @method     
 @abstract   Sends minimal blue value from GUI to ZOProcessImage.
 */
-(void)setMinB:(int)aB;

/*!
 @method     
 @abstract   Sends maximal red value from GUI to ZOProcessImage.
 */
-(void)setMaxR:(int)aR;
/*!
 @method     
 @abstract   Sends maximal green value from GUI to ZOProcessImage.
 */
-(void)setMaxG:(int)aG;
/*!
 @method     
 @abstract   Sends maximal blue value from GUI to ZOProcessImage.
 */
-(void)setMaxB:(int)aB;

/*!
 @property  
 @abstract   Minimal red sum square value of found point.
 */
@property (readonly) int minSumR;
/*!
 @property  
 @abstract   Minimal green sum square value of found point.
 */
@property (readonly) int minSumG;
/*!
 @property  
 @abstract   Minimal blue sum square value of found point.
 */
@property (readonly) int minSumB;
/*!
 @property  
 @abstract   Are the sum square config sliders moving together?
 */
@property BOOL isSumTogether;

/*!
 @property  
 @abstract   Minimal red value of found point.
 */
@property (readonly) int minR;
/*!
 @property  
 @abstract   Minimal green value of found point.
 */
@property (readonly) int minG;
/*!
 @property  
 @abstract   Minimal blue value of found point.
 */
@property (readonly) int minB;
/*!
 @property  
 @abstract   Are the minimal point config sliders moving together?
 */
@property BOOL isMinTogether;


/*!
 @property  
 @abstract   Maximal red value of found point.
 */
@property (readonly) int maxR;
/*!
 @property  
 @abstract   Maximal green value of found point.
 */
@property (readonly) int maxG;
/*!
 @property  
 @abstract   Maximal blue value of found point.
 */
@property (readonly) int maxB;
/*!
 @property  
 @abstract   Are the maximal config sliders moving together?
 */
@property BOOL isMaxTogether;





@end
