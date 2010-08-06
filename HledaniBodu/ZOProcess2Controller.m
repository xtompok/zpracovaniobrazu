//
//  ZOProcess2Controller.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOProcess2Controller.h"


@implementation ZOProcess2Controller
-(void)awakeFromNib
{
	[procImage setMinPointR:[minPointRSlider intValue]];
	[procImage setMinPointG:[minPointGSlider intValue]];
	[procImage setMinPointB:[minPointBSlider intValue]];
	
	[procImage setMaxPointR:[maxPointRSlider intValue]];
	[procImage setMaxPointG:[maxPointGSlider intValue]];
	[procImage setMaxPointB:[maxPointBSlider intValue]];
	
	[procImage setMinInnerR:[minInnerRSlider intValue]];
	[procImage setMinInnerG:[minInnerGSlider intValue]];
	[procImage setMinInnerB:[minInnerBSlider intValue]];
	
	[procImage setMaxInnerR:[maxInnerRSlider intValue]];	
	[procImage setMaxInnerG:[maxInnerGSlider intValue]];
	[procImage setMaxInnerB:[maxInnerBSlider intValue]];
	
	[procImage setMinOuterR:[minOuterRSlider intValue]];	
	[procImage setMinOuterG:[minOuterGSlider intValue]];
	[procImage setMinOuterB:[minOuterBSlider intValue]];
	
	[procImage setMaxOuterR:[maxOuterRSlider intValue]];
	[procImage setMaxOuterG:[maxOuterGSlider intValue]];
	[procImage setMaxOuterB:[maxOuterBSlider intValue]];

}

-(IBAction)minPointSliderMoved:(id)sender
{	
	if ([minPointTogetherButton state]==NSOnState) 
	{
		[minPointRSlider setIntValue:[sender intValue]];
		[minPointGSlider setIntValue:[sender intValue]];
		[minPointBSlider setIntValue:[sender intValue]];
		
		[minPointRLabel setIntValue:[sender intValue]];
		[minPointGLabel setIntValue:[sender intValue]];
		[minPointBLabel setIntValue:[sender intValue]];
	}else 
	{
		if (sender==minPointRSlider) {
			[minPointRLabel setIntValue:[sender intValue]];
		}
		if (sender==minPointGSlider) {
			[minPointGLabel setIntValue:[sender intValue]];
		}
		if (sender==minPointBSlider) {
			[minPointBLabel setIntValue:[sender intValue]];
		}
	}
	[procImage setMinPointR:[minPointRSlider intValue]];
	[procImage setMinPointG:[minPointGSlider intValue]];
	[procImage setMinPointB:[minPointBSlider intValue]];


}

-(IBAction)maxPointSliderMoved:(id)sender
{
	if ([maxPointTogetherButton state]==NSOnState) 
	{
		[maxPointRSlider setIntValue:[sender intValue]];
		[maxPointGSlider setIntValue:[sender intValue]];
		[maxPointBSlider setIntValue:[sender intValue]];
		
		[maxPointRLabel setIntValue:[sender intValue]];
		[maxPointGLabel setIntValue:[sender intValue]];
		[maxPointBLabel setIntValue:[sender intValue]];
	}else 
	{
		if (sender==maxPointRSlider) {
			[maxPointRLabel setIntValue:[sender intValue]];
		}
		if (sender==maxPointGSlider) {
			[maxPointGLabel setIntValue:[sender intValue]];
		}
		if (sender==maxPointBSlider) {
			[maxPointBLabel setIntValue:[sender intValue]];
		}
	}
	
	[procImage setMaxPointR:[maxPointRSlider intValue]];
	[procImage setMaxPointG:[maxPointGSlider intValue]];
	[procImage setMaxPointB:[maxPointBSlider intValue]];

}

