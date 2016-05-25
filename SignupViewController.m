//
//  SignupViewController.m
//  eride
//
//  Created by Ali Abdul Jabbar on 27/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import "SignupViewController.h"
#import "InputsFormViewController.h"
#import "FloatLabeledTextFieldCell.h"
#import "XLFormInlineSegmentedCell.h"


NSString * const kTextFieldAndTextView = @"TextFieldAndTextView";
NSString * const kSelectors = @"Selectors";
NSString * const kOthes = @"Others";
NSString * const kDates = @"Dates";
NSString * const kPredicates = @"BasicPredicates";
NSString * const kBlogExample = @"BlogPredicates";
NSString * const kMultivalued = @"Multivalued";
NSString * const kMultivaluedOnlyReorder = @"MultivaluedOnlyReorder";
NSString * const kMultivaluedOnlyInsert = @"MultivaluedOnlyInsert";
NSString * const kMultivaluedOnlyDelete = @"MultivaluedOnlyDelete";
NSString * const kValidations= @"Validations";

static NSString * const kCustomRowFirstRatingTag = @"CustomRowFirstRatingTag";
static NSString * const kCustomRowSecondRatingTag = @"CustomRowSecondRatingTag";
static NSString * const kCustomRowFloatLabeledTextFieldTag = @"CustomRowFloatLabeledTextFieldTag";
static NSString * const kCustomRowWeekdays = @"CustomRowWeekdays";
static NSString * const kCustomInline = @"kCustomInline";
static NSString * const kCustomRowText = @"kCustomText";

@interface SignupViewController ()

@end

@implementation SignupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Signup";
    [self initializeForm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InitializeForm

-(void)initializeForm {
    
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"Basic Information"];
//    [form addFormSection:section];
//    
//    // TextFieldAndTextView
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextFieldAndTextView rowType:XLFormRowDescriptorTypeButton title:@"Text Fields"];
//    row.action.viewControllerClass = [InputsFormViewController class];
//    [section addFormRow:row];
    
    
    
    section = [XLFormSectionDescriptor formSection];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"profile" rowType:@"ProfilePicture" title:@"Image"];
    row.value = [UIImage imageNamed:@"default_profile"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"First Name"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Last Name"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Email"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypePhone title:@"Contact Number"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypePassword title:@"Password"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypePassword title:@"Confirm Password"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeNumber title:@"CNIC No (Optional)"];
    [section addFormRow:row];
    
    // Date
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"date" rowType:XLFormRowDescriptorTypeDateInline title:@"BirthDate"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    
//    // Inline segmented
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomInline rowType:XLFormRowDescriptorTypeSegmentedInline];
//    row.title = @"Gender";
//    row.selectorOptions = @[@"Male", @"Female"];
//    row.value = @"Male";
//    [section addFormRow:row];
    
    // Segmented Control
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"segment" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Fruits"];
    row.selectorOptions = @[@"Male", @"Female"];
    row.value = @"Male";
    [section addFormRow:row];
    
    [section addFormRow:[XLFormRowDescriptor formRowDescriptorWithTag:@"switch" rowType:XLFormRowDescriptorTypeBooleanCheck title:@"I've read and accepted the Declaration"]];
    
    [form addFormSection:section];
    
    self.form = form;
}

- (IBAction)closeButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
