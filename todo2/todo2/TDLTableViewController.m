//
//  TDLTableViewController.m
//  todo2
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLTableViewController.h"
#import "TDLTableViewCell.h"

@interface TDLTableViewController ()

@end

@implementation TDLTableViewController
{
    NSMutableArray *todoItems;
    UITextField * nameField;
    NSArray * priorityColors;
    UIButton * headerbutton1;
    UIButton * headerbutton2;
    UIButton * headerbutton3;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        priorityColors = @[TAN_COLOR, YELLOW_COLOR, ORANGE_COLOR, RED_COLOR];
        
        todoItems = [@[
                       @{
                           @"name":@"Workshop App",
                           @"priority": @3
                           
                           },
                       @{@"name":@"Go to blogging thing", @"priority": @2},
                       @{@"name":@"Learn objective-c", @"priority": @1},
                       @{@"name":@"Go to bed", @"priority": @3},
                       
                       
                       ] mutableCopy];
        
        self.tableView.backgroundColor = [UIColor clearColor];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.contentInset = UIEdgeInsetsMake(20,0,0,0);
        self.tableView.rowHeight = 50;
        self.tableView.separatorInset = UIEdgeInsetsMake(0,20,0,20);
        // self.tableView.editing = YES;
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        header.backgroundColor  = [UIColor whiteColor];
        self.tableView.tableHeaderView  = header;
        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 170, 40)];
        nameField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        nameField.placeholder = @" Enter to do item";
        nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        nameField.leftViewMode = UITextFieldViewModeAlways;
        
        [header addSubview:nameField];
        
        nameField.delegate = self;
        
        NSLog(@"todoItems : %@ .... ", todoItems);
        
        headerbutton1 = [[UIButton alloc] initWithFrame:CGRectMake(200, 13, 30, 30)];
        headerbutton1.tag = 1;
        headerbutton1.backgroundColor = [UIColor greenColor];
        [headerbutton1 setTitle:@"" forState:UIControlStateNormal];
        [headerbutton1 addTarget:self action:@selector(addNewItem:) forControlEvents: UIControlEventTouchUpInside];
        headerbutton1.backgroundColor = [UIColor greenColor];
        headerbutton1.layer.cornerRadius = 15;
        
        [self.tableView.tableHeaderView addSubview:headerbutton1];
        
        headerbutton2 = [[UIButton alloc] initWithFrame:CGRectMake(240, 13, 30, 30)];
        headerbutton2.tag = 2;
        headerbutton2.backgroundColor = [UIColor yellowColor];
        [headerbutton2 setTitle:@"" forState:UIControlStateNormal];
        [headerbutton2 addTarget:self action:@selector(addNewItem:) forControlEvents: UIControlEventTouchUpInside];        headerbutton2.layer.cornerRadius = 15;
        
        [self.tableView.tableHeaderView addSubview:headerbutton2];
        
        headerbutton3 = [[UIButton alloc] initWithFrame:CGRectMake(280, 13, 30, 30)];
        headerbutton3.tag = 3;
        headerbutton3.backgroundColor = [UIColor redColor];
        [headerbutton3 setTitle:@"" forState:UIControlStateNormal];
        [headerbutton3 addTarget:self action:@selector(addNewItem:) forControlEvents: UIControlEventTouchUpInside];        headerbutton3.layer.cornerRadius = 15;
        
        [self.tableView.tableHeaderView addSubview:headerbutton3];
        
    }
    return self;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.placeholder = @"";
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.placeholder = @" Enter to do item";
    
}

- (void)addNewItem:(id)sender
{
//    if([sender isEqual:headerbutton1]) NSLog(@"button 1");
//    if([sender isEqual:headerbutton1]) NSLog(@"button 2");
//    if([sender isEqual:headerbutton1]) NSLog(@"button 3");
    
    UIButton * button = (UIButton *)sender;
    
    NSString * name = nameField.text;
  //  NSInteger * priority = button.tag;
    
    if(![name isEqualToString:@""])
    {
        [todoItems insertObject:@{@"name":name, @"priority": @(button.tag)} atIndex:0];
    }
    
 //   NSLog(@"%@", sender);
    
//    nameField.text = @"";
//    [todoItems addObject:newTodo];
    [nameField resignFirstResponder];
//    
    [self.tableView reloadData];
}

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    [self addNewItem:nil];
    
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //      self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [todoItems count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.backgroundColor = cell.contentView.backgroundColor;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" ];
    
    NSDictionary * listItem = todoItems[indexPath.row];
    
//    cell.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    cell.textLabel.text = listItem[@"name"];
    cell.bgView.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    
    

return cell;
}

- (NSDictionary *)getListItem:(NSInteger)row
{
    
    NSArray * reverseArray = [[todoItems reverseObjectEnumerator] allObjects];
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
