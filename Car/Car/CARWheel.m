//
//  CARWheel.m
//  Car
//
//  Created by Austen Johnson on 4/1/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "CARWheel.h"

@implementation CARWheel

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.layer.cornerRadius = 20;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
