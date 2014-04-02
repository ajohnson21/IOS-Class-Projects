//
//  TDLRootTableViewController.m
//  todo
//
//  Created by Austen Johnson on 4/2/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "TDLRootTableViewController.h"

@implementation TDLRootTableViewController

{
    NSArray *listItems;
    NSArray *listImages;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        listItems = @[
                      @"Savitha Reddy ",
                      @"Jeff King",
                      @"Ali Houshmand",
                      @"Jeffrey Moulds",
                      @"Derek Weber",
                      @"Ashby Thornwell",
                      @"Austen Johnson",
                      @"Jon Fox",
                      @"Teddy Conyers",
                      @"TJ Mercer",
                      @"John Yam",
                      @"Heidi Proske",
                      @"Jisha Obukwelu"];
        listImages = @[
                       [UIImage imageNamed:@"Savitha Reddy"],
                       [UIImage imageNamed:@"Jeff King"],
                       [UIImage imageNamed:@"Ali Houshmand"],
                       [UIImage imageNamed:@"Jeffrey Moulds"],
                       [UIImage imageNamed:@"Derek Weber"],
                       [UIImage imageNamed:@"Ashby Thornwell"],
                       [UIImage imageNamed:@"Austen Johnson"],
                       [UIImage imageNamed:@"Jon Fox"],
                       [UIImage imageNamed:@"Teddy Conyers"],
                       [UIImage imageNamed:@"TJ Mercer"],
                       [UIImage imageNamed:@"John Yam"],
                       [UIImage imageNamed:@"Heidi Proske"],
                       [UIImage imageNamed:@"Jisha Obukwelu"]
                       ];
        
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        self.tableView.rowHeight = 100;
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
                           
                           header.backgroundColor  = [UIColor darkGrayColor];
        
        UILabel * titleholder = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
        
        titleholder.text = @"             List of Class Names";
        titleholder.textColor = [UIColor whiteColor];
        [header addSubview:titleholder];
        
        
        self.tableView.tableHeaderView  = header;
        
        
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        
        footer.backgroundColor = [UIColor darkGrayColor];
        UILabel * footerholder = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
        
        footerholder.text = @"                      The End";
        footerholder.textColor = [UIColor whiteColor];
        [footer addSubview:footerholder];
        self.tableView.tableFooterView  = footer;
        
        
    
    }
    return self;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
    }
    
    int index = [indexPath row];
    
    cell.textLabel.text = listItems[index];
    cell.imageView.image = listImages[index];
    
    
    
    // Configure the cell...
    
    return cell;
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
