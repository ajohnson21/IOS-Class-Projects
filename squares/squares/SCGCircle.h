//
//  SCGCircle.h
//  squares
//
//  Created by Austen Johnson on 4/11/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCGCircleDelegate;

@interface SCGCircle : UIView

@property (nonatomic, assign) id<SCGCircleDelegate> delegate;

@property (nonatomic) CGPoint position;

@end

@protocol SCGCircleDelegate <NSObject>

- (UIColor *)circleTappedWithgPosition:(CGPoint)position;

@end