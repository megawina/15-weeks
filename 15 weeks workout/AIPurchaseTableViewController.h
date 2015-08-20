//
//  AIPurchaseTableViewController.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/16/15.
//  Copyright © 2015 Anton Ivashyna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AIPurchaseTableViewControllerDelegate;

@interface AIPurchaseTableViewController : UITableViewController

@property (weak, nonatomic) id <AIPurchaseTableViewControllerDelegate> delegate;

@end

@protocol AIPurchaseTableViewControllerDelegate <NSObject>

- (void) didBuyAbility;

@end

