//
//  AIDoneView.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/31/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIDoneView.h"

@interface AIDoneView ()

@property (strong, nonatomic) UILabel* label;

@end

@implementation AIDoneView


- (instancetype)initWithRow: (NSInteger) row
{
    self = [super init];
    if (self) {
        
        CGFloat offset = 0;
        CGFloat cellHeight = 140;
        
        switch (row) {
            case 0:
                offset = 0;
                break;
                
            case 1:
                offset = cellHeight;
                break;
                
            case 2:
                offset = cellHeight * 2;
                break;
                
            default:
                break;
        }
        
        self.frame = CGRectMake(0, offset,
                                [[UIScreen mainScreen] bounds].size.width,
                                cellHeight);
        
        UIView* backgroundView = [[UIView alloc] initWithFrame:
                                  CGRectMake(0, 0, self.frame.size.width, cellHeight)];
        
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha= 0.5f;
        
        [self addSubview:backgroundView];
        
        // add label 'successful'
        
        self.label               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight)];
        self.label.font          = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:25.f];
        self.label.textColor     = [UIColor colorWithRed:253/255.f green:190/255.f blue:65/255.f alpha:1];
        self.label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.label];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
                       ^{
                           [self animateLabelShowText:@"SUCCESSFUL DONE!" characterDelay:0.05];
                       });
        
    }
    return self;
}

- (void)animateLabelShowText:(NSString*)text characterDelay:(NSTimeInterval)delay {
    
    [self.label setText:@""];
    
    for (int i=0; i<text.length; i++) {
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self.label setText:[NSString stringWithFormat:@"%@%C", self.label.text, [text characterAtIndex:i]]];
                       });
        
        [NSThread sleepForTimeInterval:delay];
    }
}

@end
