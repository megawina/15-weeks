//
//  AIExercisesViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 7/29/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIExercisesViewController.h"
#import "AIExerciseCell.h"
#import "AITimerView.h"

#import "AIUser.h"

#define CELL_HEIGHT  140

static NSString* exNames[] = {@"PUSH-UPS", @"PULL-UPS", @"DIPS"};


@interface AIExercisesViewController () <AIExerciseCellDelegate>

@property (strong, nonatomic) NSArray* totalNumber;
@property (strong, nonatomic) NSMutableArray* allExercisesArray;

@end

@implementation AIExercisesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Exercises";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"timesLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"timesLaunched"];
        
        NSLog(@"have to create");
        
    } else {
        NSLog(@"created");
    }
    
    self.allExercisesArray = [NSMutableArray array];
    [self.allExercisesArray addObject:self.pushUpsArray];
    
    self.totalNumber = @[self.numberOfPushUps, self.numberOfPullUps, self.numberOfDips];
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allExercisesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"cellIdentifier";
    
    AIExerciseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[AIExerciseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell: (AIExerciseCell*) cell atIndexPath: (NSIndexPath*) indexPath {
    
    cell.exerciseLabel.text = exNames[indexPath.row];
    cell.totalLabel.text = [NSString stringWithFormat:@"TOTAL: %@", self.totalNumber[indexPath.row]];
    
    NSArray* exercises = self.allExercisesArray[indexPath.row];                             // array of NSNumber elements of current exercise
    
    for (int i = 0; i < 5; i ++) {
        
        UIButton* button = cell.buttonsArray[i];
        
        NSString* numberOfRepetitions = [NSString stringWithFormat:@"%@", exercises[i]];
        
        [button setTitle:numberOfRepetitions forState:UIControlStateNormal];
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - AIExerciseCellDelegate

- (void) setExerciseDone:(UIButton *)button {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[button superview] superview]];
    NSUInteger row = indexPath.row;
        
    [self makeAnimationForButton:button inRow:row];
    
    if (button.tag != 4) {
        [self showTimerView];
    } else {
        [self addNextCellWithRow:row + 1];
    }

}

#pragma mark - Animations

- (void) makeAnimationForButton:(UIButton*) button inRow: (NSInteger) row {
    
    int radius = button.frame.size.width / 2;
    
    CGPoint drawPoint = CGPointMake(button.bounds.origin.x + radius, button.bounds.origin.y + radius);
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:radius startAngle:0 endAngle:M_PI*2 clockwise:NO].CGPath;
    circle.position = drawPoint;
    
    UIColor* color;

    switch (button.tag) {
        case 0:
            color = [UIColor colorWithRed:233/255.f green:236/255.f blue:241/255.f alpha:1];
            break;
        case 1:
            color = [UIColor colorWithRed:175/255.f green:208/255.f blue:247/255.f alpha:1];
            break;
        case 2:
            color = [UIColor colorWithRed:74/255.f green:144/255.f blue:226/255.f alpha:1];
            break;
        case 3:
            color = [UIColor colorWithRed:253/255.f green:190/255.f blue:65/255.f alpha:1];
            break;
        case 4:
            color = [UIColor colorWithRed:252/255.f green:98/255.f blue:93/255.f alpha:1];
            break;
            
        default:
            break;
    }
    
    circle.fillColor = color.CGColor;
    circle.strokeColor = color.CGColor;
    circle.lineWidth = 1;
        
    [button.layer insertSublayer:circle atIndex:0];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    [pathAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
    [pathAnimation setToValue:[NSNumber numberWithFloat:1.0f]];
    [pathAnimation setDuration:0.5f];
    [pathAnimation setRepeatCount:1.0f];
    [pathAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [circle addAnimation:pathAnimation forKey:@"changePathAnimation"];
    
    [button setTitleColor:[UIColor colorWithRed:56/255.f green:63/255.f blue:74/255.f alpha:1] forState:UIControlStateNormal];
    
}

- (void) addNextCellWithRow:(NSInteger) row {
    
    if (row < 3) {
        
        row == 1 ? [self.allExercisesArray addObject:self.pullUpsArray] : [self.allExercisesArray addObject:self.dipsArray];
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
    }
    
}

#pragma mark - Timer

- (void) showTimerView {
    
    AITimerView* timerView = [[AITimerView alloc] init];
        
    [self.view addSubview:timerView];
        
}


@end
