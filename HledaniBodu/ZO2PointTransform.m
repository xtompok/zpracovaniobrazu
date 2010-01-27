//
//  ZO2PointTransform.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 27.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZO2PointTransform.h"


@implementation ZO2PointTransform

-(id)initWithCalibrationArray:(int *)modCalArray andSize:(NSSize)aSize
{
	if (![super init])
		return nil;
	int posun;
	double k,l,i,j;
	
	size=aSize;
	posun=5;
	CP[0].x=modCalArray[0];
	CP[0].y=modCalArray[1];
	
	CP[1].x=modCalArray[2];
	CP[1].y=modCalArray[3];
	
	CP[2].x=modCalArray[4];
	CP[2].y=modCalArray[5];
	
	CP[3].x=modCalArray[6];
	CP[3].y=modCalArray[7];
	
	
	k=(double)(CP[0].y-CP[1].y)/(CP[0].x-CP[1].x);
	l=(double)CP[0].y-k*CP[0].x;
	
	m=(double)(CP[3].y-CP[2].y)/(CP[3].x-CP[2].x);
	n=(double)CP[3].y-k*CP[3].x;
	
	PTB[0].x=(n-l)/(k-m);
	PTB[0].y=PTB[0].x*k+l;
	
	g=(double)(CP[0].y-CP[3].y)/(CP[0].x-CP[3].x);
	h=(double)CP[0].y-g*CP[0].x;
	
	i=(double)(CP[1].y-CP[2].y)/(CP[1].x-CP[2].x);
	j=(double)CP[1].y-g*CP[1].x;
	
	PTB[1].x=(j-h)/(g-i);
	PTB[1].y=PTB[1].x*g+h;
	
	
	PTD[0]=sqrt((CP[0].x-CP[3].x)*(CP[0].x-CP[3].x)+(CP[0].y-CP[3].y)*(CP[0].y-CP[3].y));
	PTD[1]=sqrt((CP[2].x-CP[3].x)*(CP[2].x-CP[3].x)+(CP[2].y-CP[3].y)*(CP[2].y-CP[3].y));
	
	return self;
}


-(NSPoint)transformPoint:(NSPoint)point
{
	NSPoint alfa,beta;
	double xpomer,ypomer;
	double e,f,o,p;
	
	e=(double)(PTB[0].y-point.y)/(PTB[0].x-point.x);
	f=point.y-e*point.x;
	
	o=(double)(PTB[1].y-point.y)/(PTB[1].x-point.x);
	p=point.y-o*point.x;
	
	alfa.x=(h-f)/(e-g);
	alfa.y=e*alfa.x+f;
	
	beta.x=(n-p)/(o-m);
	beta.y=o*beta.x+p;
	
	ypomer=sqrt((CP[0].x-alfa.x)*(CP[0].x-alfa.x)+(CP[0].y-alfa.y)*(CP[0].y-alfa.y))/PTD[1];
	xpomer=sqrt((CP[3].x-beta.x)*(CP[3].x-beta.x)+(CP[3].y-beta.y)*(CP[3].y-beta.y))/PTD[1];
	
	point.x=point.x*size.width*xpomer;
	point.y=point.y*size.height*ypomer;
	return point;
}



@end
