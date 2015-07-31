//
//  ViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/28/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIMainViewController.h"

@interface AIMainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tapImageView;


@end

@implementation AIMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeTapAnimation];
    
}

#pragma mark - Animations

- (void) makeTapAnimation {
    
    [UIView
     animateWithDuration:0.6f
     delay:0
     options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat
     animations:^{
         self.tapImageView.alpha = 1.0f;
     }
     completion:^(BOOL finished) {
         nil;
     }];

}

#pragma mark - Actions

- (IBAction)actionGo:(UIButton *)sender {
    
    
    
}

- (IBAction)actionHowToUse:(UIButton *)sender {
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