-(IBAction)minInnerSliderMoved:(id)sender
{
	if ([minInnerTogetherButton state]==NSOnState) 
	{
		[minInnerRSlider setIntValue:[sender intValue]];
		[minInnerGSlider setIntValue:[sender intValue]];
		[minInnerBSlider setIntValue:[sender intValue]];
		
		[minInnerRLabel setIntValue:[sender intValue]];
		[minInnerGLabel setIntValue:[sender intValue]];
		[minInnerBLabel setIntValue:[sender intValue]];
	}else 
	{
		if (sender==minInnerRSlider) {
			[minInnerRLabel setIntValue:[sender intValue]];
		}
		if (sender==minInnerGSlider) {
			[minInnerGLabel setIntValue:[sender intValue]];
		}
		if (sender==minInnerBSlider) {
			[minInnerBLabel setIntValue:[sender intValue]];
		}
	}
	
	[procImage setMinInnerR:[minInnerRSlider intValue]];
	[procImage setMinInnerG:[minInnerGSlider intValue]];
	[procImage setMinInnerB:[minInnerBSlider intValue]];
}

-(IBAction)maxInnerSliderMoved:(id)sender
{
	if ([maxInnerTogetherButton state]==NSOnState) 
	{
		[maxInnerRSlider setIntValue:[sender intValue]];
		[maxInnerGSlider setIntValue:[sender intValue]];
		[maxInnerBSlider setIntValue:[sender intValue]];
		
		[maxInnerRLabel setIntValue:[sender intValue]];
		[maxInnerGLabel setIntValue:[sender intValue]];
		[maxInnerBLabel setIntValue:[sender intValue]];
	}else 
	{
		if (sender==maxInnerRSlider) {
			[maxInnerRLabel setIntValue:[sender intValue]];
		}
		if (sender==maxInnerGSlider) {
			[maxInnerGLabel setIntValue:[sender intValue]];
		}
		if (sender==maxInnerBSlider) {
			[maxInnerBLabel setIntValue:[sender intValue]];
		}
	}
	
	[procImage setMaxInnerR:[maxInnerRSlider intValue]];
	[procImage setMaxInnerG:[maxInnerGSlider intValue]];
	[procImage setMaxInnerB:[maxInnerBSlider intValue]];
}

-(IBAction)minOuterSliderMoved:(id)sender
{
	if ([minOuterTogetherButton state]==NSOnState) 
	{
		[minOuterRSlider setIntValue:[sender intValue]];
		[minOuterGSlider setIntValue:[sender intValue]];
		[minOuterBSlider setIntValue:[sender intValue]];
		
		[minOuterRLabel setIntValue:[sender intValue]];
		[minOuterGLabel setIntValue:[sender intValue]];
		[minOuterBLabel setIntValue:[sender intValue]];
	}else 
	{
		if (sender==minOuterRSlider) {
			[minOuterRLabel setIntValue:[sender intValue]];
		}
		if (sender==minOuterGSlider) {
			[minOuterGLabel setIntValue:[sender intValue]];
		}
		if (sender==minOuterBSlider) {
			[minOuterBLabel setIntValue:[sender intValue]];
		}
	}
	
	[procImage setMinOuterR:[minOuterRSlider intValue]];
	[procImage setMinOuterG:[minOuterGSlider intValue]];
	[procImage setMinOuterB:[minOuterBSlider intValue]];

}
-(IBAction)maxOuterSliderMoved:(id)sender;
{
	if ([maxOuterTogetherButton state]==NSOnState) 
	{
		[maxOuterRSlider setIntValue:[sender intValue]];
		[maxOuterGSlider setIntValue:[sender intValue]];
		[maxOuterBSlider setIntValue:[sender intValue]];
		
		[maxOuterRLabel setIntValue:[sender intValue]];
		[maxOuterGLabel setIntValue:[sender intValue]];
		[maxOuterBLabel setIntValue:[sender intValue]];
	}else 
	{
		if (sender==maxOuterRSlider) {
			[maxOuterRLabel setIntValue:[sender intValue]];
		}
		if (sender==maxOuterGSlider) {
			[maxOuterGLabel setIntValue:[sender intValue]];
		}
		if (sender==maxOuterBSlider) {
			[maxOuterBLabel setIntValue:[sender intValue]];
		}
	}
	
	[procImage setMaxOuterR:[maxOuterRSlider intValue]];
	[procImage setMaxOuterG:[maxOuterGSlider intValue]];
	[procImage setMaxOuterB:[maxOuterBSlider intValue]];
}

@end
