//
//  BookingViewController.m
//  eride
//
//  Created by Ali Abdul Jabbar on 28/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import "BookingViewController.h"

@interface BookingViewController ()

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = eride_color;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : navigationBarTextColor};
}
//////'//////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
