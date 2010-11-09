//
//  ZOProcess2Controller.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProcess2Controller.h"


@implementation ZOProcess2Controller

@synthesize minPointR;
@synthesize minPointG;
@synthesize minPointB;
@synthesize isMinPointTogether;

@synthesize maxPointR;
@synthesize maxPointG;
@synthesize maxPointB;
@synthesize isMaxPointTogether;


@synthesize minInnerR;
@synthesize minInnerG;
@synthesize minInnerB;
@synthesize isMinInnerTogether;

@synthesize maxInnerR;
@synthesize maxInnerG;
@synthesize maxInnerB;
@synthesize isMaxInnerTogether;


@synthesize minOuterR;
@synthesize minOuterG;
@synthesize minOuterB;
@synthesize isMinOuterTogether;

@synthesize maxOuterR;
@synthesize maxOuterG;
@synthesize maxOuterB;
@synthesize isMaxOuterTogether;

-(void)awakeFromNib
{
	[[NSNotificationCenter defaultCenter]  addObserver:self
											  selector:@selector(handleShowSettingsWindow:)
												  name:@"Show process settings"
												object:procImage];
	
	[self setMinPointR: 100];
	[self setMinPointG: 0];
	[self setMinPointB: 0];
	[self setIsMinPointTogether: NO];
	
	[self setMaxPointR: 255];
	[self setMaxPointG: 100];
	[self setMaxPointB: 100];
	[self setIsMaxPointTogether: NO];
	
	
	[self setMinInnerR: 100];
	[self setMinInnerG: 0];
	[self setMinInnerB: 0];
	[self setIsMinInnerTogether: NO];
	
	[self setMaxInnerR: 255];
	[self setMaxInnerG: 255];
	[self setMaxInnerB: 255];
	[self setIsMaxInnerTogether: YES];
	
	
	[self setMinOuterR: 0];
	[self setMinOuterG: 0];
	[self setMinOuterB: 0];
	[self setIsMinOuterTogether: YES];
	
	[self setMaxOuterR: 255];
	[self setMaxOuterG: 255];
	[self setMaxOuterB: 255];
	[self setIsMaxOuterTogether: YES];

}

-(void)handleShowSettingsWindow:(NSNotification *)aNotify
{
	NSLog(@"Showing settings window");
	[self showWindow:nil];
}


-(NSMutableDictionary *)dictionaryWithConfigValues
{
	NSMutableDictionary * aDict;
	aDict = [[NSMutableDictionary alloc] initWithCapacity: 20];
		
	NSNumber * objMinPointR;
	objMinPointR = [[NSNumber alloc] initWithInt:minPointR];
	[aDict setValue:objMinPointR forKey:@"minPointR"];
	
	NSNumber * objMinPointG;
	objMinPointG = [[NSNumber alloc] initWithInt:minPointG];
	[aDict setValue:objMinPointG forKey:@"minPointG"];
	
	NSNumber * objMinPointB;
	objMinPointB = [[NSNumber alloc] initWithInt:minPointB];
	[aDict setValue:objMinPointB forKey:@"minPointB"];
	
	
	NSNumber * objMaxPointR;
	objMaxPointR = [[NSNumber alloc] initWithInt:maxPointR];
	[aDict setValue:objMaxPointR forKey:@"maxPointR"];
	
	NSNumber * objMaxPointG;
	objMaxPointG = [[NSNumber alloc] initWithInt:maxPointG];
	[aDict setValue:objMaxPointG forKey:@"maxPointG"];
	
	NSNumber * objMaxPointB;
	objMaxPointB = [[NSNumber alloc] initWithInt:maxPointB];
	[aDict setValue:objMaxPointB forKey:@"maxPointB"];
	
	
	
	NSNumber * objMinInnerR;
	objMinInnerR = [[NSNumber alloc] initWithInt:minInnerR];
	[aDict setValue:objMinInnerR forKey:@"minInnerR"];
	
	NSNumber * objMinInnerG;
	objMinInnerG = [[NSNumber alloc] initWithInt:minInnerG];
	[aDict setValue:objMinInnerG forKey:@"minInnerG"];
	
	NSNumber * objMinInnerB;
	objMinInnerB = [[NSNumber alloc] initWithInt:minInnerB];
	[aDict setValue:objMinInnerB forKey:@"minInnerB"];
	
	
	NSNumber * objMaxInnerR;
	objMaxInnerR = [[NSNumber alloc] initWithInt:maxInnerR];
	[aDict setValue:objMaxInnerR forKey:@"maxInnerR"];
	
	NSNumber * objMaxInnerG;
	objMaxInnerG = [[NSNumber alloc] initWithInt:maxInnerG];
	[aDict setValue:objMaxInnerG forKey:@"maxInnerG"];
	
	NSNumber * objMaxInnerB;
	objMaxInnerB = [[NSNumber alloc] initWithInt:maxInnerB];
	[aDict setValue:objMaxInnerB forKey:@"maxInnerB"];
	
	
	NSNumber * objMinOuterR;
	objMinOuterR = [[NSNumber alloc] initWithInt:minOuterR];
	[aDict setValue:objMinOuterR forKey:@"minOuterR"];
	
	NSNumber * objMinOuterG;
	objMinOuterG = [[NSNumber alloc] initWithInt:minOuterG];
	[aDict setValue:objMinOuterG forKey:@"minOuterG"];
	
	NSNumber * objMinOuterB;
	objMinOuterB = [[NSNumber alloc] initWithInt:minOuterB];
	[aDict setValue:objMinOuterB forKey:@"minOuterB"];
	
	
	NSNumber * objMaxOuterR;
	objMaxOuterR = [[NSNumber alloc] initWithInt:maxOuterR];
	[aDict setValue:objMaxOuterR forKey:@"maxOuterR"];
	
	NSNumber * objMaxOuterG;
	objMaxOuterG = [[NSNumber alloc] initWithInt:maxOuterG];
	[aDict setValue:objMaxOuterG forKey:@"maxOuterG"];
	
	NSNumber * objMaxOuterB;
	objMaxOuterB = [[NSNumber alloc] initWithInt:maxOuterB];
	[aDict setValue:objMaxOuterB forKey:@"maxOuterB"];
		
	return aDict;
}

