//
//  AppDelegate.m
//  eride
//
//  Created by Ali Abdul Jabbar on 07/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.PushbotsClient = [[Pushbots alloc] initWithAppId:@"56e41aad177959e67b8b4567" prompt:YES];
    
    
    
    //Handle notification when the user click it, while app is closed.
    //This method will show an alert to the user.
    [self.PushbotsClient trackPushNotificationOpenedWithLaunchOptions:launchOptions];
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        //Capture notification data e.g. badge, alert and sound
        NSDictionary *aps = [userInfo objectForKey:@"aps"];
        
        if (aps) {
            NSString *alertMsg = [aps objectForKey:@"alert"];
            NSLog(@"Notification message: %@", alertMsg);
        }
        
        //Capture custom fields
        NSString* articleId = [userInfo objectForKey:@"articleId"];
    }
   
    //added for skyling
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSessionRouteChange:) name:AVAudioSessionRouteChangeNotification object:nil]; // to set the speakers as default audio route
    
    signal(SIGPIPE, SIG_IGN); // Resolve SIGPIPE, as sugested by Apple doc.
    
    //ended skylink
    
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // This method will be called everytime you open the app
    // Register the deviceToken on Pushbots
    [self.PushbotsClient registerOnPushbots:deviceToken];
    
    
    
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Notification Registration Error %@", [error description]);
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //Handle notification when the user click it while app is running in background or foreground.
    //Track notification only if the application opened from Background by clicking on the notification.
    if (application.applicationState == UIApplicationStateInactive) {
        [self.PushbotsClient trackPushNotificationOpenedWithPayload:userInfo];
    }
    
    //The application was already active when the user got the notification, just show an alert.
    //That should *not* be considered open from Push.
    if (application.applicationState == UIApplicationStateActive) {
        NSDictionary *notificationDict = [userInfo objectForKey:@"aps"];
        NSString *alertString = [notificationDict objectForKey:@"alert"];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Push Notification Received" message:alertString delegate:self
                              cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

-(void) receivedPush:(NSDictionary *)userInfo {
    //Try to get Notification from [didReceiveRemoteNotification] dictionary
    NSDictionary *pushNotification = [userInfo objectForKey:@"aps"];
    
    if(!pushNotification) {
        //Try as launchOptions dictionary
        userInfo = [userInfo objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        pushNotification = [userInfo objectForKey:@"aps"];
    }
    
    if (!pushNotification)
        return;
    
    //Get notification payload data [Custom fields]
    
    //For example: get viewControllerIdentifer for deep linking
    NSString* notificationViewControllerIdentifer = [userInfo objectForKey:@"notification_identifier"];
    
    //Set the default viewController Identifer
    if(!notificationViewControllerIdentifer)
        notificationViewControllerIdentifer = @"home";
    
    UIAlertView *message =
    [[UIAlertView alloc] initWithTitle:@"Notification"
                               message:[pushNotification valueForKey:@"alert"]
                              delegate:self
                     cancelButtonTitle:nil
                     otherButtonTitles: @"OK",
     nil];
    
    [message show];
    return;
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo  fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    // .. Process notification data
    handler(UIBackgroundFetchResultNewData);
}


//added code
- (void)didSessionRouteChange:(NSNotification *)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonCategoryChange: {
            // Set speaker as default route
            NSError* error;
            [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
        }
            break;
        default:
            break;
    }
}
@end
