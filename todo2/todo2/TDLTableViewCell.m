//
//  TDLTableViewCell.m
//  todo2
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLTableViewCell.h"
#import "MOVE.h"

@implementation TDLTableViewCell

{
    UILabel * todoText;
    UIButton * headerbutton1;
    UIButton * headerbutton2;
    UIButton * headerbutton3;
    UIButton * delbutton;
    UILabel*  delLabel;
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
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 30)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
        
        [self.bgView addSubview:self.nameLabel];
        
        self.strikeThrough = [[UIView alloc] initWithFrame:CGRectMake(5, 19, self.frame.size.width -30, 2)];
        self.strikeThrough.backgroundColor = [UIColor whiteColor];
        self.strikeThrough.alpha = 1;
        
        //  self.strikeThrough.hidden = YES;
        [self.bgView addSubview:self.strikeThrough];
        
        self.circleButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 10, 20, 20)];
        self.circleButton.layer.cornerRadius = 10;
        self.circleButton.alpha = 0;
        self.circleButton.backgroundColor = [UIColor whiteColor];
        
        [self.bgView addSubview:self.circleButton];
        
    }
    return self;
}

-(void)resetLayout
{
//    if (self.swiped)
//    {
//        [self.createButtons];
//        self.swiped = YES;
//    } else

{
    self.bgView.frame = CGRectMake(10, 0, self.frame.size.width - 20, 40);
    [headerbutton1 removeFromSuperview];
    [headerbutton2 removeFromSuperview];
    [headerbutton3 removeFromSuperview];
    self.swiped = NO;
}
}
- (void)createButtons
{
    headerbutton1 = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, 30, 30)];
    headerbutton1.tag = 1;
    headerbutton1.alpha = 0;
    headerbutton1.backgroundColor = YELLOW_COLOR;
    [headerbutton1 setTitle:@"" forState:UIControlStateNormal];
    [headerbutton1 addTarget:self action:@selector(pressPriorityButton:) forControlEvents: UIControlEventTouchUpInside];
    headerbutton1.layer.cornerRadius = 15;
    
    [self.contentView addSubview:headerbutton1];
    
    headerbutton2 = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 30, 30)];
    headerbutton2.tag = 2;
    headerbutton2.alpha = 0;
    headerbutton2.backgroundColor = ORANGE_COLOR;
    [headerbutton2 setTitle:@"" forState:UIControlStateNormal];
    [headerbutton2 addTarget:self action:@selector(pressPriorityButton:) forControlEvents: UIControlEventTouchUpInside];
    headerbutton2.layer.cornerRadius = 15;
    
    [self.contentView addSubview:headerbutton2];
    
    headerbutton3 = [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 30, 30)];
    headerbutton3.tag = 3;
    headerbutton3.alpha = 0;
    headerbutton3.backgroundColor = RED_COLOR;
    [headerbutton3 setTitle:@"" forState:UIControlStateNormal];
    [headerbutton3 addTarget:self action:@selector(pressPriorityButton:) forControlEvents: UIControlEventTouchUpInside];
    headerbutton3.layer.cornerRadius = 15;
    
    [self.contentView addSubview:headerbutton3];
}


-(void)showCircleButtons
{
    
    [self createButtons];
    
    [MOVE animateView:headerbutton1 properties:@{@"alpha":@1,@"duration":@0.2,@"delay":@0.3}];
    [MOVE animateView:headerbutton2 properties:@{@"alpha":@1,@"duration":@0.2,@"delay":@0.2}];
    [MOVE animateView:headerbutton3 properties:@{@"alpha":@1,@"duration":@0.2,@"delay":@0.1}];
}
-(void)hideCircleButtons
{
    [MOVE animateView:headerbutton1
           properties:@{@"alpha":@0,@"duration":@0.2,@"delay":@0.0,@"remove":@YES}];
    [MOVE animateView:headerbutton2
           properties:@{@"alpha":@0,@"duration":@0.2,@"delay":@0.1,@"remove":@YES}];
    [MOVE animateView:headerbutton3
           properties:@{@"alpha":@0,@"duration":@0.2,@"delay":@0.2,@"remove":@YES}];
}

- (void)showDeleteButton
{
    delbutton = [[UIButton alloc] initWithFrame:CGRectMake(280, 5, 30, 30)];
    delbutton.alpha = 0;
    delbutton.backgroundColor = [UIColor redColor];
    delbutton.layer.cornerRadius = 15;
    [delbutton addTarget:self action:@selector(pressDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:delbutton];
    
    delLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, delbutton.frame.size.width, delbutton.frame.size.height)];
    delLabel.textColor = [UIColor whiteColor];
    delLabel.textAlignment = NSTextAlignmentCenter;
    delLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
  //  delLabel.text = @"Delete";
    [delbutton addSubview:delLabel];
    
//    [MOVE animateView:self.bgView properties:@{@"x":@-40, @"duration":@0.5}];
    
    [MOVE animateView:delbutton properties:@{@"alpha":@1, @"duration":@0.2, @"delay":@0.3}];
}

- (void) pressPriorityButton:(id) sender
{
    UIButton * button = (UIButton *)sender;
    [self.delegate setItemPriority:(int)button.tag withItem:self];
}

- (void) pressDeleteButton
{
    [self.delegate deleteItem:self];
}


- (void)hideDeleteButton
{
    
    [MOVE animateView:delbutton properties:@{@"alpha":@0, @"duration":@0.2, @"delay":@0., @"remove":@YES}];
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
