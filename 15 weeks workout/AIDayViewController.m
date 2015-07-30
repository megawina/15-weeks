//
//  AIDayViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIDayViewController.h"
#import "AIExercisesViewController.h"

#import "AIUser.h"

@interface AIDayViewController ()

@property (strong,nonatomic) AIUser* user;

@property (weak, nonatomic) IBOutlet UIButton* goButton;

@property (strong, nonatomic) NSArray* pushUpsArray;
@property (strong, nonatomic) NSArray* pullUpsArray;
@property (strong, nonatomic) NSArray* dipsArray;

@property (assign, nonatomic) NSInteger trainingDay;

@end

@implementation AIDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"timesLaunched"]) {
        [self createProgramForCurrentDay];
    } else {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"trainingDay"];
    }

}

- (void) createProgramForCurrentDay {
    
    self.trainingDay = [[NSUserDefaults standardUserDefaults] integerForKey:@"trainingDay"];
    
    NSLog(@"training day %ld", self.trainingDay);
    
    NSInteger locationInRange = (self.trainingDay/7) * 5;
    
    self.pushUpsArray = [[[self class] pushUps] subarrayWithRange:NSMakeRange(locationInRange, 5)];
    self.pullUpsArray = [[[self class] pullUps] subarrayWithRange:NSMakeRange(locationInRange, 5)];
    self.dipsArray    = [[[self class] dips]    subarrayWithRange:NSMakeRange(locationInRange, 5)];
    
    self.dayLabel.text     = [NSString stringWithFormat:@"DAY %ld",  self.trainingDay];
    self.pushUpsLabel.text = [NSString stringWithFormat:@"%ld", [self countArray:self.pushUpsArray]];
    self.pullUpsLabel.text = [NSString stringWithFormat:@"%ld", [self countArray:self.pullUpsArray]];
    self.dipsLabel.text    = [NSString stringWithFormat:@"%ld", [self countArray:self.dipsArray]];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
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
    
    AIExercisesViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AIExercisesViewController"];
    
    vc.pushUpsArray = self.pushUpsArray;
    vc.pullUpsArray = self.pullUpsArray;
    vc.dipsArray    = self.dipsArray;
    
    vc.numberOfPushUps = [NSNumber numberWithInteger:[self.pushUpsLabel.text integerValue]];
    vc.numberOfPullUps = [NSNumber numberWithInteger:[self.pullUpsLabel.text integerValue]];
    vc.numberOfDips    = [NSNumber numberWithInteger:[self.dipsLabel.text integerValue]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - User programm

+ (NSArray *) pushUps {
    
    static NSArray *pushUpsArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushUpsArray = @[@20,@20,@15,@15,@10,   @25,@25,@20,@15,@10,    @30,@30,@25,@20,@15,
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
        pullUpsArray = @[@6,@5,@5,@4,@3,         @8,@6,@5,@5,@4,         @9,@7,@6,@5,@5,
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
        dips = @[@10,@5,@5,@3,@2,        @15,@15,@10,@5,@5,      @20,@20,@15,@15,@10,
                 @25,@25,@20,@15,@10,    @30,@30,@25,@20,@15,    @35,@30,@25,@20,@15,
                 @40,@35,@25,@25,@15,    @40,@40,@30,@30,@20,    @45,@40,@35,@35,@25,
                 @45,@45,@35,@35,@25,    @50,@45,@35,@35,@30,    @50,@50,@40,@40,@35,
                 @55,@50,@40,@40,@35,    @60,@55,@40,@40,@35,    @60,@60,@45,@45,@40];
    });
    return dips;
}


@end
