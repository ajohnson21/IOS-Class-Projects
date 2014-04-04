//
//  TDLRootTableViewController.m
//  todo
//
//  Created by Austen Johnson on 4/2/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLRootTableViewController.h"
#import "TDLTableViewCell.h"

@implementation TDLRootTableViewController

{
    NSMutableArray *listItems;
    UITextField * nameField;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        
        
        listItems = [@[
                @{@"name" : @"Savitha Reddy", @"image" : [UIImage imageNamed: @"Savitha Reddy"], @"github": @"https://github.com/saviios"},
                @{@"name" : @"Jeff King", @"image" : [UIImage imageNamed: @"Jeff King"], @"github": @"https://github.com/rampis"},
                @{@"name" : @"Ali Houshmand", @"image" : [UIImage imageNamed: @"Ali Houshmand"], @"github": @"https://github.com/HoushmandA06"},
                @{@"name" : @"Jeffrey Moulds", @"image" : [UIImage imageNamed: @"Jeffrey Moulds"], @"github": @"https://github.com/jdmgithub/iOS-Class-Project"},
                @{@"name" : @"Derek Weber", @"image" : [UIImage imageNamed: @"Derek Weber"], @"github": @"https://github.com/dweber03"},
                @{@"name" : @"Ashby Thornwell", @"image" : [UIImage imageNamed: @"Ashby Thornwell"], @"github": @"https://github.com/athornwell"},
                @{@"name" : @"Austen Johnson", @"image" : [UIImage imageNamed: @"Austen Johnson"], @"github": @"https://github.com/ajohnson21"},
                @{@"name" : @"Jon Fox", @"image" : [UIImage imageNamed: @"Jon Fox"], @"github": @"https://github.com/FoxJon"},
                @{@"name" : @"Teddy Conyers", @"image" : [UIImage imageNamed: @"Teddy Conyers"], @"github": @"https://github.com/talented76"},
                @{@"name" : @"TJ Mercer", @"image" : [UIImage imageNamed: @"TJ Mercer"], @"github": @"https://github.com/gwanunig14"},
                @{@"name" : @"John Yam", @"image" : [UIImage imageNamed: @"John Yam"], @"github": @"https://github.com/yamski"},
                @{@"name" : @"Heidi Proske", @"image" : [UIImage imageNamed: @"Heidi Proske"], @"github": @"https://github.com/justagirlcoding"},
                @{@"name" : @"Jisha Obukwelu", @"image" : [UIImage imageNamed: @"Jisha Obukwelu"], @"github": @"https://github.com/Jiobu"}
                ] mutableCopy];
    
        
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        self.tableView.rowHeight = 100;
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        self.tableView.separatorColor = [UIColor blackColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
        
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
                           
        header.backgroundColor  = [UIColor whiteColor];
        
        
        self.tableView.tableHeaderView  = header;
        
        
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        
        footer.backgroundColor = [UIColor whiteColor];
        UILabel * footerholder = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
        
        // footerholder.text = @"                      The End";
        footerholder.textColor = [UIColor blackColor];
        [footer addSubview:footerholder];
        self.tableView.tableFooterView  = footer;
        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 200, 30)];
        [header addSubview:nameField];
        nameField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        nameField.placeholder = @" Enter contact here...";
        nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        nameField.leftViewMode = UITextFieldViewModeAlways;
        nameField.delegate = self;
        
        
        UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 25, 60, 20)];
        [submitButton setTitle:@"New User" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(newUser) forControlEvents: UIControlEventTouchUpInside];       submitButton.backgroundColor = [UIColor blackColor];
        submitButton.layer.cornerRadius = 6;
        submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [header addSubview:submitButton];
        
        
        UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 30)];
        titleHeader.text = @"GitHub Users";
        titleHeader.textColor = [UIColor blackColor];
        titleHeader.font = [UIFont fontWithName:@"HoeflerText-Italic" size:30];
        [header addSubview:titleHeader];
        
        
    }
    return self;
}


// begin phantom text code
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.placeholder = @"";
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.placeholder = @" Enter contact here...";
};

// end phantom text code

// -(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string


- (void)newUser

{
    NSString * username = nameField.text;
    nameField.text = @"";


[listItems addObject:@{
                           @"name" : username,
 //                          @"image" : [UIImage imageNamed: @"New User"],
                           @"github" : [NSString stringWithFormat: @"https://github.com/%@", username ]}
                        ];
    [nameField resignFirstResponder];
[self.tableView reloadData];

}

-(BOOL)textField:(UITextField *)textField
{
    [self newUser];
    return YES;
}
    - (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [listItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" ];
    
    cell.profileInfo = [self getListItem:indexPath.row];
    
//    cell.textLabel.text = listItems [index][@"name"];
//    cell.imageView.image = listItems [index][@"image"];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    NSLog(@"%@", listItem);

}

- (NSDictionary *)getListItem:(NSInteger)row
{
    NSArray * reverseArray = [[listItems reverseObjectEnumerator] allObjects];
    return reverseArray[row];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
