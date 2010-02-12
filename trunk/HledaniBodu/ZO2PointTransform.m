//
//  ZO2PointTransform.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 27.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOPoint.h"
#import "ZO2PointTransform.h"


@implementation ZO2PointTransform

-(id)initWithCalibrationArray:(NSArray *)calArray
{
	if (![super init])
		return nil;
	//int posun;
	double m,n,i,j;
	
	CP[0].x=[[calArray objectAtIndex:0] xValue];
	CP[0].y=[[calArray objectAtIndex:0] yValue];
	
	CP[1].x=[[calArray objectAtIndex:1] xValue];
	CP[1].y=[[calArray objectAtIndex:1] yValue];
	
	CP[2].x=[[calArray objectAtIndex:2] xValue];
	CP[2].y=[[calArray objectAtIndex:2] yValue];
	
	CP[3].x=[[calArray objectAtIndex:3] xValue];
	CP[3].y=[[calArray objectAtIndex:3] yValue];

	k=(double)(CP[0].y-CP[1].y)/(CP[0].x-CP[1].x);
	l=(double)CP[0].y-k*CP[0].x;
	
	m=(double)(CP[3].y-CP[2].y)/(CP[3].x-CP[2].x);
	n=(double)CP[3].y-k*CP[3].x;
	
	PTB[0].x=(n-l)/(k-m);
	PTB[0].y=PTB[0].x*k+l;
	
	g=(double)(CP[0].y-CP[3].y)/(CP[0].x-CP[3].x);
	h=(double)CP[0].y-g*CP[0].x;
	
	i=(double)(CP[2].y-CP[1].y)/(CP[2].x-CP[1].x);
	j=(double)CP[1].y-g*CP[1].x;
	
	PTB[1].x=(h-j)/(i-g);
	PTB[1].y=PTB[1].x*g+h;
	
	
	PTD[0]=sqrt((CP[0].x-CP[3].x)*(CP[0].x-CP[3].x)+(CP[0].y-CP[3].y)*(CP[0].y-CP[3].y));
	PTD[1]=sqrt((CP[0].x-CP[1].x)*(CP[0].x-CP[1].x)+(CP[0].y-CP[1].y)*(CP[0].y-CP[1].y));
	
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
	
	beta.x=(l-p)/(o-k);
	beta.y=o*beta.x+p;
	
	ypomer=sqrt((CP[0].x-alfa.x)*(CP[0].x-alfa.x)+(CP[0].y-alfa.y)*(CP[0].y-alfa.y))/PTD[0];
	xpomer=sqrt((CP[0].x-beta.x)*(CP[0].x-beta.x)+(CP[0].y-beta.y)*(CP[0].y-beta.y))/PTD[1];
	
	NSPoint transPoint;
	
	
	transPoint.x=xpomer;
	transPoint.y=ypomer;
	return transPoint;
}



@end
