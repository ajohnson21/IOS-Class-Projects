//
//  TLANavController.m
//  TweetLike
//
//  Created by Austen Johnson on 4/23/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TLANavController.h"
#import "TLATableViewCell.h"
#import "TLATableViewController.h"


@interface TLANavController () <UITextViewDelegate>

@end

@implementation TLANavController
{
    UIButton * addNewButton;
    UIView * blueBox;
    UIButton * blueSubmit;
    UITextView *blueCaption;
    UIButton * blueCancel;
    UIImageView * blueLogo;
    TLATableViewController * tvc;
    UIView * newForm;
}


-(void)addNewTweet:(id)sender
{
    [newForm removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        blueBox.frame = self.navigationBar.frame;
        addNewButton.titleLabel.textColor = [UIColor colorWithRed:0.216f green:0.533f blue:0.984f alpha:1.0];

        addNewButton.alpha = 1.0;
    }];
    NSString * tweet = blueCaption.text;
    blueCaption.text = @"";
//    TLATableViewController * tableVC = (TLATableViewController *) self.viewControllers[0];
    blueCaption.text = @"";
    [tvc moveTweetsToDictionary:tweet];
}

-(void)tapScreen
{
    [blueCaption resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -KB_HEIGHT /2, 320, self.view.frame.size.height);
    }];
    
    return YES;
}

-(void)addNewItem:(UIButton *)sender
{
    
    
    
    [UIView animateWithDuration:0.4 animations:^{
        blueBox.frame = self.view.frame;
        addNewButton.alpha = 0.0;
    }completion:^(BOOL finished) {
        
        [blueBox addSubview:newForm];
        
        [newForm addSubview:blueLogo];
        
        [newForm addSubview:blueCaption];
        
        [newForm addSubview:blueSubmit];
        
        [newForm addSubview:blueCancel];
        
        }];
}

-(void)cancelButton
{
    [newForm removeFromSuperview];
    
    [UIView animateWithDuration:0.4 animations:^{
        blueBox.frame = self.navigationBar.frame;
        addNewButton.alpha = 1.0;

    } completion:^(BOOL finished){

    addNewButton.titleLabel.textColor = [UIColor colorWithRed:0.216f green:0.533f blue:0.984f alpha:1.0];
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.216f green:0.533f blue:0.984f alpha:1.0];
        newForm.frame = self.view.frame;
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    blueBox = [[UIView alloc] initWithFrame:self.navigationBar.frame];
    blueBox.backgroundColor = [UIColor colorWithRed:0.216f green:0.533f blue:0.984f alpha:1.0];
    [self.view addSubview:blueBox];
    
    newForm = [[UIView alloc] initWithFrame:self.view.frame];
    newForm.backgroundColor = [UIColor clearColor];
    [blueBox addSubview:newForm];
    
    blueLogo = [[UIImageView alloc] initWithFrame:CGRectMake(70, 120, 175, 45)];
    blueLogo.image = [UIImage imageNamed:@"logo"];
    
    blueCaption = [[UITextView alloc] initWithFrame:CGRectMake(30, 180, 260, 100)];
    blueCaption.backgroundColor = [UIColor whiteColor];
    blueCaption.delegate = self;
    blueCaption.text = @"";
    
    blueSubmit = [[UIButton alloc] initWithFrame:CGRectMake(40, 300, 100, 30)];
    blueSubmit.backgroundColor = [UIColor greenColor];
    [blueSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    [blueSubmit addTarget:self action:@selector(addNewTweet:) forControlEvents:UIControlEventTouchUpInside];
    blueSubmit.layer.cornerRadius = 15;
    
    blueCancel = [[UIButton alloc] initWithFrame:CGRectMake(180, 300, 100, 30)];
    blueCancel.backgroundColor = [UIColor redColor];
    [blueCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [blueCancel addTarget:self action:@selector(cancelButton) forControlEvents: UIControlEventTouchUpInside];
    blueCancel.layer.cornerRadius = 15;
    
    addNewButton = [[UIButton alloc] initWithFrame:CGRectMake(80, (self.navigationBar.frame.size.height - 30) /2, 160, 30)];
    addNewButton.backgroundColor = [UIColor whiteColor];
    [addNewButton setTitle:@"Add New" forState:UIControlStateNormal];
    addNewButton.titleLabel.textColor = [UIColor colorWithRed:0.216f green:0.533f blue:0.984f alpha:1.0];
    [addNewButton addTarget:self action:@selector(addNewItem:) forControlEvents: UIControlEventTouchUpInside];
    addNewButton.layer.cornerRadius = 15;
    [blueBox addSubview:addNewButton];
    
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)addTableViewController:(TLATableViewController *)viewController
{
    tvc = viewController;
    
    
    [self pushViewController:viewController animated:NO];
    
    if ([tvc isTweetItemsEmpty])
    {
        [self addNewTweet:addNewButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
