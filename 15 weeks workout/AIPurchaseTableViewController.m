//
//  AIPurchaseTableViewController.m
//  15 weeks workout
//
//  Created by Anton Ivashyna on 8/16/15.
//  Copyright © 2015 Anton Ivashyna. All rights reserved.
//

#import "AIPurchaseTableViewController.h"
#import "AIProductCell.h"
#import <StoreKit/StoreKit.h>

@interface AIPurchaseTableViewController () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) NSArray* productIDs;
@property (strong, nonatomic) NSMutableArray* productsArray;

@property (assign, nonatomic) NSInteger selectedProductIndex;
@property (assign, nonatomic) BOOL transactionInProgress;

@end

@implementation AIPurchaseTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.productIDs = @[@"15_weeks_workout_ability"];
    self.productsArray = [NSMutableArray array];
    
    [self reqestProductInfo];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

- (void) reqestProductInfo {
    
    if ([SKPaymentQueue canMakePayments]) {
        
        NSSet* productIdentifiers = [NSSet setWithArray:self.productIDs];
        
        SKProductsRequest* productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
        
        productRequest.delegate = self;
        [productRequest start];
        
    } else {
        NSLog(@"Cannot perform In App Purchases.");
    }
    
}

#pragma mark - SKProductsRequestDelegate

- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    if ([response.products count] != 0) {
        for (SKProduct* product in response.products) {
            [self.productsArray addObject:product];
        }
        [self.tableView reloadData];
    } else {
        NSLog(@"There are no products.");
    }
    
    if ([response.invalidProductIdentifiers count] != 0) {
        NSLog(@"invalidProductIdentifiers - %@", response.invalidProductIdentifiers.description);
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.productsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identidier = @"productCellIdentifier";
    
    AIProductCell* cell = [tableView dequeueReusableCellWithIdentifier:identidier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[AIProductCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identidier];
    }
    
    SKProduct* product = self.productsArray[indexPath.row];
    
    NSLog(@"\n %@ \n %@", product.localizedTitle, product.localizedDescription);
    
    
    cell.titleLabel.text = product.localizedTitle;
    cell.descriptionLabel.text = product.localizedDescription;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedProductIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showActions];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

- (void) showActions {
    
    if (self.transactionInProgress) {
        return;
    }
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Make purchase"
                                message:@"What do you want to do?"
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* buyAction = [UIAlertAction
                                actionWithTitle:@"Buy"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction* action) {
                                    
                                    SKPayment* payment = [SKPayment paymentWithProduct:self.productsArray[self.selectedProductIndex]];
                                    
                                    [[SKPaymentQueue defaultQueue] addPayment:payment];
                                    self.transactionInProgress = YES;
                                    
                                }];
    
    UIAlertAction* cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction* action) {
                                       
                                   }];
    
    [alert addAction:buyAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - SKPaymentTransactionObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray*) transactions {
    
    for (SKPaymentTransaction* transaction in transactions) {
        
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: {
                
                NSLog(@"Transaction completed successfully.");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                self.transactionInProgress = NO;
                
                [self.delegate didBuyAbility];
                
            }
                break;
                
            case SKPaymentTransactionStateFailed: {
                NSLog(@"Transaction Failed");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                self.transactionInProgress = NO;
            }
                
                break;
                
            default:
                NSLog(@"%ld", (long)transaction.transactionState);
                break;
        }
        
    }
    
}



@end
