//
//  TLATableViewController.h
//  TweetLike
//
//  Created by Austen Johnson on 4/23/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLATableViewController : UITableViewController

-(void)moveTweetsToDictionary:(NSString *)tweet;
@property (nonatomic) NSMutableArray * tweetList;

@property (nonatomic, getter = isTweetItemsEmpty,readonly) BOOL tweetItemsEmpty;


@end
