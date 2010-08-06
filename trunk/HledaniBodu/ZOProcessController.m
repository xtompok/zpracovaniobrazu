//
//  ZOProcessController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProcessController.h"


@implementation ZOProcessController

-(void)awakeFromNib
{
	int minR, minG,minB,maxR,maxG,maxB;
	minR = 100;
	minG = 100;
	minB = 100;
	maxR = 255;
	maxG = 255;
	maxB = 255;
	
	// Setting min values
	[rMinSlider setIntValue:minR];
	[rMinLabel  setIntValue:minR];
	[procImage setMinRValue:minR];
	
	[gMinSlider setIntValue:minG];
	[gMinLabel  setIntValue:minG];
	[procImage setMinGValue:minG];
	
	[bMinSlider setIntValue:minB];
	[bMinLabel  setIntValue:minB];
	[procImage setMinBValue:minB];
	
	// Setting max values	
	[rMaxSlider setIntValue:maxR];
	[rMaxLabel  setIntValue:maxR];
	[procImage setMaxRValue:maxR];
	
	[gMaxSlider setIntValue:maxG];
	[gMaxLabel  setIntValue:maxG];
	[procImage setMaxGValue:maxG];
	
	[bMaxSlider setIntValue:maxB];
	[bMaxLabel  setIntValue:maxB];
	[procImage setMaxBValue:maxB];
}

-(IBAction)minSliderMoved:(id)sender
{
	
	if ([minTogetherButton state]==NSOffState) 
	{
		if (sender==rMinSlider) 
		{	
			[rMinLabel setIntValue:[rMinSlider intValue]];
			[procImage setMinRValue:[rMinSlider intValue]];
		} 
		else if (sender==gMinSlider)
		{
			[gMinLabel setIntValue:[gMinSlider intValue]];
			[procImage setMinGValue:[gMinSlider intValue]];
		} 
		else if (sender==bMinSlider) 
		{
			[bMinLabel setIntValue:[bMinSlider intValue]];
			[procImage setMinBValue:[bMinSlider intValue]];
		}
		
	} else {
		[rMinSlider setIntValue:[sender intValue]];
		[gMinSlider setIntValue:[sender intValue]];
		[bMinSlider setIntValue:[sender intValue]];
		
		[rMinLabel setIntValue:[sender intValue]];
		[gMinLabel setIntValue:[sender intValue]];
		[bMinLabel setIntValue:[sender intValue]];

		[procImage setMinRValue:[rMinSlider intValue]];
		[procImage setMinGValue:[gMinSlider intValue]];
		[procImage setMinBValue:[bMinSlider intValue]];
	}
}

-(IBAction)maxSliderMoved:(id)sender
{	
	if ([maxTogetherButton state]==NSOffState) 
	{
		if (sender==rMaxSlider) 
		{	
			[rMaxLabel setIntValue:[rMaxSlider intValue]];
			[procImage setMaxRValue:[rMaxSlider intValue]];
		} 
		else if (sender==gMaxSlider)
		{
			[gMaxLabel setIntValue:[gMaxSlider intValue]];
			[procImage setMaxGValue:[gMaxSlider intValue]];
		} 
		else if (sender==bMaxSlider) 
		{
			[bMaxLabel setIntValue:[bMaxSlider intValue]];
			[procImage setMaxBValue:[bMaxSlider intValue]];
		}
		
	} else {

		[rMaxSlider setIntValue:[sender intValue]];
		[gMaxSlider setIntValue:[sender intValue]];
		[bMaxSlider setIntValue:[sender intValue]];
		
		[rMaxLabel setIntValue:[sender intValue]];
		[gMaxLabel setIntValue:[sender intValue]];
		[bMaxLabel setIntValue:[sender intValue]];

		[procImage setMaxRValue:[rMaxSlider intValue]];
		[procImage setMaxGValue:[gMaxSlider intValue]];
		[procImage setMaxBValue:[bMaxSlider intValue]];
	}
}

-(IBAction)sumSquareSliderMoved:(id)sender
{
	NSLog(@"%@",sender);
	if ([minTogetherSumButton state]==NSOffState) 
	{
		if (sender==rMinSumSlider) 
		{	
			[rMinSumLabel setIntValue:[rMinSumSlider intValue]];
			[procImage setMinRSumValue:[rMinSumSlider intValue]];
		} 
		else if (sender==gMinSumSlider)
		{
			[gMinSumLabel setIntValue:[gMinSumSlider intValue]];
			[procImage setMinGSumValue:[gMinSumSlider intValue]];
		} 
		else if (sender==bMinSumSlider) 
		{
			[bMinSumLabel setIntValue:[bMinSumSlider intValue]];
			[procImage setMinBSumValue:[bMinSumSlider intValue]];
		}
		
	} else {

		[rMinSumSlider setIntValue:[sender intValue]];
		[gMinSumSlider setIntValue:[sender intValue]];
		[bMinSumSlider setIntValue:[sender intValue]];
		
		[rMinSumLabel setIntValue:[sender intValue]];
		[gMinSumLabel setIntValue:[sender intValue]];
		[bMinSumLabel setIntValue:[sender intValue]];
		
		[procImage setMinRSumValue:[rMinSumSlider intValue]];
		[procImage setMinGSumValue:[gMinSumSlider intValue]];
		[procImage setMinBSumValue:[bMinSumSlider intValue]];
	}
}


@end
