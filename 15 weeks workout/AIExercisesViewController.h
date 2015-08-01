//
//  AIExercisesViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//
//**************************************************************************************
//
//      In this view controller user see his current training program. He have to
//      interact with buttons. A lot of animation stuff (buttons fillings, completion
//      exercises and so on) do interactions more interesting.
//
//**************************************************************************************

#import <UIKit/UIKit.h>

@interface AIExercisesViewController : UITableViewController

@property (strong, nonatomic) NSArray* pushUpsArray;
@property (strong, nonatomic) NSArray* pullUpsArray;
@property (strong, nonatomic) NSArray* dipsArray;

@property (assign, nonatomic) NSNumber* numberOfPushUps;
@property (assign, nonatomic) NSNumber* numberOfPullUps;
@property (assign, nonatomic) NSNumber* numberOfDips;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
