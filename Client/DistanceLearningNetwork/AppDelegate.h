//
//  AppDelegate.h
//  eride
//
//  Created by Ali Abdul Jabbar on 07/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pushbots/Pushbots.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Pushbots *PushbotsClient;

@end

