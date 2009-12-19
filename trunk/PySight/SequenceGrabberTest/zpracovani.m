//
//  zpracovani.m
//  SequenceGrabberTest
//
//  Created by Tomáš Pokorný on 17.12.09.
//  Copyright 2009 Jaroška. All rights reserved.
//

#import "zpracovani.h"


@implementation zpracovani

@synthesize buffer;

+(zpracovani*)createBufferfromArray:(unsigned char *)abuffer
				withsize:(NSSize)asize 
				lenght:(int)alength
{
	return [[[self alloc] initWithBuffer:abuffer withsize:asize lenght:alength]autorelease];
}
-(id)initWithBuffer:(unsigned char *)abuffer withsize:(NSSize)asize lenght:(int)alength
{
	if (self=[self init]) {
		buffer=abuffer;
		length=alength;
		size=asize;
		return self;
	}

}

-(void)inverseColor
{
	for(i=0;i<length;i++)
	{
		if(((i+1)%4)!=0)
		{
			buffer[i]=255-buffer[i];
		}
	}
}
-(void)moduleWithNumber:(int)modul
{
	for(i=0;i<length;i++)
	{
		if(((i+1)%4)!=0)
		{
			buffer[i]%=modul;
		}
	}
}
-(void)makeChanges
{


}

-(void)dealloc
{


}

@end
/*
int getPixelAddress(int x, int y)
{
	return &buffer[y*size.width+x];
}*/

