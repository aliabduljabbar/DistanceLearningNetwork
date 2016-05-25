//
//  ProfileViewController.m
//  eride
//
//  Created by Ali Abdul Jabbar on 26/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"

#import "WZAnimatingTransitionCell.h"
#import "WZTransitionDetailController.h"
#import "UIColor+WZAnimatingTransition.h"
#import "WZAnimatingTransition.h"


#import "CarbonKit.h"


@interface ProfileViewController () < CarbonTabSwipeNavigationDelegate>
{
    NSArray *items;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
}

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigatoinController];
    
//    [self setTableView];
    
    [self setCarbonSwipeNavigation];
    
    
    
    
}

-(void)setNavigatoinController {
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




-(void)setCarbonSwipeNavigation {
    
    items = @[@"YOUR COURSES", @"ONLINE COURSES"];
    
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc]
                                initWithItems:items
                                toolBar:_toolBar
                                delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self
                                             andTargetView:self.view];
    [_toolBar.superview bringSubviewToFront:_toolBar];
    
    [self style];
    
}


- (void)style {
    
    UIColor *color = eride_color;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = eride_color;
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    self.toolBar.backgroundColor = eride_color;
    [carbonTabSwipeNavigation setIndicatorColor:eride_color];
    [carbonTabSwipeNavigation setTabExtraWidth:50];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:self.view.frame.size.width/2 forSegmentAtIndex:0];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:self.view.frame.size.width/2 forSegmentAtIndex:1];
    
    // Custimize segmented control
    [carbonTabSwipeNavigation setNormalColor:[color colorWithAlphaComponent:0.6]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [carbonTabSwipeNavigation setSelectedColor:color
                                          font:[UIFont boldSystemFontOfSize:14]];
}

# pragma mark - CarbonTabSwipeNavigation Delegate
// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"WZTransitionTableController"];
            
        case 1:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"WZTransitionTableController"];
            
        default:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"WZTransitionTableController"];
    }
}

// optional
- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                 willMoveAtIndex:(NSUInteger)index {
    switch(index) {
        case 0:
            self.title = @"YOUR COURSES";
            break;
        case 1:
            self.title = @"ONLINE COURSES";
            break;
        default:
            self.title = items[index];
            break;
    }
}

- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index {
    NSLog(@"Did move at index: %ld", index);
}

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop; // default UIBarPositionTop
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



#pragma  mark - Private

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#define Controller_title @"Courses"
-(NSString *)titleString {
    if (!_titleString) {
        _titleString = [NSString stringWithFormat:@"%@", Controller_title];
    }
    return _titleString;
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
