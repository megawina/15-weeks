//
//  AIStatisticCell.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/1/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIStatisticCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (weak, nonatomic) IBOutlet UILabel *pushUpsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pullUpsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dipsLabel;

@end
