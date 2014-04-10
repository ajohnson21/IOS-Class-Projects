//
//  TDLTableViewCell.h
//  todo2
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDLTableViewCell : UITableViewCell

@property (nonatomic) NSDictionary * todoInfo;
@property (nonatomic) UILabel * nameLabel;
@property (nonatomic) UIButton * circleButton;
@property (nonatomic) UIView * bgView;
@property (nonatomic) UIView * strikeThrough;

@property (nonatomic) BOOL swiped;

- (void)showCircleButtons;
- (void)hideCircleButtons;

- (void)showDeleteButton;
- (void)hideDeleteButton;

@end
