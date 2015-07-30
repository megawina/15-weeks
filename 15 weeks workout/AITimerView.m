//
//  AITimerView.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/30/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AITimerView.h"

@interface AITimerView()

@property (assign, nonatomic) NSInteger seconds;
@property (strong, nonatomic) UILabel* timerLabel;
@property (strong, nonatomic) NSTimer* timer;

@end

@implementation AITimerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 60);
            self.backgroundColor = [UIColor clearColor];
            
            // background
            
            UIView* backgroundView = [[UIView alloc] initWithFrame:self.frame];
            backgroundView.backgroundColor = [UIColor blackColor];
            backgroundView.alpha = 0.8f;
            [self addSubview:backgroundView];
            
            // animation for circle
            
            int radius = 100;
            
            CAShapeLayer *circle = [CAShapeLayer layer];
            
            circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                     cornerRadius:radius].CGPath;
            
            circle.position = CGPointMake(CGRectGetMidX(self.frame)-radius,
                                          CGRectGetMidY(self.frame)-radius - 50);
            
            circle.fillColor    = [UIColor clearColor].CGColor;
            circle.strokeColor  = [UIColor colorWithRed:252/255.f green:98/255.f blue:93/255.f alpha:1].CGColor;
            circle.lineWidth    = 10.f;
            
            [self.layer addSublayer:circle];
            
            CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            drawAnimation.duration      = 60.0f;
            drawAnimation.repeatCount   = 1.0f;
            
            drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
            
            drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            
            // Add the animation to the circle
            [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
            
            // add timer
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateTime)
                                                        userInfo:nil
                                                         repeats:YES];
            
            // add label for timer
            
            self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 2 - 150, self.frame.size.width, 200)];
            
            self.timerLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:45.f];
            self.timerLabel.textAlignment = NSTextAlignmentCenter;
            self.timerLabel.textColor = [UIColor colorWithRed:253/255.f green:190/255.f blue:65/255.f alpha:1];
            
            [self addSubview:self.timerLabel];
            
        });
    }
    
    return self;
}

-(void)updateTime {
    
    if (!self.seconds) {
       // self.seconds = 60;
        self.seconds = 4;
    }
    
    if (self.seconds != 0) {
        self.seconds --;
        
        
        if (self.seconds < 10) {
            
            if (self.seconds < 3) {
                self.timerLabel.text = @"CONTINUE";
            } else {
                self.timerLabel.text = [NSString stringWithFormat:@"0:0%ld", self.seconds];
            }
            
        } else {
            self.timerLabel.text = [NSString stringWithFormat:@"0:%ld", self.seconds];
        }
        
    }
    
    if (self.seconds == 0) {
        
        [self removeFromSuperview];
        [self.timer invalidate];
        self.timer = nil;
        
    }
    
}

@end
