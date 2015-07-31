//
//  AIDayViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIDayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (weak, nonatomic) IBOutlet UILabel *pushLabel;
@property (weak, nonatomic) IBOutlet UILabel *pullLabel;
@property (weak, nonatomic) IBOutlet UILabel *dipsLabel;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
