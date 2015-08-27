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
#import "AIDoneView.h"

#import "AIDataManager.h"

#import "AIUtils.h"
#import "AIUser.h"
#import "AIProgress.h"

static NSString* exNames[] = {@"PUSH-UPS", @"PULL-UPS", @"DIPS"};

@interface AIExercisesViewController () <AIExerciseCellDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSArray* totalNumber;
@property (strong, nonatomic) NSMutableArray* allExercisesArray;
@property (assign, nonatomic) BOOL allExercisesDone;

@end

@implementation AIExercisesViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Exercises";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Save"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(saveProgress:)];
    
    self.navigationItem.rightBarButtonItem = saveItem;
    
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"timesLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"timesLaunched"];
    }
    
    self.allExercisesArray = [NSMutableArray array];
    [self.allExercisesArray addObject:self.pushUpsArray];
    
    self.totalNumber = @[self.numberOfPushUps, self.numberOfPullUps, self.numberOfDips];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Actions

- (void) saveProgress: (UIBarButtonItem*) item {
    
    if (!self.allExercisesDone) {
        
        [[[UIAlertView alloc]
          initWithTitle:@"Warning"
          message:@"You can`t save today`s progress without all exercises have been done!"
          delegate:nil
          cancelButtonTitle:@"Cancel"
          otherButtonTitles:nil, nil]
         show];
        
    } else {
        
        [self saveNewProgressInCoreData];
        
        [[[UIAlertView alloc]
          initWithTitle:@"Saved"
          message:@"Your progress have been updated! You can see your new statistics. TIme to next training - 24h"
          delegate:self
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil, nil]
         show];
    }
    
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

#pragma mark - UITbableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - AIExerciseCellDelegate

- (void) setExerciseDone:(UIButton *)button {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[button superview] superview]];
    
    NSUInteger row = indexPath.row;
        
    [self makeAnimationForButton:button inRow:row];
    
    if (button.tag != 4) {
        
       //[self showTimerView];
        
    } else {
        
        if (row == 2) {
            self.allExercisesDone = YES;
        }
        
        AIDoneView* doneView = [[AIDoneView alloc] initWithRow:row];        // to show view with title 'successful done' after exercises
        [self.view addSubview:doneView];
        
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
            color = UICOLOR_LIGHT_GRAY;
            break;
        case 1:
            color = UICOLOR_LIGHT_BLUE;
            break;
        case 2:
            color = UICOLOR_DARK_BLUE;
            break;
        case 3:
            color = UICOLOR_DARK_YELLOW;
            break;
        case 4:
            color = UICOLOR_DARK_RED;
            break;
            
        default:
            break;
    }
    
    circle.fillColor    = color.CGColor;
    circle.strokeColor  = color.CGColor;
    circle.lineWidth    = 1;
        
    [button.layer insertSublayer:circle atIndex:0];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    pathAnimation.fromValue     = @(0.0f);
    pathAnimation.toValue       = @(1.0f);
    pathAnimation.duration      = 0.5f;
    pathAnimation.repeatCount   = 1.0f;
    
    CAMediaTimingFunction* timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.timingFunction = timingFunction;
    
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
    
    AITimerView* timerView = [[AITimerView alloc] initAndStart];
    [self.view addSubview:timerView];
        
}

#pragma mark - Core Data

- (void) saveNewProgressInCoreData {
    
    NSDictionary* dictionary = @{ @"numberOfPushUps" : self.numberOfPushUps,
                                  @"numberOfPullUps" : self.numberOfPullUps,
                                  @"numberOfDips"    : self.numberOfDips};
    
    
    [[AIDataManager sharedManager] saveNewProgressWithDictionary:dictionary onSuccess:^(BOOL saved) {
        
        if (saved) {
            NSInteger currentTrainingDay = [[NSUserDefaults standardUserDefaults] integerForKey:@"trainingDay"];
            currentTrainingDay++;
            [[NSUserDefaults standardUserDefaults] setInteger:currentTrainingDay forKey:@"trainingDay"];
            [[NSUserDefaults standardUserDefaults] setValue:@"saved" forKey:@"saved"];
        }
        
    }];
    
}

- (NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[AIDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
    
}



@end
