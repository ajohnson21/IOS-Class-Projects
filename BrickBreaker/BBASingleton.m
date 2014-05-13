//
//  BBASingleton.m
//  BrickBreaker
//
//  Created by Austen Johnson on 5/6/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "BBASingleton.h"

@implementation BBASingleton

+(BBASingleton *)mainData
{
    static dispatch_once_t create;
    static BBASingleton * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[BBASingleton alloc] init];
    });
    
    return singleton;
}

-(void)setCurrentScore:(NSInteger)currentScore
{
    _currentScore = currentScore;
    
    if (currentScore > _topScore) _topScore = currentScore;
    
    NSLog(@"currentScore %d topScore %d", currentScore, _topScore);
    
}

-(NSArray *)gameScores
{
    return @[];
}


@end
