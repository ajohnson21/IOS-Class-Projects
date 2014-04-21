//
//  TIAViewController.h
//  TweetIt
//
//  Created by Austen Johnson on 4/21/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIAViewController : UIViewController

#define NAME_KEY tweet[@"name"]

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@property (nonatomic) NSDictionary * tweet;

@end
