//
//  AITutorialViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/17/15.
//  Copyright © 2015 Anton Ivashyna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIPageContentViewController.h"

@interface AITutorialViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end
