//
//  ZOProcessController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProcessController.h"


@implementation ZOProcessController

@synthesize minSumR;
@synthesize minSumG;
@synthesize minSumB;
@synthesize isSumTogether;

@synthesize minR;
@synthesize minG;
@synthesize minB;
@synthesize isMinTogether;

@synthesize maxR;
@synthesize maxG;
@synthesize maxB;
@synthesize isMaxTogether;

-(void)awakeFromNib
{
	[self setMinR:100];
	[self setMinG:100];
	[self setMinB:100];
	
	[self setMaxR:255];
	[self setMaxG:255];
	[self setMaxB:255];
	
	[[NSNotificationCenter defaultCenter]  addObserver:self
											  selector:@selector(handleShowSettingsWindow:)
												  name:@"Show process settings"
												object:procImage];

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
	
	NSNumber * objMinR;
	objMinR = [[NSNumber alloc] initWithInt:minR];
	[aDict setValue:objMinR forKey:@"minR"];
	
	NSNumber * objMinG;
	objMinG = [[NSNumber alloc] initWithInt:minG];
	[aDict setValue:objMinG forKey:@"minG"];
	
	NSNumber * objMinB;
	objMinB = [[NSNumber alloc] initWithInt:minB];
	[aDict setValue:objMinB forKey:@"minB"];
	
	
	NSNumber * objMaxR;
	objMaxR = [[NSNumber alloc] initWithInt:maxR];
	[aDict setValue:objMaxR forKey:@"maxR"];

	NSNumber * objMaxG;
	objMaxG = [[NSNumber alloc] initWithInt:maxG];
	[aDict setValue:objMaxG forKey:@"maxG"];
	
	NSNumber * objMaxB;
	objMaxB = [[NSNumber alloc] initWithInt:maxB];
	[aDict setValue:objMaxB forKey:@"maxB"];
	

	NSNumber * objMinSumR;
	objMinSumR = [[NSNumber alloc] initWithInt:minSumR];
	[aDict setValue:objMinSumR forKey:@"minSumR"];
	
	NSNumber * objMinSumG;
	objMinSumG = [[NSNumber alloc] initWithInt:minSumG];
	[aDict setValue:objMinSumG forKey:@"minSumG"];
	
	NSNumber * objMinSumB;
	objMinSumB = [[NSNumber alloc] initWithInt:minSumB];
	[aDict setValue:objMinSumB forKey:@"minSumB"];
	
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
    
	NSString *fileName = @"ProcessData.hbsaveddata";
	return [folder stringByAppendingPathComponent: fileName];    
}

- (IBAction) saveDataToDisk:(id) sender
{
	NSLog(@"Saving data to disk");
	NSString * path = [self pathForDataFile];
	
	[NSKeyedArchiver archiveRootObject:[self dictionaryWithConfigValues] toFile: path];
}

- (IBAction) loadDataFromDisk:(id) sender
{
	NSLog(@"Loading data form disk");
	NSString     * path        = [self pathForDataFile];
	NSDictionary * rootObject;
    
	rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path]; 
	
	NSLog(@"Dict: %@",rootObject);
	
	[self setMinR:[[rootObject valueForKey:@"minR"] intValue]];
	[self setMinG:[[rootObject valueForKey:@"minG"] intValue]];
	[self setMinB:[[rootObject valueForKey:@"minB"] intValue]];
	
	[self setMaxR:[[rootObject valueForKey:@"maxR"] intValue]];
	[self setMaxG:[[rootObject valueForKey:@"maxG"] intValue]];
	[self setMaxB:[[rootObject valueForKey:@"maxB"] intValue]];
	
	[self setMinSumR:[[rootObject valueForKey:@"minSumR"] intValue]];
	[self setMinSumG:[[rootObject valueForKey:@"minSumG"] intValue]];
	[self setMinSumB:[[rootObject valueForKey:@"minSumB"] intValue]];
		
}



-(void)setMinR:(int)aR
{
	minR=aR;
	[procImage setMinRValue:aR];
	if (isMinTogether) {
		[self willChangeValueForKey:@"minG"];
		[self willChangeValueForKey:@"minB"];
		minG=minB=aR;
		[self didChangeValueForKey:@"minG"];
		[self didChangeValueForKey:@"minB"];
	}
}
-(void)setMinG:(int)aG
{
	minG=aG;
	[procImage setMinGValue:aG];
	if (isMinTogether) {
		[self willChangeValueForKey:@"minR"];
		[self willChangeValueForKey:@"minB"];
		minR=minB=aG;
		[self didChangeValueForKey:@"minR"];
		[self didChangeValueForKey:@"minB"];
	}
}
-(void)setMinB:(int)aB
{
	minB=aB;
	[procImage setMinBValue:aB];
	if (isMinTogether) {
		[self willChangeValueForKey:@"minG"];
		[self willChangeValueForKey:@"minR"];
		minR=minG=aB;
		[self didChangeValueForKey:@"minG"];
		[self didChangeValueForKey:@"minR"];
	}
}

-(void)setMaxR:(int)aR
{
	maxR=aR;
	[procImage setMaxRValue:aR];
	if (isMaxTogether) {
		[self willChangeValueForKey:@"maxG"];
		[self willChangeValueForKey:@"maxB"];
		maxG=maxB=aR;
		[self didChangeValueForKey:@"maxG"];
		[self didChangeValueForKey:@"maxB"];
	}
}
-(void)setMaxG:(int)aG
{
	maxG=aG;
	[procImage setMaxGValue:aG];
	if (isMaxTogether) {
		[self willChangeValueForKey:@"maxR"];
		[self willChangeValueForKey:@"maxB"];
		maxR=maxB=aG;
		[self didChangeValueForKey:@"maxR"];
		[self didChangeValueForKey:@"maxB"];
	}
}
-(void)setMaxB:(int)aB
{
	maxB=aB;
	[procImage setMaxBValue:aB];
	if (isMaxTogether) {
		[self willChangeValueForKey:@"maxG"];
		[self willChangeValueForKey:@"maxR"];
		maxR=maxG=aB;
		[self didChangeValueForKey:@"maxG"];
		[self didChangeValueForKey:@"maxR"];
	}
}


-(void)setMinSumR:(int)aR
{
	minSumR=aR;
	[procImage setMinRSumValue:aR];
	if (isSumTogether) {
		[self willChangeValueForKey:@"minSumG"];
		[self willChangeValueForKey:@"minSumB"];
		minSumG=minSumB=aR;
		[self didChangeValueForKey:@"minSumG"];
		[self didChangeValueForKey:@"minSumB"];
	}
}
-(void)setMinSumG:(int)aG
{
	minSumG=aG;
	[procImage setMinGSumValue:aG];
	if (isSumTogether) {
		[self willChangeValueForKey:@"minSumR"];
		[self willChangeValueForKey:@"minSumB"];
		minSumR=minSumB=aG;
		[self didChangeValueForKey:@"minSumR"];
		[self didChangeValueForKey:@"minSumB"];
	}
}
-(void)setMinSumB:(int)aB
{
	minSumB=aB;
	[procImage setMinBSumValue:aB];
	if (isSumTogether) {
		[self willChangeValueForKey:@"minSumG"];
		[self willChangeValueForKey:@"minSumR"];
		minSumR=minSumG=aB;
		[self didChangeValueForKey:@"minSumG"];
		[self didChangeValueForKey:@"minSumR"];
	}
}
/*-(void)didChangeValueForKey:(NSString *)key
{
	NSLog(@"Key= %@",key);
	NSLog(@"Value = %@", [self valueForKey:key]);
}*/

@end
