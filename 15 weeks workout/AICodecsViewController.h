//
//  AICodecsViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/1/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//
//**************************************************************************************
//
//      This class helps to show user screen, in which he have to become familiar with
//      app codecs , which is written in 3 labels.
//
//**************************************************************************************

#import <UIKit/UIKit.h>

@protocol AICodecsViewControllerDelegate;               

@interface AICodecsViewController : UIViewController

@property (weak, nonatomic) id <AICodecsViewControllerDelegate> delegate;

@end

@protocol AICodecsViewControllerDelegate <NSObject>

- (void) goToDayViewController;

@end