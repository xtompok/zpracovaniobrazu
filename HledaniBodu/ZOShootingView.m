//
//  ZOShootingView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOShootingView.h"


@implementation ZOShootingView


- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		width = 800;
		height = 600;
		
		GAMEDATA data;
		data.maxSpeed = 10;
		data.maxBalloons = 10;
		data.maxBalloons = 10;
		data.delay = 0.05;
		[self resetGameWithData:&data];
		        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	
	[[NSColor blackColor] set];
//	NSRectFill([self bounds]);
	int i;
	for (i=0;i<numBalloons;i++)
	{
		NSBezierPath * aPath;
		
		[[[balloonsArray objectAtIndex:i] color] set];
		aPath = [[balloonsArray objectAtIndex:i] balloonPath];
		
		[aPath fill];
		[aPath stroke];
		

		
	
	}
    // Drawing code here.
}

-(void)timerExpired:(NSTimer *)aTimer
{
	int i;
	for(i=0;i<[balloonsArray count];i++)
	{
		[[balloonsArray objectAtIndex:i] move];
		if (!NSIntersectsRect([self bounds], [[[balloonsArray objectAtIndex:i] balloonPath] bounds])) {
			[balloonsArray removeObjectAtIndex:i];
			[balloonsArray insertObject:[[ZOBaloon alloc]initWithOrigin:NSMakePoint([self randFrom:0 to:width], 0) 
																 Radius:rand()%20 
																  Speed:[self randFrom:0.1 to:maxSpeed]
															   andColor:[NSColor blueColor]]
								atIndex:i];
			lostBalloons++;
		}
	}
	[self setNeedsDisplay:YES];

}

-(void)setPoint1:(NSPoint)aPoint
{
	point1.x = aPoint.x;
	point1.y = aPoint.y;
	int i;
	for (i=0;i<[balloonsArray count];i++)
	{
		if ([[[balloonsArray objectAtIndex:i] balloonPath] containsPoint:point1]) {
			[[balloonsArray objectAtIndex:i] shooted];
		}
	}
	[self setNeedsDisplay:YES];
}
-(void)setPoint2:(NSPoint)aPoint
{
	point2.x = aPoint.x;
	point2.y = aPoint.y;
	[self setNeedsDisplay:YES];

}

-(void)resetGameWithData:(GAMEDATA *) aData
{	
	numBalloons = aData->maxBalloons;
	maxSpeed = aData->maxSpeed;
	maxLost = aData->maxLost;
	
	lostBalloons = 0;
	
	[balloonsArray release];
	balloonsArray = [[NSMutableArray alloc] initWithCapacity:aData->maxBalloons];
	int i;
	for (i=0;i<numBalloons;i++)
	{
		[balloonsArray addObject:(ZOBaloon *)
		 [[ZOBaloon alloc]initWithOrigin:NSMakePoint([self randFrom:0 to:width], 0) 
								  Radius:rand()%20 
								   Speed:[self randFrom:0.1 to:aData->maxSpeed]
								andColor:[NSColor blueColor]]];
	}
	[timer invalidate];
	timer = [NSTimer scheduledTimerWithTimeInterval:aData->delay target:self selector:@selector(timerExpired:) userInfo:nil repeats:YES];
	
}

-(float)randFrom:(float)a to:(float)b
{
	return ((b-a)*((float)rand()/RAND_MAX))+a;

}
@end
