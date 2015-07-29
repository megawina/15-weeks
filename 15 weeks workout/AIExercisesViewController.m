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

@end

@implementation AIExercisesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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

@end
