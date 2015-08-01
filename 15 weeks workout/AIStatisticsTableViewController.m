//
//  AIStatisticsTableViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/1/15.
//  Copyright (c) 2015 Anton Ivashyna. All rights reserved.
//

#import "AIStatisticsTableViewController.h"

#import "AIStatisticCell.h"

#import "AIDataManager.h"

#import "AIUtils.h"
#import "AIProgress.h"

@interface AIStatisticsTableViewController ()

@property (strong, nonatomic) NSMutableArray* allDaysArray;

@property (strong, nonatomic) NSNumber* allPushUps;
@property (strong, nonatomic) NSNumber* allPullUps;
@property (strong, nonatomic) NSNumber* allDips;

@end

@implementation AIStatisticsTableViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Statistics";
    
    self.allDaysArray = [NSMutableArray arrayWithArray:[self fetchedObjects]];
    
}

- (NSArray*) fetchedObjects {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AIProgress" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"trainingDay" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil) {
        
        for (AIProgress* dayProgress in fetchedObjects) {
            
            self.allPushUps = @([self.allPushUps integerValue] + [dayProgress.numberOfPushUps integerValue]);
            self.allPullUps = @([self.allPullUps integerValue] + [dayProgress.numberOfPullUps integerValue]);
            self.allDips    = @([self.allDips    integerValue] + [dayProgress.numberOfDips    integerValue]);
            
        }
        
        return fetchedObjects;
    }
    
    return nil;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allDaysArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"progressCell";
    
    AIStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[AIStatisticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell: (AIStatisticCell*) cell atIndexPath: (NSIndexPath*) indexPath {
    
    if (indexPath.row < [self.allDaysArray count]) {
        
        AIProgress* progress = self.allDaysArray[indexPath.row];
        
        [self setWhiteTextColorForAllLabelsInCell:cell];
        
        cell.dayLabel.text      = [NSString stringWithFormat:@"DAY %@", progress.trainingDay];
        cell.pushUpsLabel.text  = [NSString stringWithFormat:@"%@", progress.numberOfPushUps];
        cell.pullUpsLabel.text  = [NSString stringWithFormat:@"%@", progress.numberOfPullUps];
        cell.dipsLabel.text     = [NSString stringWithFormat:@"%@", progress.numberOfDips];
        
    } else {
        
        [self setRedTextColorForAllLabelsInCell:cell];
        
        cell.dayLabel.text      = @"TOTAL";
        
        if (!self.allPushUps) {
            
            cell.pushUpsLabel.text  = @"0";
            cell.pullUpsLabel.text  = @"0";
            cell.dipsLabel.text     = @"0";
            
        } else {
            
            cell.pushUpsLabel.text  = [NSString stringWithFormat:@"%@", self.allPushUps];
            cell.pullUpsLabel.text  = [NSString stringWithFormat:@"%@", self.allPullUps];
            cell.dipsLabel.text     = [NSString stringWithFormat:@"%@", self.allDips];
            
        }
        
    }
    
}

- (void) setWhiteTextColorForAllLabelsInCell: (AIStatisticCell*) cell {
    
    cell.dayLabel.textColor     = UICOLOR_DARK_RED;
    cell.pushUpsLabel.textColor = [UIColor whiteColor];
    cell.pullUpsLabel.textColor = [UIColor whiteColor];
    cell.dipsLabel.textColor    = [UIColor whiteColor];
    
}

- (void) setRedTextColorForAllLabelsInCell: (AIStatisticCell*) cell {
    
    cell.dayLabel.textColor     = UICOLOR_DARK_YELLOW;
    cell.pushUpsLabel.textColor = UICOLOR_DARK_YELLOW;
    cell.pullUpsLabel.textColor = UICOLOR_DARK_YELLOW;
    cell.dipsLabel.textColor    = UICOLOR_DARK_YELLOW;
    
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView = [self.tableView viewWithTag:20];
    
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Core Data

- (NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[AIDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}


@end
