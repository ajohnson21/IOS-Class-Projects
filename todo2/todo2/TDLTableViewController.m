//
//  TDLTableViewController.m
//  todo2
//
//  Created by Austen Johnson on 4/8/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLTableViewController.h"
#import "TDLTableViewCell.h"
#import "MOVE.h"

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
        priorityColors = @[TAN_COLOR, YELLOW_COLOR, ORANGE_COLOR, RED_COLOR,];
        
        todoItems = [@[
                       @{
                           @"name":@"Workshop App",
                           @"priority": @3,
                           @"filler": @3
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
        headerbutton1.backgroundColor = YELLOW_COLOR;
        [headerbutton1 setTitle:@"" forState:UIControlStateNormal];
        [headerbutton1 addTarget:self action:@selector(addNewItem:) forControlEvents: UIControlEventTouchUpInside];
        headerbutton1.backgroundColor = [UIColor greenColor];
        headerbutton1.layer.cornerRadius = 15;
        
        [self.tableView.tableHeaderView addSubview:headerbutton1];
        
        headerbutton2 = [[UIButton alloc] initWithFrame:CGRectMake(240, 13, 30, 30)];
        headerbutton2.tag = 2;
        headerbutton2.backgroundColor = ORANGE_COLOR;
        [headerbutton2 setTitle:@"" forState:UIControlStateNormal];
        [headerbutton2 addTarget:self action:@selector(addNewItem:) forControlEvents: UIControlEventTouchUpInside];        headerbutton2.layer.cornerRadius = 15;
        
        [self.tableView.tableHeaderView addSubview:headerbutton2];
        
        headerbutton3 = [[UIButton alloc] initWithFrame:CGRectMake(280, 13, 30, 30)];
        headerbutton3.tag = 3;
        headerbutton3.backgroundColor = RED_COLOR;
        [headerbutton3 setTitle:@"" forState:UIControlStateNormal];
        [headerbutton3 addTarget:self action:@selector(addNewItem:) forControlEvents: UIControlEventTouchUpInside];        headerbutton3.layer.cornerRadius = 15;
        
        [self.tableView.tableHeaderView addSubview:headerbutton3];
        
    }
    return self;
    
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
        [todoItems insertObject:@{@"name" : name, @"priority" : @(button.tag), @"filler" : @(button.tag)} atIndex:0];//        [todoItems insertObject:@{@"name":name, @"priority": @(button.tag)} atIndex:0];
    }
    
    
    [nameField resignFirstResponder];
    
    [self.tableView reloadData];
}


- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    [self addNewItem:nil];
    nameField.text = @"";
    textField.placeholder = @" Enter to do item";
    
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) cell = [[TDLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * listItem = todoItems[indexPath.row];
    
    cell.nameLabel.text = listItem[@"name"];
    cell.bgView.backgroundColor = priorityColors[[listItem[@"priority"] intValue]];
    
    if([todoItems [indexPath.row] [@"priority"] intValue] == 0)
    {
        cell.strikeThrough.alpha = 1;
        cell.circleButton.alpha = 0;
    }
    else
    {
        cell.strikeThrough.alpha = 0;
        cell.circleButton.alpha = 1;
        
    }
    
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [cell addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCell:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [cell addGestureRecognizer:swipeRight];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCell * cell = (TDLTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.bgView.backgroundColor = priorityColors[0];
    
    //    cell.strikeThrough.alpha = 1;
    //    cell.circleButton.alpha = 0;
    
    if (cell.swiped)
    {
        return;
    }
    
    
    int newPriority = 1;
    
    if([todoItems [indexPath.row] [@"priority"] intValue] == 0)
    {
        
        cell.strikeThrough.alpha = 0;
        cell.circleButton.alpha = 1;
    }
    else
    {
        
        cell.strikeThrough.alpha = 1;
        cell.circleButton.alpha = 0;
        newPriority = 0;
    }
    
    
    cell.bgView.backgroundColor = priorityColors[newPriority];
    NSDictionary * updateListItems = @{
                                       @"name": todoItems[indexPath.row ][@"name"],
                                       @"priority" : @(newPriority)
                                       };
    // remove dictionary for cell
    [todoItems removeObjectAtIndex:indexPath.row];
    
    // add new dictionary for cell
    [todoItems insertObject:updateListItems atIndex:indexPath.row];
}

-(void)swipeCell:(UISwipeGestureRecognizer *) gesture
{
    //  NSLog(@"%@", gesture);
    TDLTableViewCell * cell = (TDLTableViewCell *)gesture.view;
    
    // NSInteger index = [self.tableView indexPathForCell:cell].row;
    
    switch (gesture.direction) {
        case 1:
            NSLog(@"swiping right");
            
            [MOVE animateView:cell.bgView properties:@{@"x": @10,
                                                       @"duration": @0.5
                                                       }];
            [cell hideCircleButtons];
            (cell.swiped = NO);
            break;
        case 2:
            NSLog(@"swiping left");
            
            [MOVE animateView:cell.bgView properties:@{@"x": @-150,
                                                       @"duration": @0.5
                                                       }];
            [cell showCircleButtons];
            (cell.swiped = YES);
            break;
            
            
        default:
            break;
            
    }
    
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


-(BOOL)prefersStatusBarHidden { return YES; }
@end
