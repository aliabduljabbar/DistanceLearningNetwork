//
//  ViewController.m
//  eride
//
//  Created by Ali Abdul Jabbar on 07/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "HyTransitions.h"
#import "HyLoglnButton.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "SideBarTableViewController.h"
#import "JTFadingInfoView.h"
#import "DistanceLearningNetwork-Swift.h"


static const float PLAYER_VOLUME = 0.0;

@interface ViewController ()<UIViewControllerTransitioningDelegate, LTMorphingLabelDelegate> {
    NSArray *array;
    int i;
}

@property (nonatomic) AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet LTMorphingLabel *titleLabel;
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    array = @[@"Distance", @"Learning", @"Network"];
    i=0;
    [self createVideoPlayer];

    
    
    
    [self createMaterialThemeTextfields];
    [self createPresentControllerButton];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.playerView addGestureRecognizer:tap];
    tap.delegate = self;
    self.titleLabel.delegate = self;
    self.titleLabel.text = @"Distane Learning Network";
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeText) userInfo:nil repeats:YES];

    
    // TODO(developer) Configure the sign-in button look/feel
    
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.player pause];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.player play];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
        AVPlayerItem *p = [notification object];
        [p seekToTime:kCMTimeZero];
}

- (void)playerStartPlaying
{
    [self.player play];
}






-(void)changeText {
    if (i>= [array count])
        i=0;
    self.titleLabel.text = [array objectAtIndex:i++];
}



-(void)createPresentControllerButton{
    
    HyLoglnButton *log = [[HyLoglnButton alloc] initWithFrame:CGRectMake(60, CGRectGetHeight(self.view.bounds) - (40 + 80), [UIScreen mainScreen].bounds.size.width - 120, 40)];
    [log setBackgroundColor:eride_color];
    [self.view addSubview:log];
    [log setTitle:@"Login" forState:UIControlStateNormal];
    [log addTarget:self action:@selector(PresentViewController:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)PresentViewController:(HyLoglnButton *)button{
    
    typeof(self) __weak weak = self;
    int time = 0.1;
    if ([_usernameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""])
        time = 0.1;
    else
        time = 2;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weak LoginButton:button];
    });
}

-(void)LoginButton:(HyLoglnButton *)button
{
    typeof(self) __weak weak = self;
    if ([_usernameField.text isEqualToString:@"biscuit"] && [_passwordField.text isEqualToString:@"123"]) {
        [button ExitAnimationCompletion:^{
//            if ([weak.usernameField.text isEqualToString:@""] && [weak.passwordField.text isEqualToString:@""]) {
                [weak didPresentControllerButtonTouch];
//            }
        }];
        
    }else{
        [button ErrorRevertAnimationCompletion:^{
//            if ([weak.usernameField.text isEqualToString:@""] && [weak.passwordField.text isEqualToString:@""]) {
                [weak didPresentControllerButtonTouch];
//            }
        }];
    }
}


- (void)didPresentControllerButtonTouch
{
    
    _passwordField.text = @"";
//    [self presentViewController:_revealController animated:YES completion:nil];
    [self performSegueWithIdentifier:@"revealSegue" sender:self];
}

#pragma mark - Transioning  Delegate Methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return [[HyTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
}

#pragma mark - Material Theme TextFields
- (void)createMaterialThemeTextfields {
    _usernameField.textColor = textFieldTextColor;
//    [_usernameField enableMaterialPlaceHolder:YES];
    _usernameField.errorColor=textFieldErrorColor; // FLAT RED COLOR
    _usernameField.lineColor=eride_color;
    _usernameField.tintColor=eride_color;
    _usernameField.placeholder=@"Username";

    
    _passwordField.textColor = textFieldTextColor;
//    [_passwordField enableMaterialPlaceHolder:YES];
    _passwordField.errorColor=textFieldErrorColor; // FLAT RED COLOR
    _passwordField.lineColor=eride_color;
    _passwordField.tintColor=eride_color;
    _passwordField.placeholder=@"Password";
    
#warning username and password are added for testing purposes
        _usernameField.text = @"biscuit";
        _passwordField.text = @"123";
}


#pragma mark - Video Player

- (void)createVideoPlayer {
    
    //Set up player
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"welcome_video" ofType:@"mp4"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    self.player = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.player];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResize];
    [avPlayerLayer setFrame:self.view.bounds];
    [self.playerView.layer addSublayer:avPlayerLayer];
    
    //Config player
    [self.player seekToTime:kCMTimeZero];
    [self.player setVolume:0.6];
    [self.player setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.player currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)moviePlayDidEnd:(NSNotification*)notification{
    
    AVPlayerItem *item = [notification object];
    [item seekToTime:kCMTimeZero];
    [self.player play];
}


#pragma mark - Miscellaneous
-(void) dismissKeyboard
{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

#pragma mark - observer of player
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"revealSegue"]) {
        segue.destinationViewController.transitioningDelegate = self;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
