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

@protocol AIExerciseCellDelegate;

@interface AIExerciseCell : UITableViewCell

@property (weak, nonatomic) id <AIExerciseCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *doneLabel;

@property (strong, nonatomic) NSArray* buttonsArray;

@property (weak, nonatomic) IBOutlet UIButton *firstStepButton;
@property (weak, nonatomic) IBOutlet UIButton *secondStepButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdStepButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthStepButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthStepButton;

@end

@protocol AIExerciseCellDelegate <NSObject>

- (void) setExerciseDone:(UIButton*) button;

@end
