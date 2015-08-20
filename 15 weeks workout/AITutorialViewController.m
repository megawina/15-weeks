//
//  AITutorialViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/17/15.
//  Copyright © 2015 Anton Ivashyna. All rights reserved.
//

#import "AITutorialViewController.h"

@interface AITutorialViewController ()

@end

@implementation AITutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Create the data model
    self.pageTitles = @[@"", @"", @"", @"", @"", @""];
    
    self.pageImages = @[@"page1.jpg", @"page2.jpg", @"page3.jpg",
                        @"page4.jpg", @"page5.jpg", @"page6.jpg"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    AIPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    
    [self.pageViewController
     setViewControllers:@[startingViewController]
     direction:UIPageViewControllerNavigationDirectionForward
     animated:NO
     completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 40,
                                                    CGRectGetWidth(self.view.frame),
                                                    CGRectGetHeight(self.view.frame) - 40);
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

#pragma mark - Actions

- (IBAction)actionHideTutorial:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (AIPageContentViewController*) viewControllerAtIndex: (NSUInteger) index {
    
    if (([self.pageImages count] == 0) ||
        (index >= [self.pageImages count])) {
        return nil;
    }
    
    AIPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AIPageContentViewController"];
    
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((AIPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((AIPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageImages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
