//
//  FeedbackViewController.m
//  eride
//
//  Created by Ali Abdul Jabbar on 25/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SWRevealViewController.h"

#define Controller_title @"FeedBack"

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.navigationController.navigationBar.barTintColor = eride_color;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : navigationBarTextColor};
    
    self.navigationController.title = self.titleString;
}

-(NSString *)titleString {
    if (!_titleString) {
        _titleString = [NSString stringWithFormat:@"%@", Controller_title];
    }
    return _titleString;
}

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
