//
//  AIUser.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//
//**************************************************************************************
//
//      User class gives ability to work with user - as object. In current version of app
//      this class is not required, but, if in future smbd decide to add some app functionality
//      - this class would help
//
//**************************************************************************************

#import <Foundation/Foundation.h>

@interface AIUser : NSObject

@property (assign, nonatomic) NSInteger  trainingDay;               // allows to count what day user training
@property (strong, nonatomic) NSDate*    lastTrainingDate;          // allows to know if user train everyday

@property (assign, nonatomic) NSMutableArray*   exercisesForCurrentDay; // array of exercises (pull-ups, push-ups, dips)

+ (AIUser*) create;
+ (AIUser*) currentUser;

- (void) saveUser:(AIUser*) user;

@end
