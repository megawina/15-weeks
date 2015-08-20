//
//  ViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/28/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIMainViewController.h"
#import "AICodecsViewController.h"
#import "AIDayViewController.h"
#import "AITutorialViewController.h"

@interface AIMainViewController () <AICodecsViewControllerDelegate>

@property (strong, nonatomic) AICodecsViewController* codecsViewController;

@end

@implementation AIMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)dealloc {
    self.codecsViewController.delegate = nil;
}


#pragma mark - Actions

- (IBAction)actionGo:(UIButton *)sender {
    
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"timesLaunched"]) {                  // integer for this key could be created in AIExerciseViewController
        
        self.codecsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AICodecsViewController"];
        self.codecsViewController.delegate = self;
        [self.navigationController presentViewController:self.codecsViewController animated:YES completion:nil];
        
    } else {
        
        [self goToDayViewController];
        
    }
    
}

- (IBAction)actionHowToUse:(UIButton *)sender {
    
    #pragma mark - TODO: ADD PAGE VIEW TUTORIAL
    
    AITutorialViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AITutorialViewController"];
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];

}


#pragma mark - AICodecsViewControllerDelegate

- (void) goToDayViewController {
    
    AIDayViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AIDayViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
