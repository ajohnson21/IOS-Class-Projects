//
//  AJFViewController.h
//  W1D1
//
//  Created by Austen Johnson on 3/31/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJFViewController : UIViewController

- (IBAction)myButton1:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *myLabel1;

@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)myButton2:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *myLabel2;

- (IBAction)myButton3:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *myLabel3;


- (IBAction)backgroundColor:(id)sender;

@end
