//
//  ZOQuadTransform.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 25.8.10.
//  Copyright 2010 Jaroška. All rights reserved.
//
/*
 --------------------------------------------------------------------
 Software License
 --------------------------------------------------------------------
 
 The Python Imaging Library is
 
 Copyright (c) 1997-2009 by Secret Labs AB
 Copyright (c) 1995-2009 by Fredrik Lundh
 
 By obtaining, using, and/or copying this software and/or its
 associated documentation, you agree that you have read, understood,
 and will comply with the following terms and conditions:
 
 Permission to use, copy, modify, and distribute this software and its
 associated documentation for any purpose and without fee is hereby
 granted, provided that the above copyright notice appears in all
 copies, and that both that copyright notice and this permission notice
 appear in supporting documentation, and that the name of Secret Labs
 AB or the author not be used in advertising or publicity pertaining to
 distribution of the software without specific, written prior
 permission.
 
 SECRET LABS AB AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO
 THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS.  IN NO EVENT SHALL SECRET LABS AB OR THE AUTHOR BE LIABLE FOR
 ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
 OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 
 
 */



#import "ZOQuadTransform.h"


@implementation ZOQuadTransform

-(id)initWithCalibrationArray:(NSArray *)calArray
{
	if (![super init])
		return nil;
	[self setCalibrationArray:calArray];

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
-(void)setCalibrationArray:(NSArray *)calArray
{
	float x1, x2, x3, x4;
	float y1, y2, y3, y4;
	float a0, a1, a2, a3, a4, a5, a6, a7;
	
	x1=[[calArray objectAtIndex:0] x];
	y1=[[calArray objectAtIndex:0] y];
	
	x2 = [[calArray objectAtIndex:1] x];
	y2 = [[calArray objectAtIndex:1] y];
	
	x3 = [[calArray objectAtIndex:3] x];
	y3 = [[calArray objectAtIndex:3] y];
	
	x4 = [[calArray objectAtIndex:2] x];
	y4 = [[calArray objectAtIndex:2] y];
	
	a0 = (x1 *(x4 *(-y2 + y3) + x3 *(y2 - y4)) + x2 *(x4 *(y1 - y3) + x3 *(-y1 + y4)))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a1 = (x4 *(x3 *(-y1 + y2) + x1 *(-y2 + y3)) + x2 *(x3 *(y1 - y4) + x1 *(-y3 + y4)))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a2 = x1;
	a3 = (x4 *(y1 - y2) *y3 + x1 *y2 *(y3 - y4) + x3 *(-y1 + y2)* y4 + x2* y1* (-y3 + y4))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a4 = (x4 *y2 *(-y1 + y3) + x3 *y1 *(y2 - y4) + x2 *(y1 - y3)* y4 + x1* y3* (-y2 + y4))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a5 = y1;
	a6 = (-(x3 - x4)* (y1 - y2) + (x1 - x2) *(y3 - y4))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	a7 = ((x2 - x4) *(y1 - y3) - (x1 - x3) *(y2 - y4))/(x4 *(y2 - y3) + x2 *(y3 - y4) + x3 *(-y2 + y4)); 
	
	m0= (a4 - a5*a7)/(-(a1*a3) + a0*a4 - a2*a4*a6 + a1*a5*a6 + a2*a3*a7 - a0*a5*a7);
	m1= (a1 - a2*a7)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	m2= (a2*a4 - a1*a5)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	m3= (a3 - a5*a6)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	m4= (a0 - a2*a6)/(-(a1*a3) + a0*a4 - a2*a4*a6 + a1*a5*a6 + a2*a3*a7 - a0*a5*a7);
	m5= (a2*a3 - a0*a5)/(-(a1*a3) + a0*a4 - a2*a4*a6 + a1*a5*a6 + a2*a3*a7 - a0*a5*a7);
	m6= (a4*a6 - a3*a7)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	m7= (a1*a6 - a0*a7)/(-(a1*a3) + a0*a4 - a2*a4*a6 + a1*a5*a6 + a2*a3*a7 - a0*a5*a7);
	m8= (a1*a3 - a0*a4)/(a1*a3 - a0*a4 + a2*a4*a6 - a1*a5*a6 - a2*a3*a7 + a0*a5*a7);
	
	
		
	NSLog(@"New Quad transformation initialized");

}


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
    aPoint.x = (m0*x+m1*y+m2)/(m6*x+m7*y+m8);
	aPoint.y = (m3*x+m4*y+m5)/(m6*x+m7*y+m8);
	return aPoint;
}

@end
