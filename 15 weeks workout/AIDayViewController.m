//
//  AIDayViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.

#import "AIDayViewController.h"
#import "AIExercisesViewController.h"
#import "AIStatisticsTableViewController.h"

#import "AIUtils.h"
#import "AIUser.h"
#import "AIProgress.h"

#import "AIDataManager.h"


@interface AIDayViewController ()

@property (strong,nonatomic) AIUser* user;

@property (weak, nonatomic) IBOutlet UIButton* goButton;
@property (weak, nonatomic) IBOutlet UILabel *nextTrainingTimeLabel;


@property (strong, nonatomic) NSArray* pushUpsArray;
@property (strong, nonatomic) NSArray* pullUpsArray;
@property (strong, nonatomic) NSArray* dipsArray;

@property (assign, nonatomic) NSInteger trainingDay;
@property (assign, nonatomic) NSInteger intervalFromLastTraining;

@property (strong, nonatomic) NSTimer* timer;
@property (strong, nonatomic) NSDate*  lastTrainingDate;

@end

@implementation AIDayViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nextTrainingTimeLabel.text = [NSString stringWithFormat:@"00:00:00"];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"timesLaunched"]) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"trainingDay"];
        
    } else {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(actionUpdateTime)
                                                    userInfo:nil
                                                     repeats:YES];
        
    }
    
    [self createProgramForCurrentDay];
    [self checkDatesUserTrain];
    
}

- (void) createProgramForCurrentDay {
    
    self.trainingDay = [[NSUserDefaults standardUserDefaults] integerForKey:@"trainingDay"];
        
    NSInteger locationInRange = (self.trainingDay/7) * 5;
    
    self.pushUpsArray   = [[[self class] pushUps] subarrayWithRange:NSMakeRange(locationInRange, 5)];
    self.pullUpsArray   = [[[self class] pullUps] subarrayWithRange:NSMakeRange(locationInRange, 5)];
    self.dipsArray      = [[[self class] dips]    subarrayWithRange:NSMakeRange(locationInRange, 5)];
    
    self.dayLabel.text  = [NSString stringWithFormat:@"DAY %ld",  self.trainingDay];
    self.pushLabel.text = [NSString stringWithFormat:@"%ld", [self countArray:self.pushUpsArray]];
    self.pullLabel.text = [NSString stringWithFormat:@"%ld", [self countArray:self.pullUpsArray]];
    self.dipsLabel.text = [NSString stringWithFormat:@"%ld", [self countArray:self.dipsArray]];
    
}

- (NSInteger) countArray: (NSArray*) array {
    
    NSInteger count = 0;
    
    for (NSNumber* number in array) {
        NSInteger intValue = [number integerValue];
        count += intValue;
    }
    
    return count;
}

#pragma mark - Actions

