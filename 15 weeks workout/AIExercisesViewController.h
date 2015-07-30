//
//  AIExercisesViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIExercisesViewController : UITableViewController

@property (strong, nonatomic) NSArray* allExercisesArray;   // all exercises, which contains 3 arrays: push-ups, pull-us, dips

@property (assign, nonatomic) NSNumber* numberOfPushUps;
@property (assign, nonatomic) NSNumber* numberOfPullUps;
@property (assign, nonatomic) NSNumber* numberOfDips;

@end
