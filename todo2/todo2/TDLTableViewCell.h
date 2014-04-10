//
//  TDLTableViewCell.h
//  todo2
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TDLTableViewCellDelegate;

@interface TDLTableViewCell : UITableViewCell

@property (nonatomic, assign) id<TDLTableViewCellDelegate> delegate;
@property (nonatomic) NSDictionary * todoInfo;
@property (nonatomic) UILabel * nameLabel;
@property (nonatomic) UIButton * circleButton;
@property (nonatomic) UIView * bgView;
@property (nonatomic) UIView * strikeThrough;

@property (nonatomic) BOOL swiped;

- (void)resetLayout;

- (void)showCircleButtons;
- (void)hideCircleButtons;

- (void)showDeleteButton;
- (void)hideDeleteButton;

@end

@protocol TDLTableViewCellDelegate <NSObject>

- (void)deleteItem:(TDLTableViewCell *)cell;
- (void)setItemPriority: (int) priority withItem: (TDLTableViewCell *)cell;

@optional

- (void)optionalMethod;


@end
