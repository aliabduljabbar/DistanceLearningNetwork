//
//  ViewController.m
//  Skylink_Examples
//
//  Created by Romain Pellen on 11/12/2015.
//  Copyright © 2015 Temasys. All rights reserved.
//

#import "HomeViewController.h"


// SET YOUR KEY / SECRET HERE TO HAVE IT BY DEFAULT.
#define SKYLINK_APP_KEY @"b9670936-9cfa-48a3-a7fa-5c27c20a2cca"
#define SKYLINK_SECRET  @"a7mz7hl1rcfsk"

#define USERDEFAULTS_KEY_SKYLINK_APP_KEY @"SKYLINK_APP_KEY"
#define USERDEFAULTS_KEY_SKYLINK_SECRET  @"SKYLINK_SECRET"


@interface HomeViewController () // This View controller only passes your API Key and Secret to the sample view controllers. No need to explore this VC's code to understand Skylink SDK.

@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;

@end


@implementation HomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    if (SKYLINK_APP_KEY.length) self.keyTextField.text = SKYLINK_APP_KEY;
    if (SKYLINK_SECRET.length) self.secretTextField.text = SKYLINK_SECRET;
    
    // Priority is given to code defined Key/Secret
    if (!(SKYLINK_APP_KEY.length) && !(SKYLINK_SECRET.length)) {
        NSString *defaultKey = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_KEY_SKYLINK_APP_KEY];
        NSString *defaultSecret = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_KEY_SKYLINK_SECRET];
        if (defaultKey && defaultKey.length) self.keyTextField.text = defaultKey;
        if (defaultSecret && defaultSecret.length) self.secretTextField.text = defaultSecret;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    BOOL shouldPerform = (self.keyTextField.text.length == 36 && self.secretTextField.text.length == 13);
    if (!shouldPerform) {
        [[[UIAlertView alloc] initWithTitle:@"Wrong Key / Secret" message:@"\nYou haven't correctly set your \nSkylink API Key (36 characters) or Secret (13 characters)\n\nIf you don't have access to the API yet, enroll at \ndeveloper.temasys.com.sg/register" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:self.keyTextField.text forKey:USERDEFAULTS_KEY_SKYLINK_APP_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:self.secretTextField.text forKey:USERDEFAULTS_KEY_SKYLINK_SECRET];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return shouldPerform;
}

#pragma clang diagnostic ignored "-Wundeclared-selector"
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController respondsToSelector:@selector(setSkylinkApiKey:)] && [segue.destinationViewController respondsToSelector:@selector(setSkylinkApiSecret:)]) {
        [segue.destinationViewController performSelector:@selector(setSkylinkApiKey:) withObject:self.keyTextField.text];
        [segue.destinationViewController performSelector:@selector(setSkylinkApiSecret:) withObject:self.secretTextField.text];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - IBActions (info boxes)

- (IBAction)homeInfoTap:(UIButton *)sender {
    [[[UIAlertView alloc] initWithTitle:@"Distance Learning Application" message:@"\nEnter your class room id and its password provided by the teacher to access the class and its functionality\nIf you don't have your id/password, request at fyp.tahiriftikhar.com/explorer to the admin for the course ,and if the teacher accepts your request you will be sent an id through push notification\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
- (IBAction)videoCallVCinfoTap:(UIButton *)sender {
    [[[UIAlertView alloc] initWithTitle:@"Teacher" message:@"\nOne to one conversation with a teacher through video chat.\n Only one person can chat with a teacher at one time.\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
- (IBAction)multiVideoCallVCinfoTap:(UIButton *)sender {
    [[[UIAlertView alloc] initWithTitle:@"Live Lecture" message:@"\n Study online live class with other students in a collaborative way\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
- (IBAction)audioCallVCinfoTap:(UIButton *)sender {
    [[[UIAlertView alloc] initWithTitle:@"Submit Assignments" message:@"\nThis is currently for audio, but it will be soon updated so that students can submit their assignments to teachers accordingly.\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
- (IBAction)messagesVCinfoTap:(UIButton *)sender {
    [[[UIAlertView alloc] initWithTitle:@"Ask Questions" message:@"\nAsk and post your questions to the teacher and the teacher will answer your questions for you\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
- (IBAction)fileTransferVCinfoTap:(UIButton *)sender {
    [[[UIAlertView alloc] initWithTitle:@"Lecture Resources" message:@"\nJoin this to recieve files and resources from teacher\n" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


@end


