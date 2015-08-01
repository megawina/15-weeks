//
//  AIStatisticsTableViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/1/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//
//**************************************************************************************
//
//      View controller, that helps to show user information about his progress
//
//**************************************************************************************

#import <UIKit/UIKit.h>

@interface AIStatisticsTableViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
