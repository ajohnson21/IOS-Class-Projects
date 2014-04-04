//
//  TDLTableViewCell.m
//  todo
//
//  Created by Austen Johnson on 4/3/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell
{
     UIImageView * profileImage;
     UILabel * profileName;
     UILabel * profileURL;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        profileImage.layer.cornerRadius = 15;
        profileImage.layer.masksToBounds = YES;
        [self.contentView addSubview:profileImage];
        
        profileName = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 30)];
        profileName.textColor = [UIColor blackColor];
        profileName.font = [UIFont systemFontOfSize:30];
        [self.contentView addSubview:profileName];
        
        profileURL = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 30)];
        profileURL.textColor = [UIColor darkGrayColor];
        profileURL.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:profileURL];
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}


- (void)setProfileInfo:(NSDictionary *) profileInfo

{
    profileImage.image = profileInfo[@"image"];
    profileURL.text = profileInfo[@"github"];
    profileName.text = profileInfo[@"name"];
    
    _profileInfo = profileInfo;
    
  
}

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
