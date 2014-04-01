//
//  AJFViewController.m
//  W1D1
//
//  Created by Austen Johnson on 3/31/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "AJFViewController.h"

@interface AJFViewController ()

@end

@implementation AJFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
		
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myButton1:(id)sender {
    self.myLabel1.text = @"Austen Johnson";
}
- (IBAction)myButton2:(id)sender {
    self.myLabel2.text = self.textField.text;
}
- (IBAction)myButton3:(id)sender {
    self.myLabel3.textColor = [UIColor blueColor];
}
- (IBAction)backgroundColor:(id)sender {
    self.view.backgroundColor = [UIColor redColor];
}
@end
