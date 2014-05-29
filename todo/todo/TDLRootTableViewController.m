//
//  TDLRootTableViewController.m
//  todo
//
//  Created by Austen Johnson on 4/2/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLRootTableViewController.h"
#import "TDLTableViewCell.h"
#import "TDLGitHubRequest.h"
#import "TDLSingleton.h"

@implementation TDLRootTableViewController

{
    NSInteger * counter1;
    NSInteger * counter2;
    UITextView * nameField;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        
        
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        
        
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
        
        footerholder.textColor = [UIColor blackColor];
        [footer addSubview:footerholder];
        self.tableView.tableFooterView  = footer;
        
          nameField = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 170, 30)];
        self.navigationItem.titleView = nameField;
        
        UIBarButtonItem * submitButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector (newUser)];
        
        submitButton.tintColor = [UIColor blackColor];
        self.navigationItem.leftBarButtonItem = submitButton;
        [self setNeedsStatusBarAppearanceUpdate];
        
        
        UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 30)];
        titleHeader.text = @"GitHub Users";
        titleHeader.textColor = [UIColor blackColor];
        titleHeader.font = [UIFont fontWithName:@"HoeflerText-Italic" size:30];
        [header addSubview:titleHeader];
        
        
    }
    return self;
}



- (void)addNewUser
{
    NSString * username = nameField.text;
    
    nameField.text = @"";
    
    NSDictionary *newUserInfo = [TDLGitHubRequest getUserWithUsername:username];
    NSLog(@"%@",newUserInfo);
    if ([[newUserInfo allKeys] count] == 3)
    {
        [[TDLSingleton sharedCollection] addListItem:newUserInfo];
    }
    else
    {
        NSLog(@"Not enough data for %@", username);
    }
    
    [nameField resignFirstResponder];
    [self.tableView reloadData];
    }

// begin phantom text code
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.placeholder = @"";
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.placeholder = @" Enter contact here...";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[TDLSingleton sharedCollection] removeListItemAtIndex:indexPath.row];
    
    [self.tableView reloadData];
    
}

- (void)newUser

{
    NSString * username = nameField.text;
    
    nameField.text = @"";
    

    
    [nameField resignFirstResponder];
    [self.tableView reloadData];
    
    NSDictionary * userInfo = [TDLGitHubRequest getUserWithUsername:username];
    
    if([[userInfo allKeys] count] == 3)
    {
//        [listItems addObject:userInfo];
//        [[TDLSingleton sharedCollection] allListItems]
    }
    else
    {
        NSLog(@"not enough data");
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Bad Information" message:@"Unable to add user" delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil];
        [alertview show];
    }
    
    
}

-(BOOL)textField:(UITextField *)textField
{
    [self newUser];
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem * newUser = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(newUser)];
    newUser.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = newUser;
    [self setNeedsStatusBarAppearanceUpdate];

    
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
//    return [listItems count];
    return [[[TDLSingleton sharedCollection] allListItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" ];
    
    cell.index = indexPath.row;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * listItem = [[TDLSingleton sharedCollection] allListItems][indexPath.row];
    
    // Create a new temporary view controller, we don't need this to persist forever, only when you select that row.
    UIViewController *webController = [[UIViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc] init];
    webController.view = webView;
    [self.navigationController pushViewController:webController animated:YES];
    
    // Now load the URL and display
    NSURL *url = [NSURL URLWithString:listItem[@"github"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    NSLog(@"%@", listItem);
    
}

//- (NSDictionary *)getListItem:(NSInteger)row
//{
//    NSArray * reverseArray = [[listItems reverseObjectEnumerator] allObjects];
//    return reverseArray[row];
//}


@end
