//
//  ZOProcessController.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

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
- (NSString *) pathForDataFile;
- (IBAction) saveDataToDisk:(id) sender;
- (IBAction) loadDataFromDisk:(id) sender;
-(NSMutableDictionary *)dictionaryWithConfigValues;

//Configuration action

-(void)handleShowSettingsWindow:(NSNotification *)aNotify;


-(void)setMinSumR:(int)aR;
-(void)setMinSumG:(int)aG;
-(void)setMinSumB:(int)aB;

-(void)setMinR:(int)aR;
-(void)setMinG:(int)aG;
-(void)setMinB:(int)aB;

-(void)setMaxR:(int)aR;
-(void)setMaxG:(int)aG;
-(void)setMaxB:(int)aB;

@property (readonly) int minSumR;
@property (readonly) int minSumG;
@property (readonly) int minSumB;
@property BOOL isSumTogether;

@property (readonly) int minR;
@property (readonly) int minG;
@property (readonly) int minB;
@property BOOL isMinTogether;


@property (readonly) int maxR;
@property (readonly) int maxG;
@property (readonly) int maxB;
@property BOOL isMaxTogether;





@end
