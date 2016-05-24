//
//  MainViewController.m
//  eride
//
//  Created by Ali Abdul Jabbar on 20/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"


@interface MainViewController () 

@property (weak, nonatomic) IBOutlet MBSliderView *slider;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation MainViewController

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
    self.slider.delegate = self;
    [self.slider setText:@"Slide to get Eride"];
    
    [self.slider setLabelColor:[UIColor grayColor]];
    [self setDateAndTimeLabel:[NSDate date]];
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

- (IBAction)changeTime:(id)sender {
    //New view controller
    UIViewController *pickerViewController = [[UIViewController alloc] init];
    
    //Init the datePicker view and set self as delegate
    MGConferenceDatePicker *datePicker = [[MGConferenceDatePicker alloc] initWithFrame:self.view.bounds];
    [datePicker setDelegate:self];
    
    //OPTIONAL: Choose the background color
    [datePicker setBackgroundColor:[UIColor whiteColor]];
    
    //Set the data picker as view of the new view controller
    [pickerViewController setView:datePicker];
    
    //Present the view controller
    [self presentViewController:pickerViewController animated:YES completion:nil];
}

//Delegate
-(void)conferenceDatePicker:(MGConferenceDatePicker *)datePicker saveDate:(NSDate *)date {
    [self setDateAndTimeLabel:date];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)setDateAndTimeLabel:(NSDate *)date {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocalizedDateFormatFromTemplate:@"EEEE, MMMM dd"];
    self.dateLabel.text = [dateformatter stringFromDate:date];
    [dateformatter setDateFormat:@"hh:mm a"];
    self.timeLabel.text = [dateformatter stringFromDate:date];
    [self.dateLabel setFont:[UIFont fontWithName:@"aleo-regular-webfont.ttf" size:17.0f]];
}

// MBSliderViewDelegate
- (void) sliderDidSlide:(MBSliderView *)slideView {
    // Customization example
    // Just do whatever you want
    [self performSegueWithIdentifier:@"booking" sender:self];
}
@end
