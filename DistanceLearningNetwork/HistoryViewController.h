//
//  HistoryViewController.h
//  eride
//
//  Created by Ali Abdul Jabbar on 26/01/2016.
//  Copyright © 2016 Ali Abdul Jabbar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JTCalendar/JTCalendar.h>

@interface HistoryViewController : UIViewController<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;


@property (strong, nonatomic) NSString *titleString;

@end