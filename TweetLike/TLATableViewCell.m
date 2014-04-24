//
//  TLATableViewCell.m
//  TweetLike
//
//  Created by Austen Johnson on 4/23/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TLATableViewCell.h"
#import "TLATableViewController.h"

@implementation TLATableViewCell
{
    UILabel * tweets;
    UILabel * likes;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView * heart = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 20, 20)];
        heart.image = [UIImage imageNamed:@"heart"];
        [self.contentView addSubview:heart];
        

        tweets = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 80)];
        tweets.lineBreakMode = NSLineBreakByCharWrapping;
        tweets.numberOfLines = 0;
        tweets.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:tweets];
    
        
        likes = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 60, 20)];
        likes.lineBreakMode = NSLineBreakByCharWrapping;
        likes.textColor = [UIColor redColor];
        likes.numberOfLines = 0;
        likes.textAlignment = NSTextAlignmentCenter;
        likes.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:likes];
        
    }
    return self;
}

-(void)setTweetInfo:(NSDictionary *)tweetInfo
{
    _tweetInfo = tweetInfo;
    
    likes.text = [tweetInfo[@"likes"] stringValue];
    tweets.text = tweetInfo [@"tweets"];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
