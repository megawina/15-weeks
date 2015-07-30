//
//  AIExerciseCell.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIExerciseCell.h"
#import <UIKit/UIKit.h>

@implementation AIExerciseCell

- (void)awakeFromNib {
    
    self.buttonsArray = @[self.firstStepButton, self.secondStepButton,
                          self.thirdStepButton, self.fourthStepButton,
                          self.fifthStepButton];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)setExerciseDone:(UIButton*)button {
    [self.delegate setExerciseDone:button];
}

@end
