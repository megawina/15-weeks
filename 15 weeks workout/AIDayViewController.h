//
//  AIDayViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//
//**************************************************************************************
//
//      In this View controller user can see his training program for current training.
//      If he have train today - he could see alert view, that he can`t train more today.
//      Other way - if he don`t train more then 28 hours, then all data about his progress
//      could be claered, or, as a variant, he could buy ability to continue trainings.
//
//**************************************************************************************

#import <UIKit/UIKit.h>

@interface AIDayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (weak, nonatomic) IBOutlet UILabel *pushLabel;
@property (weak, nonatomic) IBOutlet UILabel *pullLabel;
@property (weak, nonatomic) IBOutlet UILabel *dipsLabel;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
