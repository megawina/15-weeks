//
//  AIUser.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIUser : NSObject

@property (strong, nonatomic) NSDate* lastTrainingDate;     // allows to count if user train everyday
@property (assign, nonatomic) NSInteger trainingDay;        // allows to count what day user training, cause data about number of exercises is build on training day

- (void) saveUser:(AIUser*) user;                           // have to use after completed exercises
+ (AIUser*) currentUser;


@end
