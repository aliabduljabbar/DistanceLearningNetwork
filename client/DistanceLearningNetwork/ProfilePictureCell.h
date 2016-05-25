//
//  ProfilePictureCell.h
//  eride
//
//  Created by Ali Abdul Jabbar on 28/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import <XLForm/XLForm.h>

extern NSString * const XLFormRowDescriptorTypeProfilePicture;


@interface ProfilePictureCell : XLFormBaseCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@end
