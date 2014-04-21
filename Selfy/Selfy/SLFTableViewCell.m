//
//  SLFTableViewCell.m
//  Selfy
//
//  Created by Austen Johnson on 4/21/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell
{
    UIImageView * avatar;
    UIImageView * selfImage;
    UILabel * userID;
    UILabel * caption;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 300, 150)];
        avatar.backgroundColor = [UIColor clearColor];
        avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:avatar];
        
        selfImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 250, 300, 60)];
        selfImage.backgroundColor = [UIColor clearColor];
        selfImage.layer.masksToBounds = YES;
        [self.contentView addSubview:selfImage];
        
        userID = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 30)];
        userID.backgroundColor = [UIColor clearColor];
        userID.textColor = [UIColor blackColor];
        userID.font = [UIFont systemFontOfSize:30];
        [self.contentView addSubview:userID];
        
        caption = [[UILabel alloc] initWithFrame:CGRectMake(130, 320, 200, 30)];
        caption.backgroundColor = [UIColor clearColor];
        caption.textColor = [UIColor darkGrayColor];
        caption.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:caption];
    }
    return self;
}

- (void)setSelfyInfo:(NSDictionary *) selfyInfo
{
    avatar.image = [UIImage imageNamed:selfyInfo[@"avatar"]];
    selfImage.image = [UIImage imageNamed:selfyInfo[@"selfImage"]];
    caption.text = selfyInfo[@"caption"];
    userID.text = selfyInfo[@"userID"];
    
    _selfyInfo = selfyInfo;
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