- (NSString *) pathForDataFile
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	NSString *folder = @"~/Library/Application Support/HledaniBodu/";
	folder = [folder stringByExpandingTildeInPath];
	
	if ([fileManager fileExistsAtPath: folder] == NO)
	{
		[fileManager createDirectoryAtPath:folder 
			   withIntermediateDirectories:YES 
								attributes:nil 
									 error:nil];
	}
    
	NSString *fileName = @"Process2Data.hbsaveddata";
	return [folder stringByAppendingPathComponent: fileName];    
}

- (IBAction) saveDataToDisk:(id) sender
{
	NSLog(@"Saving data to disk");
	NSString * path = [self pathForDataFile];
	NSLog(@"Mam cestu");
	[NSKeyedArchiver archiveRootObject:[self dictionaryWithConfigValues] toFile: path];
}

- (IBAction) loadDataFromDisk:(id) sender
{
	NSLog(@"Loading data form disk");
	NSString     * path        = [self pathForDataFile];
	NSDictionary * rootObject;
    
	rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path]; 
	
	NSLog(@"Dict: %@",rootObject);
	
	[self setMinPointR:[[rootObject valueForKey:@"minPointR"] intValue]];
	[self setMinPointG:[[rootObject valueForKey:@"minPointG"] intValue]];
	[self setMinPointB:[[rootObject valueForKey:@"minPointB"] intValue]];
	
	[self setMaxPointR:[[rootObject valueForKey:@"maxPointR"] intValue]];
	[self setMaxPointG:[[rootObject valueForKey:@"maxPointG"] intValue]];
	[self setMaxPointB:[[rootObject valueForKey:@"maxPointB"] intValue]];
	
	[self setMinInnerR:[[rootObject valueForKey:@"minInnerR"] intValue]];
	[self setMinInnerG:[[rootObject valueForKey:@"minInnerG"] intValue]];
	[self setMinInnerB:[[rootObject valueForKey:@"minInnerB"] intValue]];
	
	[self setMaxInnerR:[[rootObject valueForKey:@"maxInnerR"] intValue]];
	[self setMaxInnerG:[[rootObject valueForKey:@"maxInnerG"] intValue]];
	[self setMaxInnerB:[[rootObject valueForKey:@"maxInnerB"] intValue]];
	
	[self setMinOuterR:[[rootObject valueForKey:@"minOuterR"] intValue]];
	[self setMinOuterG:[[rootObject valueForKey:@"minOuterG"] intValue]];
	[self setMinOuterB:[[rootObject valueForKey:@"minOuterB"] intValue]];
	
	[self setMaxOuterR:[[rootObject valueForKey:@"maxOuterR"] intValue]];
	[self setMaxOuterG:[[rootObject valueForKey:@"maxOuterG"] intValue]];
	[self setMaxOuterB:[[rootObject valueForKey:@"maxOuterB"] intValue]];
	
}



