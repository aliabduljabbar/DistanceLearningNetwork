//
//  SideBarTableViewController.m
//  eride
//
//  Created by Ali Abdul Jabbar on 20/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import "SideBarTableViewController.h"
#import "SWRevealViewController.h"
#import "JTFadingInfoView.h"
#import "ViewController.h"

@interface SideBarTableViewController ()

@end

@implementation SideBarTableViewController {
      NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.barTintColor = eride_color;

    
    self.tableView.backgroundColor = eride_color;
    
    
    menuItems = @[@"title", @"home", @"profile", @"history", @"account", @"refer",@"feedback", @"signout"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[menuItems objectAtIndex:indexPath.row] isEqualToString:@"signout"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
            ViewController *viewController = (ViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            JTFadingInfoView *infoView = [[JTFadingInfoView alloc] initWithFrame:[viewController.view viewWithTag:102].frame label:@"Signed Out!"];
//            infoView.appearingDuration = 0.0;
//            infoView.displayDuration = 0.3;
            infoView.displayDuration = 0.1;
            infoView.fadeInDirection =   JTFadeInDirectionFromPresentPosition;
//            infoView.fadeOutDirection = JTFadeOutDirectionToPresentPosition;
            infoView.backgroundColor = eride_color;
            [viewController.view addSubview:infoView];
        }];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[menuItems objectAtIndex:indexPath.row] isEqualToString:@"title"])
        return 104.0f;
    else 
        return 44.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
