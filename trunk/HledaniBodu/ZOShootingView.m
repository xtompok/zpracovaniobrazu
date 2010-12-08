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
		
		score = 0;
		lostBalloons = 0;
		
		color = [[[NSColor blueColor] shadowWithLevel:0.5] retain];
		
		
		GAMEDATA data;
		data.maxSpeed = 10;
		data.maxBalloons = 10;
		data.maxLost = 100;
		data.delay = 0.05;
		data.maxShots = 1;
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
	int i;
	for (i=0;i<numBalloons;i++)
	{
		NSBezierPath * aPath;
		
		[[[balloonsArray objectAtIndex:i] color] set];
		aPath = [[balloonsArray objectAtIndex:i] balloonPath];
		
		[aPath fill];
		[aPath stroke];
	}
	
	NSDictionary * textAttr;
	textAttr = [[NSDictionary alloc] initWithObjectsAndKeys:
				[NSFont boldSystemFontOfSize:32.0], NSFontAttributeName,
				[NSColor grayColor],NSForegroundColorAttributeName,
				nil];
	[[NSString stringWithFormat:@"%d",score] drawAtPoint:NSMakePoint(0,0) withAttributes:textAttr];
	[[NSString stringWithFormat:@"%d",lostBalloons] drawAtPoint:NSMakePoint(width-50, 0) withAttributes: textAttr];
	[textAttr release];
	if (lostBalloons>maxLost) {
		textAttr = [[NSDictionary alloc] initWithObjectsAndKeys:
					[NSFont boldSystemFontOfSize:64.0], NSFontAttributeName, 
					[NSColor greenColor], NSForegroundColorAttributeName,
					nil];
		[[NSString stringWithFormat:@"You loose!" ] drawAtPoint:NSMakePoint(width/2-100, height/2) withAttributes: textAttr];
		[textAttr release];
		
	}
	[[NSColor greenColor] set];
	[[self crossAtPoint:point1] stroke];

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
			[balloonsArray insertObject:[[ZOBaloon alloc]initWithOrigin:NSMakePoint([self randFrom:0 to:width], height) 
																 Radius:(int)[self randFrom:minSize to:maxiSize]
																  Speed:[self randFrom:0.1 to:maxSpeed]
															   andColor:color]
								atIndex:i];
			lostBalloons++;
		}
		if (([[balloonsArray objectAtIndex:i] shots]>=maxShots)&&(lostBalloons<=maxShots)) {
			[balloonsArray removeObjectAtIndex:i];
			[balloonsArray insertObject:[[ZOBaloon alloc]initWithOrigin:NSMakePoint([self randFrom:0 to:width], height) 
																 Radius:(int)[self randFrom:minSize to:maxiSize]
																  Speed:[self randFrom:0.1 to:maxSpeed]
															   andColor:color]
								atIndex:i];
			score++;			
			
		}
	}
	[self setNeedsDisplay:YES];

}

-(void)setPoint1:(NSPoint)aPoint
{
	point1.x = aPoint.x*[self bounds].size.width;
	point1.y = aPoint.y*[self bounds].size.height;
	int i;
	//NSLog(@"Set");
	for (i=0;i<[balloonsArray count];i++)
	{
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
	numBalloons = aData->maxBalloons;
	maxSpeed = aData->maxSpeed;
	maxLost = aData->maxLost;
	maxShots = aData->maxShots;
	
	maxiSize = aData->maxiSize;
	minSize = aData->minSize;
	
	lostBalloons = 0;
	
	[balloonsArray release];
	balloonsArray = [[NSMutableArray alloc] initWithCapacity:aData->maxBalloons];
	int i;
	for (i=0;i<numBalloons;i++)
	{
		[balloonsArray addObject:(ZOBaloon *)
		 [[ZOBaloon alloc]initWithOrigin:NSMakePoint([self randFrom:0 to:width], height) 
								  Radius:(int)[self randFrom:minSize to:maxiSize]
								   Speed:[self randFrom:0.1 to:aData->maxSpeed]
								andColor:color]];
	}
	score = 0;
	[timer invalidate];
	timer = [NSTimer scheduledTimerWithTimeInterval:aData->delay target:self selector:@selector(timerExpired:) userInfo:nil repeats:YES];
	
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

-(float)randFrom:(float)a to:(float)b
{
	return ((b-a)*((float)rand()/RAND_MAX))+a;

}
@end