-(void)setMinPointR:(int)aR
{
	minPointR=aR;
	[procImage setMinPointR:aR];
	if (isMinPointTogether) {
		[self willChangeValueForKey:@"minPointG"];
		[self willChangeValueForKey:@"minPointB"];
		minPointG=minPointB=aR;
		[self didChangeValueForKey:@"minPointG"];
		[self didChangeValueForKey:@"minPointB"];
	}
}
-(void)setMinPointG:(int)aG
{
	minPointG=aG;
	[procImage setMinPointG:aG];
	if (isMinPointTogether) {
		[self willChangeValueForKey:@"minPointR"];
		[self willChangeValueForKey:@"minPointB"];
		minPointR=minPointB=aG;
		[self didChangeValueForKey:@"minPointR"];
		[self didChangeValueForKey:@"minPointB"];
	}
}
-(void)setMinPointB:(int)aB
{
	minPointB=aB;
	[procImage setMinPointB:aB];
	if (isMinPointTogether) {
		[self willChangeValueForKey:@"minPointG"];
		[self willChangeValueForKey:@"minPointR"];
		minPointR=minPointG=aB;
		[self didChangeValueForKey:@"minPointG"];
		[self didChangeValueForKey:@"minPointR"];
	}
}

-(void)setMaxPointR:(int)aR
{
	maxPointR=aR;
	[procImage setMaxPointR:aR];
	if (isMaxPointTogether) {
		[self willChangeValueForKey:@"maxPointG"];
		[self willChangeValueForKey:@"maxPointB"];
		maxPointG=maxPointB=aR;
		[self didChangeValueForKey:@"maxPointG"];
		[self didChangeValueForKey:@"maxPointB"];
	}
}
-(void)setMaxPointG:(int)aG
{
	maxPointG=aG;
	[procImage setMaxPointG:aG];
	if (isMaxPointTogether) {
		[self willChangeValueForKey:@"maxPointR"];
		[self willChangeValueForKey:@"maxPointB"];
		maxPointR=maxPointB=aG;
		[self didChangeValueForKey:@"maxPointR"];
		[self didChangeValueForKey:@"maxPointB"];
	}
}
-(void)setMaxPointB:(int)aB
{
	maxPointB=aB;
	[procImage setMaxPointB:aB];
	if (isMaxPointTogether) {
		[self willChangeValueForKey:@"maxPointG"];
		[self willChangeValueForKey:@"maxPointR"];
		maxPointR=maxPointG=aB;
		[self didChangeValueForKey:@"maxPointG"];
		[self didChangeValueForKey:@"maxPointR"];
	}
}


-(void)setMinInnerR:(int)aR
{
	minInnerR=aR;
	[procImage setMinInnerR:aR];
	if (isMinInnerTogether) {
		[self willChangeValueForKey:@"minInnerG"];
		[self willChangeValueForKey:@"minInnerB"];
		minInnerG=minInnerB=aR;
		[self didChangeValueForKey:@"minInnerG"];
		[self didChangeValueForKey:@"minInnerB"];
	}
}
-(void)setMinInnerG:(int)aG
{
	minInnerG=aG;
	[procImage setMinInnerG:aG];
	if (isMinInnerTogether) {
		[self willChangeValueForKey:@"minInnerR"];
		[self willChangeValueForKey:@"minInnerB"];
		minInnerR=minInnerB=aG;
		[self didChangeValueForKey:@"minInnerR"];
		[self didChangeValueForKey:@"minInnerB"];
	}
}
-(void)setMinInnerB:(int)aB
{
	minInnerB=aB;
	[procImage setMinInnerB:aB];
	if (isMinInnerTogether) {
		[self willChangeValueForKey:@"minInnerG"];
		[self willChangeValueForKey:@"minInnerR"];
		minInnerR=minInnerG=aB;
		[self didChangeValueForKey:@"minInnerG"];
		[self didChangeValueForKey:@"minInnerR"];
	}
}