- (IBAction)goNext:(UIButton*)sender {
    
    NSString* savedString = [[NSUserDefaults standardUserDefaults] valueForKey:@"saved"];
    
    if (self.intervalFromLastTraining < MIN_INTERVAL_BEETWEN_TRAININGS &&
        [savedString isEqualToString: @"saved"]) {
        
        [[[UIAlertView alloc]
          initWithTitle:@"Stop"
          message:@"You haven`t do more exercises. Please, do it only at time, that you start at the beginning of trainings +- 4 hours "
          delegate:nil
          cancelButtonTitle:@"Ok"
          otherButtonTitles:nil, nil]
         show];
        
    } else if (self.intervalFromLastTraining > MAX_INTERVAL_BEETWEN_TRAININGS) {
        
        NSLog(@"have to buy");
        
    } else {
        
        AIExercisesViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AIExercisesViewController"];
        
        vc.pushUpsArray = self.pushUpsArray;
        vc.pullUpsArray = self.pullUpsArray;
        vc.dipsArray    = self.dipsArray;
        
        vc.numberOfPushUps = @([self.pushLabel.text integerValue]);
        vc.numberOfPullUps = @([self.pullLabel.text integerValue]);
        vc.numberOfDips    = @([self.dipsLabel.text integerValue]);
        
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}

- (IBAction)actionShowStatistics:(UIButton *)sender {
    
    AIStatisticsTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AIStatisticsTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void) actionUpdateTime {
    
    NSDate* nextTrainingDate = [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:self.lastTrainingDate];
    
    NSDate* today = [NSDate date];
    
    NSTimeInterval trainingInterval = [nextTrainingDate timeIntervalSinceDate:today];
    
    NSInteger hours   = trainingInterval / 60 / 60;
    NSInteger minutes = (trainingInterval - hours * 60 * 60) / 60;
    NSInteger seconds = trainingInterval - hours * 60 * 60 - minutes * 60;
    
    if (self.intervalFromLastTraining < 0) {
        self.nextTrainingTimeLabel.text = @"00:00:00";
    } else {
        self.nextTrainingTimeLabel.text = [NSString stringWithFormat:@"%ld:%ld:%ld",  hours, minutes,seconds];
    }
    
    if (trainingInterval < 1) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

#pragma mark - User programm

+ (NSArray *) pushUps {
    
    static NSArray *pushUpsArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushUpsArray = @[   @20,@20,@15,@15,@10,   @25,@25,@20,@15,@10,    @30,@30,@25,@20,@15,
                            @35,@30,@25,@20,@15,   @40,@35,@25,@25,@15,    @40,@40,@30,@30,@20,
                            @45,@40,@35,@35,@25,   @45,@45,@35,@35,@25,    @50,@45,@35,@35,@30,
                            @50,@50,@40,@40,@35,   @55,@50,@40,@40,@35,    @60,@55,@40,@40,@35,
                            @60,@60,@45,@45,@40,   @65,@60,@45,@45,@40,    @65,@65,@45,@45,@40 ];
    });
    return pushUpsArray;
}

+ (NSArray*) pullUps {
    
    static NSArray *pullUpsArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pullUpsArray = @[   @6,@5,@5,@4,@3,         @8,@6,@5,@5,@4,         @9,@7,@6,@5,@5,
                            @10,@8,@6,@6,@6,        @12,@8,@7,@7,@6,        @13,@9,@8,@7,@7,
                            @14,@10,@8,@8,@8,       @16,@10,@9,@9,@8,       @17,@11,@10,@9,@9,
                            @19,@12,@10,@10,@10,    @20,@12,@11,@11,@10,    @21,@13,@12,@11,@11,
                            @22,@14,@12,@12,@12,    @24,@14,@13,@13,@12,    @25,@15,@14,@13,@13 ];
    });
    return pullUpsArray;
}

+ (NSArray*) dips {
    
    static NSArray *dips;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dips = @[       @10,@5,@5,@3,@2,        @15,@15,@10,@5,@5,      @20,@20,@15,@15,@10,
                        @25,@25,@20,@15,@10,    @30,@30,@25,@20,@15,    @35,@30,@25,@20,@15,
                        @40,@35,@25,@25,@15,    @40,@40,@30,@30,@20,    @45,@40,@35,@35,@25,
                        @45,@45,@35,@35,@25,    @50,@45,@35,@35,@30,    @50,@50,@40,@40,@35,
                        @55,@50,@40,@40,@35,    @60,@55,@40,@40,@35,    @60,@60,@45,@45,@40];
    });
    return dips;
}

#pragma mark - Core Data

- (NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[AIDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
    
}

- (void) checkDatesUserTrain {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AIProgress" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil) {
        
        AIProgress* lastProgress = [fetchedObjects lastObject];
        
        self.lastTrainingDate  = lastProgress.trainingDate;
        NSDate* today = [NSDate date];
        
        self.intervalFromLastTraining = [today timeIntervalSinceDate:self.lastTrainingDate];
        
    }
    
}


@end
