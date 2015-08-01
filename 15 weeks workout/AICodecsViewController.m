//
//  AICodecsViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/1/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AICodecsViewController.h"
#import "AIDayViewController.h"

@interface AICodecsViewController ()

@end

@implementation AICodecsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Actions

- (IBAction) actionDismiss: (UIButton*) sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate goToDayViewController];
    }];
    
}

@end
