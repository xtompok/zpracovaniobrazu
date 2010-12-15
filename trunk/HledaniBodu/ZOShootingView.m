//
//  ZOShootingView.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 6.12.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ZOShootingView.h"

#define START_TIMER timer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(timerExpired:) userInfo:nil repeats:YES];


@implementation ZOShootingView


- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		width = [self bounds].size.width;
		height = [self bounds].size.height;
		
		score = 0;
		lostBalloons = 0;
		
		color = [[[NSColor blueColor] shadowWithLevel:0.5] retain];
		
		
		GAMEDATA data;
		data.maxSpeed = 10;
		data.maxBalloons = 10;
		data.maxLost = 100;
		data.delay = 0.05;
		data.maxShots = 2;
		data.minSize = 10;
		data.maxiSize = 50;
		
		[self resetGameWithData:&data];
		        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	
	[[NSColor blackColor] set];
	NSRectFill([self bounds]);
	
	// Draw balloons
	int i;
	for (i=0;i<numBalloons;i++)
	{
		NSBezierPath * aPath;
		
		[[[balloonsArray objectAtIndex:i] color] set];
		aPath = [[balloonsArray objectAtIndex:i] balloonPath];
		
		[aPath fill];
		[aPath stroke];
	}
	
	// Draw texts
	NSDictionary * textAttr;
	textAttr = [[NSDictionary alloc] initWithObjectsAndKeys:
				[NSFont boldSystemFontOfSize:32.0], NSFontAttributeName,
				[NSColor grayColor],NSForegroundColorAttributeName,
				nil];
	[[NSString stringWithFormat:@"%d",score] drawAtPoint:NSMakePoint(0,0) withAttributes:textAttr];
	[[NSString stringWithFormat:@"%d",lostBalloons] drawAtPoint:NSMakePoint(width-50, 0) withAttributes: textAttr];
	[textAttr release];
	
	// Draw loose text
	if (lostBalloons>maxLost) {
		textAttr = [[NSDictionary alloc] initWithObjectsAndKeys:
					[NSFont boldSystemFontOfSize:64.0], NSFontAttributeName, 
					[NSColor greenColor], NSForegroundColorAttributeName,
					nil];
		[[NSString stringWithFormat:@"You loose!" ] drawAtPoint:NSMakePoint(width/2-100, height/2) withAttributes: textAttr];
		[textAttr release];
	}
	
	
	// Draw cross at point
	[[NSColor greenColor] set];
	[[self crossAtPoint:point1] stroke];

}

-(void)timerExpired:(NSTimer *)aTimer
{
	int i;
	for(i=0;i<[balloonsArray count];i++)
	{
		// Move balloons
		[[balloonsArray objectAtIndex:i] move];
		
		// Replace balloons outside of bounds
		if (!NSIntersectsRect([self bounds], [[[balloonsArray objectAtIndex:i] balloonPath] bounds])) {
			[balloonsArray removeObjectAtIndex:i];
			[self insertBalloonAtIndex:i];
			lostBalloons++;
		}
		
		// Replace shooted ballons
		if (([[balloonsArray objectAtIndex:i] shots]>=maxShots)&&(lostBalloons<=maxShots)) {
			[balloonsArray removeObjectAtIndex:i];
			[self insertBalloonAtIndex:i];
			score++;			
			
		}
	}
	[self setNeedsDisplay:YES];

}

-(void)setPoint1:(NSPoint)aPoint
{
	// Compute real coordinates
	point1.x = aPoint.x*width;
	point1.y = aPoint.y*height;
	
	if (paused) {
		START_TIMER
		paused = NO;
	}
	
	int i;
	for (i=0;i<[balloonsArray count];i++)
	{	
		// Find shooted balloons
		if ([[[balloonsArray objectAtIndex:i] balloonPath] containsPoint:point1]) {
			[[balloonsArray objectAtIndex:i] shooted];
			NSLog(@"Shooted");
		}
	}
	[self setNeedsDisplay:YES];
}
-(void)setPoint2:(NSPoint)aPoint
{
	point2.x = aPoint.x*[self bounds].size.width;
	point2.y = aPoint.y*[self bounds].size.height;
	[self setNeedsDisplay:YES];

}

-(void)resetGameWithData:(GAMEDATA *) aData
{	
	
	// Set global variables
	numBalloons = aData->maxBalloons;
	maxSpeed = aData->maxSpeed;
	maxLost = aData->maxLost;
	maxShots = aData->maxShots;
	
	maxiSize = aData->maxiSize;
	minSize = aData->minSize;
	
	delay = aData->delay;
	
	lostBalloons = 0;
	
	// Generate new balloons
	[balloonsArray release];
	balloonsArray = [[NSMutableArray alloc] initWithCapacity:aData->maxBalloons];
	int i;
	for (i=0;i<numBalloons;i++)
	{
		[self insertBalloonAtIndex:i];
	}
	score = 0;
	[timer invalidate];
	paused = YES;
}

-(BOOL)isFlipped
{
	return YES;
}

-(NSBezierPath *)crossAtPoint:(NSPoint)aPoint
{
	int r;
	r=10;
	NSBezierPath *aPath;
	aPath=[NSBezierPath bezierPath];
	[aPath moveToPoint:NSMakePoint(aPoint.x-r, aPoint.y-r)];
	[aPath lineToPoint:NSMakePoint(aPoint.x+r, aPoint.y+r)];
	[aPath moveToPoint:NSMakePoint(aPoint.x-r, aPoint.y+r)];
	[aPath lineToPoint:NSMakePoint(aPoint.x+r, aPoint.y-r)];
	return aPath;
}

-(void)setPaused:(BOOL)isPaused
{
	if(isPaused){
		[timer invalidate];
	
	}else {
		START_TIMER
	}
	paused = isPaused;

}
		 
-(void)insertBalloonAtIndex:(int)i
{
	[balloonsArray insertObject:(ZOBaloon *)
	 [[ZOBaloon alloc]initWithOrigin:NSMakePoint([self randFrom:0 to:width], height) 
								Size:(int)[self randFrom:minSize to:maxiSize]
							   Speed:[self randFrom:0.1 to:maxSpeed]
							andColor:[[NSColor colorWithDeviceRed:0 
															green:[self randFrom:0.1 to:0.5] 
															 blue:[self randFrom:0.1 to:0.5] 
															alpha:1] retain]]
					 atIndex: i];
}


-(float)randFrom:(float)a to:(float)b
{
	return ((b-a)*((float)rand()/RAND_MAX))+a;

}
@end
