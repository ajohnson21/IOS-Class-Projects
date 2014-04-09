//
//  TDLTableViewCell.m
//  todo2
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell

{
    UILabel * todoText;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        todoText = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 30)];
//        todoText.textColor = [UIColor blackColor];
//        todoText.backgroundColor = [UIColor lightGrayColor];
//        todoText.font = [UIFont systemFontOfSize:30];
//        todoText.text = @"Placeholder";
//        [self.contentView addSubview:todoText];
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 40)];
        self.bgView.layer.cornerRadius = 6;
        [self.contentView addSubview:self.bgView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:26];
        
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
}

- (void)setProfileInfo:(NSDictionary *) todoInfo

{
    
    todoText.text = todoInfo[@"name"];
    _todoInfo = todoInfo;
    
}

- (void)setTodoInfo:(NSDictionary *)todoInfo
{
    
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
