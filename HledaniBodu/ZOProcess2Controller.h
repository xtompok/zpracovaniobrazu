//
//  ZOProcess2Controller.h
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

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

-(void)handleShowSettingsWindow:(NSNotification *)aNotify;

// Saving data
- (NSString *) pathForDataFile;
- (IBAction) saveDataToDisk:(id) sender;
- (IBAction) loadDataFromDisk:(id) sender;
-(NSMutableDictionary *)dictionaryWithConfigValues;

// Setters
-(void)setMinPointR:(int)aR;
-(void)setMinPointG:(int)aG;
-(void)setMinPointB:(int)aB;

-(void)setMaxPointR:(int)aR;
-(void)setMaxPointG:(int)aG;
-(void)setMaxPointB:(int)aB;


-(void)setMinInnerR:(int)aR;
-(void)setMinInnerG:(int)aG;
-(void)setMinInnerB:(int)aB;

-(void)setMaxInnerR:(int)aR;
-(void)setMaxInnerG:(int)aG;
-(void)setMaxInnerB:(int)aB;


-(void)setMinOuterR:(int)aR;
-(void)setMinOuterG:(int)aG;
-(void)setMinOuterB:(int)aB;

-(void)setMaxOuterR:(int)aR;
-(void)setMaxOuterG:(int)aG;
-(void)setMaxOuterB:(int)aB;


@property(readonly) int  minPointR;
@property(readonly) int  minPointG;
@property(readonly) int  minPointB;
@property BOOL isMinPointTogether;

@property(readonly) int  maxPointR;
@property(readonly) int  maxPointG;
@property(readonly) int  maxPointB;
@property BOOL isMaxPointTogether;


@property(readonly) int  minInnerR;
@property(readonly) int  minInnerG;
@property(readonly) int  minInnerB;
@property BOOL isMinInnerTogether;

@property(readonly) int  maxInnerR;
@property(readonly) int  maxInnerG;
@property(readonly) int  maxInnerB;
@property BOOL isMaxInnerTogether;


@property(readonly) int  minOuterR;
@property(readonly) int  minOuterG;
@property(readonly) int  minOuterB;
@property BOOL isMinOuterTogether;

@property(readonly) int  maxOuterR;
@property(readonly) int  maxOuterG;
@property(readonly) int  maxOuterB;
@property BOOL isMaxOuterTogether;

@end
