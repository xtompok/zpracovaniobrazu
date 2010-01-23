//
//  ZOTransform.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 13.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOTransform.h"


@implementation ZOTransform

-(id)initWithCalibrationArray:(int *)modCalArray andSize:(NSSize)aSize
{
	if (![super init])
		return nil;
	int posun;
	int calArray[4][2];
	
	size=aSize;
	posun=5;
	calArray[0][0]=modCalArray[0];
	calArray[0][1]=modCalArray[1];
	
	calArray[1][0]=modCalArray[2];
	calArray[1][1]=modCalArray[3];
	
	calArray[2][0]=modCalArray[4];
	calArray[2][1]=modCalArray[5];
	
	calArray[3][0]=modCalArray[6];
	calArray[3][1]=modCalArray[7];
	
	PTK[0][0]=
		(double)(calArray[0][0]+calArray[2][0]-calArray[1][0]-calArray[3][0])/((size.width-posun)*(size.height-posun));
	PTK[0][1]=
		(double)(calArray[0][1]+calArray[2][1]-calArray[1][1]-calArray[3][1])/((size.width-posun)*(size.height-posun));
	
	PTK[1][0]=
		(double)(-calArray[0][0]+calArray[3][0])/(size.height-posun);
	PTK[1][1]=
		(double)(-calArray[0][1]+calArray[3][1])/(size.height-posun);
	
	PTK[2][0]=
		(double)(calArray[1][0]-calArray[0][0])/(size.width-posun);
	PTK[2][1]=
		(double)(calArray[1][1]-calArray[0][1])/(size.width-posun);
	
	PTK[3][0]=(double)calArray[0][0];
	PTK[3][1]=(double)calArray[0][1];
	
	return self;
}

-(double)getRightRootOfPolynomWithA:(double)a B:(double)b andC:(double)c
{
	double diskriminant, root1, root2;
	diskriminant=b*b-4*a+c;
	if (diskriminant<0) {
		NSLog(@"Bad discriminant");
		return (double)-100;
	} else if (a==0) {
		NSLog(@"Zero division");
		return (double)-100;
	}
	root1=(-b+sqrt(diskriminant)/(2*a));
	root2=(-b-sqrt(diskriminant)/(2*a));
	if ((size.width>=root1)&&(root1>=0)) 
	{
		return root1;
	} 
	else if ((size.width>=root2)&&(root2>=0)) 
	{
		return root2;
	} else {
		NSLog(@"Root out of range");
		return 0;
	}

}
// 01
// 32

-(NSPoint)transformPoint:(NSPoint)point
{
	double d1,d2,d3;
	
	d1=PTK[0][0]*PTK[1][1]+PTK[1][0]*PTK[0][1];
	d2=PTK[0][1]*PTK[3][0]-point.x*PTK[0][1]+PTK[1][1]*PTK[2][0]-PTK[1][0]*PTK[2][1]+PTK[3][0]*PTK[0][0]-PTK[0][0]*point.y;
	d3=point.x*PTK[2][1]+PTK[2][0]*PTK[3][0]-PTK[2][1]*PTK[3][0]-point.y*PTK[2][0];
	point.y=[self getRightRootOfPolynomWithA:d1 B:d2 andC:d3];
	point.x=(point.y*PTK[1][0]+PTK[3][0]-point.x)/(-point.y*PTK[0][0]-PTK[2][0]);
	return point;
}
@end

/*
 def kvadrat(a,b,c):
 diskr=b*b-4*a*c
 if diskr>=0 and a!=0:
	koren1=(-b+sqrt(diskr))/(2*a)
	koren2=(-b-sqrt(diskr))/(2*a)
	if 800>koren1>0:
		return koren1
	elif 800>koren1>0:
		return koren2
	else:
		print "O"
		return 0
 else:
	print "Z"
	return -100
 
 def karltrans(x,y):
 if x<=0 or y<=0: return (-100, -100)
 c1x=kkonst[1][0]
 c1y=kkonst[1][1]
 c2x=kkonst[2][0]
 c2y=kkonst[2][1]
 c3x=kkonst[3][0]
 c3y=kkonst[3][1]
 c4x=kkonst[4][0]
 c4y=kkonst[4][1]
 
 
 d1=c1x*c2y+c2x*c1y
 d2=c1y*c4x-x*c1y+c2y*c3x-c2x*c3y+c4x*c1x-c1x*y
 d3=x*c3y+c3x*c4x-c3y*c4x-y*c3x
 ytrans=kvadrat(d1,d2,d3)
 xtrans=(ytrans*c2x+c4x-x)/(-ytrans*c1x-c3x)
 return (xtrans,ytrans)
 
 
 
 
 def vypocti_kkonst(kalibK,kalibP):
 init.root_stat.config(text="kK"+kalibK.__str__())
 p0=(kalibK[0][0]+kalibK[2][0]-kalibK[1][0]-kalibK[3][0])/(kalibP[1][0]*kalibP[2][1]*1.0)
 p1=(kalibK[0][1]+kalibK[2][1]-kalibK[1][1]-kalibK[3][1])/(kalibP[1][0]*kalibP[2][1]*1.0)
 kkonst[1]=(p0,p1)
 
 p0=(-kalibK[0][0]+kalibK[3][0])/(kalibP[2][1]*1.0)
 p1=(-kalibK[0][1]+kalibK[3][1])/(kalibP[2][1]*1.0)
 kkonst[2]=(p0,p1)
 
 p0=(kalibK[1][0]-kalibK[0][0])/(kalibP[1][0]*1.0)
 p1=(kalibK[1][1]-kalibK[0][1])/(kalibP[1][0]*1.0)
 kkonst[3]=(p0,p1)
 
 p0=kalibK[0][0]
 p1=kalibK[0][1]
 kkonst[4]=(p0,p1)
 
 
 */