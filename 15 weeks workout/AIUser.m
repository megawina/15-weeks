//
//  AIUser.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIUser.h"

@implementation AIUser

+ (AIUser*) create {
    
    AIUser* user = [[AIUser alloc] init];
    
    user.trainingDay = 1;
    
    [[NSUserDefaults standardUserDefaults] setInteger:user.trainingDay forKey:@"trainingDay"];
    
    NSLog(@"def - %ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"trainingDay"]);
    
    return user;
    
}

+ (AIUser*) currentUser {
    
    AIUser* user = [[AIUser alloc] init];
    
    user.trainingDay = [[NSUserDefaults standardUserDefaults] integerForKey:@"trainingDay"]; // we have to change training day after uses click OK after done exercises
    
    return user;
    
}

- (void) saveUser:(AIUser*) user {
    [[NSUserDefaults standardUserDefaults] setInteger:user.trainingDay + 1 forKey:@"trainingDay"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:@"lastTrainingDate"];
}


@end
