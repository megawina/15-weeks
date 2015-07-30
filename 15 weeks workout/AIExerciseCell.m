//
//  AIExerciseCell.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIExerciseCell.h"
#import "AITimerView.h"
#import <UIKit/UIKit.h>

@interface AIExerciseCell ()

@property (assign, nonatomic) NSInteger doneCount;

@end

@implementation AIExerciseCell

- (void)awakeFromNib {
    
    self.buttonsArray = @[self.firstStepButton, self.secondStepButton,
                          self.thirdStepButton, self.fourthStepButton,
                          self.fifthStepButton];
    
    for (UIButton* button in self.buttonsArray) {
        button.enabled = NO;
    }
    
    self.firstStepButton.enabled = YES;
    
    self.doneCount = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)setExerciseDone:(UIButton*)button {
    
    // we have to proide code below (4 lines) to forbid user random interactions (onle step by step exercises)
    
    NSInteger index = button.tag;
    button.enabled = NO;
    UIButton* nextButton = (UIButton*)[self.contentView viewWithTag:index + 1];
    nextButton.enabled = YES;
    
    
    NSInteger exerciseCount = [button.titleLabel.text integerValue];
    
    self.doneCount += exerciseCount;
    
    self.doneLabel.text = [NSString stringWithFormat:@"done: %ld", self.doneCount];
    
    [self.delegate setExerciseDone:button];
        
}


@end
