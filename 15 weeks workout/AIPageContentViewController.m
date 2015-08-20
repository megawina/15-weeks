//
//  AIPageContentViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/17/15.
//  Copyright © 2015 Anton Ivashyna. All rights reserved.
//

#import "AIPageContentViewController.h"
#import "AITutorialViewController.h"

@interface AIPageContentViewController ()

@end

@implementation AIPageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    
}


@end
