//
//  TDLTableViewController.h
//  todo2
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDLTableViewCell.h"



@interface TDLTableViewController : UITableViewController <UITextFieldDelegate, TDLTableViewCellDelegate>
@property (nonatomic) NSDictionary * taskInfo;



@end
