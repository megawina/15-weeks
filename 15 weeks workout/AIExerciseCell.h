//
//  AIExerciseCell.h
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    AICellStateOn,
    AICellStateOff
    
} AICellState;

@interface AIExerciseCell : UITableViewCell

@property (assign, nonatomic) BOOL state;
@property (weak, nonatomic) IBOutlet UIView *stateView;


@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UIButton *firstStepButton;
@property (weak, nonatomic) IBOutlet UIButton *secondStepButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdStepButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthStepButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthStepButton;

@end
