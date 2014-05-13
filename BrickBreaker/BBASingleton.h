//
//  BBASingleton.h
//  BrickBreaker
//
//  Created by Austen Johnson on 5/6/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBASingleton : NSObject

+ (BBASingleton *)mainData;

@property (nonatomic, readonly) NSInteger topScore;
@property (nonatomic) NSInteger currentScore;

- (NSArray *)gameScores;

@end
