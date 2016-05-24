//
//  ViewController.h
//  eride
//
//  Created by Ali Abdul Jabbar on 07/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JJMaterialTextfield.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet JJMaterialTextfield *usernameField;
@property (weak, nonatomic) IBOutlet JJMaterialTextfield *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

