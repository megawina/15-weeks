//
//  AIUser.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIUser.h"

@implementation AIUser

- (void) saveUser:(AIUser*) user {
    
    [[NSUserDefaults standardUserDefaults] setInteger:user.trainingDay forKey:@"trainingDay"];
    [[NSUserDefaults standardUserDefaults] setValue:user.lastTrainingDate forKey:@"lastTrainingDate"];
    
}

+ (AIUser*) currentUser {
    
    AIUser* user = [[AIUser alloc] init];
    
    user.trainingDay = [[NSUserDefaults standardUserDefaults] integerForKey:@"trainingDay"];
    user.lastTrainingDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastTrainingDate"];
    
    return user;
    
}

@end
