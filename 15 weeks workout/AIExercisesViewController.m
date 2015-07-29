//
//  AIExercisesViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIExercisesViewController.h"
#import "AIExerciseCell.h"

@interface AIExercisesViewController ()

@property (strong, nonatomic) NSMutableArray* pullUpsArray;
@property (strong, nonatomic) NSMutableArray* pushUpsArray;
@property (strong, nonatomic) NSMutableArray* dipsArray;

@end

@implementation AIExercisesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* arr = [[self class] pushUps];
    
    NSLog(@"%@", arr);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"cellIdentifier";
    
    AIExerciseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[AIExerciseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    NSLog(@"cellForRowAtIndexPath");
    
    return cell;
}

- (void) configureCell: (AIExerciseCell*) cell atIndexPath: (NSIndexPath*) indexPath {
    
    
    
}

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
