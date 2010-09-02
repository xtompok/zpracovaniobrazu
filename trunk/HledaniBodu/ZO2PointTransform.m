//
//  ZO2PointTransform.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 27.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZO2PointTransform.h"


@implementation ZO2PointTransform

// Initializes calibration constants
-(id)initWithCalibrationArray:(NSArray *)calArray
{
	if (![super init])
		return nil;
	
	[self setCalibrationArray:calArray];
	NSLog(@"2 point transformation initialized");
	
	return self;
}

-(void)setCalibrationArray:(NSArray *)calArray
{
	double m,n,i,j;
	
	// Sets array with calibration points
	CP[0].x=[[calArray objectAtIndex:0] x];
	CP[0].y=[[calArray objectAtIndex:0] y];
	
	CP[1].x=[[calArray objectAtIndex:1] x];
	CP[1].y=[[calArray objectAtIndex:1] y];
	
	CP[2].x=[[calArray objectAtIndex:2] x];
	CP[2].y=[[calArray objectAtIndex:2] y];
	
	CP[3].x=[[calArray objectAtIndex:3] x];
	CP[3].y=[[calArray objectAtIndex:3] y];
	
	// Computes parametres for equations of lines
	k=(double)(CP[0].y-CP[1].y)/(CP[0].x-CP[1].x);
	l=(double)CP[0].y-k*CP[0].x;
	
	m=(double)(CP[3].y-CP[2].y)/(CP[3].x-CP[2].x);
	n=(double)CP[3].y-k*CP[3].x;
	
	g=(double)(CP[0].y-CP[3].y)/(CP[0].x-CP[3].x);
	h=(double)CP[0].y-g*CP[0].x;
	
	i=(double)(CP[2].y-CP[1].y)/(CP[2].x-CP[1].x);
	j=(double)CP[1].y-g*CP[1].x;
	
	// Computes coordinates of helping calibrations points Q and W
	PTB[0].x=(n-l)/(k-m);
	PTB[0].y=PTB[0].x*k+l;
	
	PTB[1].x=(j-h)/(i-g);
	PTB[1].y=PTB[1].x*g+h;
	
	//01
	//32
	
	// Computes lengths of sides of quadrilateral
	PTD[0]=sqrt((CP[0].x-CP[3].x)*(CP[0].x-CP[3].x)+(CP[0].y-CP[3].y)*(CP[0].y-CP[3].y));
	PTD[1]=sqrt((CP[0].x-CP[1].x)*(CP[0].x-CP[1].x)+(CP[0].y-CP[1].y)*(CP[0].y-CP[1].y));
	PTD[2]=sqrt((CP[2].x-CP[1].x)*(CP[2].x-CP[1].x)+(CP[2].y-CP[1].y)*(CP[2].y-CP[1].y));
	PTD[3]=sqrt((CP[3].x-CP[2].x)*(CP[3].x-CP[2].x)+(CP[3].y-CP[2].y)*(CP[3].y-CP[2].y));
	
	NSLog(@"New 2 point transformation initialized");
}

// Transform supplied point
-(NSPoint)transformPoint:(NSPoint)point
{
	//return point;
	
	NSPoint alfa,beta;
	double xpomer,ypomer;
	double e,f,o,p;
	
	if ((point.x==0)&&(point.y==0)) {
		NSPoint transPoint;
		
		transPoint.x=0;
		transPoint.y=0;
		return transPoint;
	}
	
	// Computes parametres of equations of lines going through point and helping calibration point
	e=(double)(PTB[0].y-point.y)/(PTB[0].x-point.x);
	f=point.y-e*point.x;
	
	o=(double)(PTB[1].y-point.y)/(PTB[1].x-point.x);
	p=point.y-o*point.x;
	
	// Computes coordinates of intersection of line above and side of quadrilateral
	alfa.x=(h-f)/(e-g);
	alfa.y=e*alfa.x+f;
	
	beta.x=(l-p)/(o-k);
	beta.y=o*beta.x+p;
	
	// Computes ratio between |alphaA| and |AB| etc.
	ypomer=sqrt((CP[0].x-alfa.x)*(CP[0].x-alfa.x)+(CP[0].y-alfa.y)*(CP[0].y-alfa.y))/PTD[0]; 
	xpomer=sqrt((CP[0].x-beta.x)*(CP[0].x-beta.x)+(CP[0].y-beta.y)*(CP[0].y-beta.y))/PTD[1];
	
	
	NSPoint transPoint;
	
	transPoint.x=xpomer;
	transPoint.y=ypomer;
	return transPoint;

}



@end
