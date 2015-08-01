//
//  AIProgress.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/31/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//
//**************************************************************************************
//
//      This class is entity in core data map.
//
//**************************************************************************************

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AIProgress : NSManagedObject

@property (nonatomic, retain) NSDate* trainingDate;

@property (nonatomic, retain) NSNumber* trainingDay;
@property (nonatomic, retain) NSNumber* numberOfPullUps;
@property (nonatomic, retain) NSNumber* numberOfPushUps;
@property (nonatomic, retain) NSNumber* numberOfDips;

@end
