//
//  AIDataManager.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/31/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AIProgress;

@interface AIDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (AIDataManager*) sharedManager;

- (void) saveNewProgressWithDictionary:(NSDictionary*) description onSuccess:(void(^)(BOOL saved)) success;

@end
