//
//  WindowController.h
//  
//
//  Created by Tomáš Pokorný on 21.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef struct {
	int r;
	int g;
	int b;
} BARVA;

@class CSGCamera;

@interface WindowController : NSWindowController
{	
	IBOutlet ZOImageView *imageView;
	IBOutlet NSImageView *imageView2;
	
	//Projector screen
	IBOutlet NSPanel *projPanel;
	IBOutlet ZOProjectorView *projView;
	
	IBOutlet NSTextField *ulLabel;
	IBOutlet NSTextField *urLabel;
	IBOutlet NSTextField *llLabel;
	IBOutlet NSTextField *lrLabel;
	IBOutlet NSTextField *maxSumSquareLabel;
	IBOutlet NSButton *calibrateButton;
	
	//Config outlets
	IBOutlet NSSlider *rMinSlider;
	IBOutlet NSSlider *gMinSlider;
	IBOutlet NSSlider *bMinSlider;
	
	/*IBOutlet NSSlider *rMinValueSlider;
	IBOutlet NSSlider *gMinValueSlider;
	IBOutlet NSSlider *bMinValueSlider;*/
	
	IBOutlet NSButton *minTogetherButton;
	//IBOutlet NSButton *minTogetherValueButton;
	
	IBOutlet NSButton *printToStdButton;
	
	IBOutlet NSTextField *rMinLabel;
	IBOutlet NSTextField *gMinLabel;
	IBOutlet NSTextField *bMinLabel;
	
	/*IBOutlet NSTextField *rMinValueLabel;
	IBOutlet NSTextField *gMinValueLabel;
	IBOutlet NSTextField *bMinValueLabel;*/
	
	NSArray *calLabelsArray;
	NSArray *calPointsArray;
	
	int kalibCamArrayindex;
	
	ZOPoint *ulCalPoint;
	ZOPoint *urCalPoint;
	ZOPoint *llCalPoint;
	ZOPoint *lrCalPoint;
	
	NSSize size;
	
	NSWindow * projWindow;
	
	NSTimer *calTimer;
	NSTimer *calBlankTimer;
	
	NSImage *lastImage;
	
	int delka;
	unsigned char * origbuffer;
	
	BARVA minColorValue;
	BARVA maxColorValue;

	NSPoint outPoint;
	unsigned char mode;
	BOOL running;
	
	BOOL calInProgress;
	
	ZOTransform *transformObject;
	ZO2PointTransform *transform2Object;
	
	ZOProcessImage *procImage;
	ZOCalibrate *calObject;
	
	CSGCamera *camera;
}

-(IBAction)Calibrate:(id)sender;
-(IBAction)RunAndPause:(id)sender;


//Configuration action
-(IBAction)sumSquareSliderMoved:(id)sender;



@end