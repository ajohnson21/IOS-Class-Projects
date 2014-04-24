//
//  TLANavController.h
//  TweetLike
//
//  Created by Austen Johnson on 4/23/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLATableViewController;

@interface TLANavController : UINavigationController

-(void)addTableViewController:(TLATableViewController *)viewController;

@end
