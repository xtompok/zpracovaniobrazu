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
		
		numBalloons = 10;
		maxSpeed = 10;
		
		
		balloonsArray = [[NSMutableArray alloc] initWithCapacity:numBalloons];
		int i;
		for (i=0;i<numBalloons;i++)
		{
			[balloonsArray addObject:(ZOBaloon *)
			 [[ZOBaloon alloc]initWithOrigin:NSMakePoint([self randFrom:0 to:width], 0) 
									  Radius:rand()%20 
									andSpeed:[self randFrom:0.1 to:maxSpeed]]];
		}
		timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerExpired:) userInfo:nil repeats:YES];
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	
	[[NSColor blackColor] set];
	NSRectFill(NSMakeRect(0, 0, 50, 50));
	int i;
	for (i=0;i<numBalloons;i++)
	{
		NSBezierPath * aPath;
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
															   andSpeed:[self randFrom:0.1 to:maxSpeed]]
								atIndex:i];
		}
	}
	[self setNeedsDisplay:YES];

}

-(void)setPoint1:(NSPoint)aPoint
{
	point1.x = aPoint.x;
	point1.y = aPoint.y;
	[self setNeedsDisplay:YES];
}
-(void)setPoint2:(NSPoint)aPoint
{
	point2.x = aPoint.x;
	point2.y = aPoint.y;
	[self setNeedsDisplay:YES];

}

-(void)resetGame
{
}

-(float)randFrom:(float)a to:(float)b
{
	return ((b-a)*((float)rand()/RAND_MAX))+a;

}
@end
