//
//  ZOQuadTransform.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 25.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOQuadTransform.h"


@implementation ZOQuadTransform

-(id)initWithCalibrationArray:(NSArray *)calArray
{
	if (![super init])
		return nil;
	
	NSLog(@"Kalibrace: %@",calArray);
	
	NSPoint nw;
	NSPoint sw;
	NSPoint ne;
	NSPoint se;
	/*nw.x = [[calArray objectAtIndex:0] x];
	nw.y = [[calArray objectAtIndex:0] y];
	ne.x = [[calArray objectAtIndex:1] x];
	ne.y = [[calArray objectAtIndex:1] y];
	se.x = [[calArray objectAtIndex:2] x];
	se.y = [[calArray objectAtIndex:2] y];
	sw.x = [[calArray objectAtIndex:3] x];
	sw.y = [[calArray objectAtIndex:3] y];*/
	
	
	// !!! Somewhere calibration array gets mad, this fixes it
	
	 nw.x = [[calArray objectAtIndex:0] x];
	 nw.y = [[calArray objectAtIndex:0] y];
	 se.x = [[calArray objectAtIndex:1] x];
	 se.y = [[calArray objectAtIndex:1] y];
	 sw.x = [[calArray objectAtIndex:2] x];
	 sw.y = [[calArray objectAtIndex:2] y];
	 ne.x = [[calArray objectAtIndex:3] x];
	 ne.y = [[calArray objectAtIndex:3] y];
	
	d0 = nw.x; //x0,            #1
	d1 = ne.x-nw.x; // , #2
	d2 = sw.x-nw.x; //, #3
	d3 = se.x-sw.x-ne.x+nw.x; //, #4
	d4 = nw.y; //y0,            #5 
	d5 = ne.y-nw.y; // , #6
	d6 = sw.y-nw.y; //, #7
	d7 = se.y-sw.y-ne.y+nw.y; // #8
	
	NSLog(@"Quad transformation initialized");

	return self;

}
/*
####### This is the most interesting part ###########	
 
elif method == QUAD:
# quadrilateral warp.  data specifies the four corners
# given as NW, SW, SE, and NE.
#
# 03
# 12

nw = data[0:2]; sw = data[2:4]; se = data[4:6]; ne = data[6:8]
x0, y0 = nw; As = 1.0 / w; At = 1.0 / h
data = ( 
		x0,            #1
		(ne[0]-x0)*As, #2
		(sw[0]-x0)*At, #3
		(se[0]-sw[0]-ne[0]+x0)*As*At, #4
		y0,            #5 
		(ne[1]-y0)*As, #6
		(sw[1]-y0)*At, #7
		(se[1]-sw[1]-ne[1]+y0)*As*At) #8
static int
quad_transform(double* xin, double* yin, int x, int y, void* data)
{
    // quad warp: map quadrilateral to rectangle 

    double* a = (double*) data;
    double a0 = a[0]; double a1 = a[1]; double a2 = a[2]; double a3 = a[3];
    double a4 = a[4]; double a5 = a[5]; double a6 = a[6]; double a7 = a[7];

    xin[0] = a0 + a1*x + a2*y + a3*x*y;
    yin[0] = a4 + a5*x + a6*y + a7*x*y;

    return 1;
}

######## End of the interesting part ################
*/


-(NSPoint)transformPoint:(NSPoint)point
{
	if ((point.x==0)||(point.y==0)) {
		return NSMakePoint(0, 0);
	}
	
	float x;
	float y;
	
	x=point.x;
	y=point.y;
	
	NSPoint aPoint;
	aPoint.x = d0 + d1*x + d2*y + d3*x*y;
    aPoint.y = d4 + d5*x + d6*y + d7*x*y;
	return aPoint;
}

@end
