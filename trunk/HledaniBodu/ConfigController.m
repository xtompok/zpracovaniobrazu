//
//  ConfigController.m
//  HledaniBodu
//
//  Created by Tomáš Pokorný on 8.1.10.
//  Copyright 2010 Jaroška. All rights reserved.
//

#import "ConfigController.h"


@implementation ConfigController



- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		[rSlider intValue];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

@end
