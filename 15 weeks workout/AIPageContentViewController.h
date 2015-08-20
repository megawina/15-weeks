//
//  AIPageContentViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/17/15.
//  Copyright © 2015 Anton Ivashyna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIPageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property NSUInteger pageIndex;
@property NSString *imageFile;

@end
