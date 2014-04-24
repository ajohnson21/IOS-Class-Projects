//
//  TLATableViewController.m
//  TweetLike
//
//  Created by Austen Johnson on 4/23/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TLATableViewController.h"
#import "TLATableViewCell.h"
#import "TLANavController.h"

@interface TLATableViewController () <UITextFieldDelegate>

@end

@implementation TLATableViewController
{
//    NSMutableArray * tweetList;
    NSDictionary * newTweet;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
        self.tweetList = [@[
//                       @{
//                           @"tweets" : @"No more shall I go on, without first looking ahead.",
//                           @"likes" : @55
//                           },
//                       @{
//                           @"tweets" : @"I like to eat chocolates while reading romance novels.",
//                           @"likes" : @32
//                           },
                       
                       ] mutableCopy];
        
    }
    return self;
}

-(void)moveTweetsToDictionary:(NSString *)tweet
{
    
    newTweet = @{
                 @"tweets" : tweet,
                 @"likes" : @0
    
                 };
    
    if(![tweet isEqualToString:@""])
    {
        [self.tweetList addObject:newTweet];
    }
    
    [self.tableView reloadData];

}

-(BOOL)isTweetItemsEmpty
{
    return ([self.tweetList count] == 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView.rowHeight = 80;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.tableView.separatorColor = [UIColor blackColor];
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tweetList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // Configure the cell...
    
    if (cell == nil)
    {
        cell = [[TLATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.tweetInfo = self.tweetList [indexPath.row];
    
    return cell;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