-(void)setMaxInnerR:(int)aR
{
	maxInnerR=aR;
	[procImage setMaxInnerR:aR];
	if (isMaxInnerTogether) {
		[self willChangeValueForKey:@"maxInnerG"];
		[self willChangeValueForKey:@"maxInnerB"];
		maxInnerG=maxInnerB=aR;
		[self didChangeValueForKey:@"maxInnerG"];
		[self didChangeValueForKey:@"maxInnerB"];
	}
}
-(void)setMaxInnerG:(int)aG
{
	maxInnerG=aG;
	[procImage setMaxInnerG:aG];
	if (isMaxInnerTogether) {
		[self willChangeValueForKey:@"maxInnerR"];
		[self willChangeValueForKey:@"maxInnerB"];
		maxInnerR=maxInnerB=aG;
		[self didChangeValueForKey:@"maxInnerR"];
		[self didChangeValueForKey:@"maxInnerB"];
	}
}
-(void)setMaxInnerB:(int)aB
{
	maxInnerB=aB;
	[procImage setMaxInnerB:aB];
	if (isMaxInnerTogether) {
		[self willChangeValueForKey:@"maxInnerG"];
		[self willChangeValueForKey:@"maxInnerR"];
		maxInnerR=maxInnerG=aB;
		[self didChangeValueForKey:@"maxInnerG"];
		[self didChangeValueForKey:@"maxInnerR"];
	}
}


-(void)setMinOuterR:(int)aR
{
	minOuterR=aR;
	[procImage setMinOuterR:aR];
	if (isMinOuterTogether) {
		[self willChangeValueForKey:@"minOuterG"];
		[self willChangeValueForKey:@"minOuterB"];
		minOuterG=minOuterB=aR;
		[self didChangeValueForKey:@"minOuterG"];
		[self didChangeValueForKey:@"minOuterB"];
	}
}
-(void)setMinOuterG:(int)aG
{
	minOuterG=aG;
	[procImage setMinOuterG:aG];
	if (isMinOuterTogether) {
		[self willChangeValueForKey:@"minOuterR"];
		[self willChangeValueForKey:@"minOuterB"];
		minOuterR=minOuterB=aG;
		[self didChangeValueForKey:@"minOuterR"];
		[self didChangeValueForKey:@"minOuterB"];
	}
}
-(void)setMinOuterB:(int)aB
{
	minOuterB=aB;
	[procImage setMinOuterB:aB];
	if (isMinOuterTogether) {
		[self willChangeValueForKey:@"minOuterG"];
		[self willChangeValueForKey:@"minOuterR"];
		minOuterR=minOuterG=aB;
		[self didChangeValueForKey:@"minOuterG"];
		[self didChangeValueForKey:@"minOuterR"];
	}
}

-(void)setMaxOuterR:(int)aR
{
	maxOuterR=aR;
	[procImage setMaxOuterR:aR];
	if (isMaxOuterTogether) {
		[self willChangeValueForKey:@"maxOuterG"];
		[self willChangeValueForKey:@"maxOuterB"];
		maxOuterG=maxOuterB=aR;
		[self didChangeValueForKey:@"maxOuterG"];
		[self didChangeValueForKey:@"maxOuterB"];
	}
}
-(void)setMaxOuterG:(int)aG
{
	maxOuterG=aG;
	[procImage setMaxOuterG:aG];
	if (isMaxOuterTogether) {
		[self willChangeValueForKey:@"maxOuterR"];
		[self willChangeValueForKey:@"maxOuterB"];
		maxOuterR=maxOuterB=aG;
		[self didChangeValueForKey:@"maxOuterR"];
		[self didChangeValueForKey:@"maxOuterB"];
	}
}
-(void)setMaxOuterB:(int)aB
{
	maxOuterB=aB;
	[procImage setMaxOuterB:aB];
	if (isMaxOuterTogether) {
		[self willChangeValueForKey:@"maxOuterG"];
		[self willChangeValueForKey:@"maxOuterR"];
		maxOuterR=maxOuterG=aB;
		[self didChangeValueForKey:@"maxOuterG"];
		[self didChangeValueForKey:@"maxOuterR"];
	}
}

@end
