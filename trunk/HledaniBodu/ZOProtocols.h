/*!
    @header ZOProtocols
    @abstract   Protocols used in this program
    @discussion In this file there are defined all protocols used in this program. All 
				NSPoints used in this protocols are normalised -- in range <0,1>
*/

/*!
    @protocol
    @abstract    Protocol for processing image
    @discussion  This protocols lists all method needed to communicate with 
				 image processing class
*/
@protocol ProcessProtocol
/*!
    @method     
    @abstract   Initialize with given resolution of camera
    @discussion After calling this method, image processing class is expected to be initialized
				with given resolution of camera
*/
-(id)initWithSize:(NSSize)aSize;
/*!
    @method     
    @abstract   Found lighted point from given image
    @discussion This method is never called before initWithSize. It expects NSImage as parameter and
				returns normalized point if it was found or (0,0) if it wasn't.
*/
-(NSPoint)getThePointFromImage:(NSImage *)anImage;
@end

/*!
    @protocol
    @abstract    Protocol for transforming point coordinates
    @discussion  This protocol lists all methods needed to communicate with
				 point transforming classes
*/
@protocol TransformProtocol
/*!
    @method     
    @abstract   Initialize with given array of points
    @discussion After calling this method, point tranforming class is assumed as initialized
	with given array of points. This methods uses calibration array to compute constants for calibration equations.
	@param calArray Array of four ZOPoints in order upper left, upper right, lower right and lower left
					on the dataprojector.
*/

-(id)initWithCalibrationArray:(NSArray *)calArray;
/*!
    @method     
    @abstract   Sets new calibration array
    @discussion This method sets new calibration array of the same format as init and computes new constants for
 calibration equations.
*/

-(void)setCalibrationArray:(NSArray *)calArray;
/*!
    @method     
    @abstract   Transforms given point
    @discussion This methods transforms given point and transforms it in transforming equations. Returns transformed point.
				If the given point is (0,0), it returns (0,0)
*/

-(NSPoint)transformPoint:(NSPoint)point;
@end

/*!
    @protocol
    @abstract    Protocol for viewing points
    @discussion  This protocol lists all methods needed to communicate with viewing classes.
*/
@protocol ProjectorProtocol
/*!
    @method     
    @abstract   Sets new lighted point
    @discussion This method is used to inform viewing classes that the new image was processed.
	@param aPoint Normalised point. If the point was not found in image, aPoint is (0,0)
*/

-(void)setPoint1:(NSPoint)aPoint;
/*!
 @method     
 @abstract   Sets new lighted point
 @discussion This method is used to inform viewing classes that the new image was processed.
 @param aPoint Normalised point. If the point was not found in image, aPoint is (0,0)
 */
-(void)setPoint2:(NSPoint)aPoint;
/*!
    @method     
    @abstract   Tells class to go fullscreen
    @discussion Because the classes for viewing uses fullscreen, this method is called when the
				viewing class changed and tells class that the screen is its.
				
*/

-(void)goFullscreen;
/*!
 @method     
 @abstract   Tells class to left fullscreen
 @discussion Because the classes for viewing uses fullscreen, this method is called when the
 viewing class changed and tells class to clean the screen for another class.
 
 */
-(void)leftFullscreen;
/*!
    @method     
    @abstract   Opens settings window of the viewing class
    @discussion This method tells class to open the settings window. If it doesn't have the window, 
				nothing should be done.
*/

-(void)showSettingsWindow;
@end

