//
//  ProfilePictureCell.m
//  eride
//
//  Created by Ali Abdul Jabbar on 28/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIView+XLFormAdditions.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ProfilePictureCell.h"

NSString * const XLFormRowDescriptorTypeProfilePicture = @"ProfilePicture";


@interface ProfilePictureCell() <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) UIImage * defaultImage;
@property (nonatomic) NSURLRequest * imageRequest;

@end

@implementation ProfilePictureCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([ProfilePictureCell class]) forKey:XLFormRowDescriptorTypeProfilePicture];
}

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor
{
    return 171.0f;
}

#pragma mark - XLFormDescriptorCell

- (void)configure
{
    [super configure];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.separatorInset = UIEdgeInsetsZero;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self configureImageView];
}

-(void)update
{
    [super update];
    
    self.profilePicture.image = self.rowDescriptor.value ?: self.defaultImage;
    if (self.imageRequest && !self.rowDescriptor.value){
        __weak __typeof(self) weakSelf = self;
        [self.profilePicture setImageWithURLRequest:self.imageRequest
                              placeholderImage:self.defaultImage
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           if (!weakSelf.rowDescriptor.value && image){
                                               [weakSelf.profilePicture setImage:image];
                                           }
                                       }
                                       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           NSLog(@"Failed to download image");
                                       }];
    }
}



-(void)configureImageView {
    
    _profilePicture.layer.cornerRadius = _profilePicture.frame.size.width / 2;
    _profilePicture.clipsToBounds = YES;
    _profilePicture.layer.borderWidth = 3.0f;
    _profilePicture.layer.borderColor = [UIColor grayColor].CGColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleTap:)];
    [self.profilePicture addGestureRecognizer:tap];
    
    //Enable the image to be clicked
    self.profilePicture.userInteractionEnabled = YES;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 80000
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.rowDescriptor.selectorTitle
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Choose Existing Photo", @"Take a Picture" ), nil];
    actionSheet.tag = self.tag;
    [actionSheet showInView:self.formViewController.view];
#else
    if ([UIAlertController class]) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:self.rowDescriptor.selectorTitle
                                                                                  message:nil
                                                                           preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil]];
        __weak __typeof(self)weakSelf = self;
        [alertController addAction:[UIAlertAction actionWithTitle:@"Choose Existing Photo"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
                                                              imagePickerController.delegate = weakSelf;
                                                              imagePickerController.allowsEditing = YES;
                                                              imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                              imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
                                                              [weakSelf.formViewController presentViewController:imagePickerController animated:YES completion:nil];
                                                          }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Take a Picture"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
                                                              imagePickerController.delegate = weakSelf;
                                                              imagePickerController.allowsEditing = YES;
                                                              imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                              imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
                                                              [weakSelf.formViewController presentViewController:imagePickerController animated:YES completion:nil];
                                                          }]];
        
        [self.formViewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.rowDescriptor.selectorTitle
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Choose Existing Photo", @"Take a Picture", nil];
        actionSheet.tag = self.tag;
        [actionSheet showInView:self.formViewController.view];
    }
#endif
}


#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet * __unused)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    if (buttonIndex == 0){
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
        [self.formViewController presentViewController:imagePickerController animated:YES completion:nil];
    }
    else if (buttonIndex == 1){
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
        [self.formViewController presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#endif

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        // ensure the user has taken a picture
        editedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        if (editedImage) {
            imageToUse = editedImage;
        }
        else {
            imageToUse = originalImage;
        }
        [self setImageValue:imageToUse];
        self.profilePicture.image = originalImage;
        self.profilePicture.image = [UIImage imageNamed:@"default_profile"];
    }
    
    [self.formViewController dismissViewControllerAnimated:YES completion:nil];
}


-(void)setImageValue:(UIImage *)image
{
    [self.profilePicture setImage:image];
    self.rowDescriptor.value = image;
}



-(void)setDefaultImage:(UIImage *)defaultImage
{
    _defaultImage = defaultImage;
}


-(void)setImageRequest:(NSURLRequest *)imageRequest
{
    _imageRequest = imageRequest;
}


@end
