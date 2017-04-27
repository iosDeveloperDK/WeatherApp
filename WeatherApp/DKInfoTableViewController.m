//
//  DKInfoTableViewController.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKInfoTableViewController.h"
#import "DKCoreDataManager.h"
#import "DKInfoTableViewCell.h"

static NSString * const indetifier = @"DKInfoTableViewCell";
static CGFloat const height = 100.f;


@interface DKInfoTableViewController ()

@property (nonatomic) NSArray* arrayInfo;

@end

@implementation DKInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"title_history", nil);
    
    [self prepareTableView];
    
}

-(void)prepareTableView {
    
    self.tableView.estimatedRowHeight = height;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = ([DKCoreDataManager sharedInstance].fetchedResultsController).sections[section];
    
    return sectionInfo.numberOfObjects;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DKInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    
    DKInfoModel* info = [[DKCoreDataManager sharedInstance]convertInfoEntityToModelAtIndex:indexPath];
    
    [cell updateCellWithModel:info];
    
    return cell;
    
}



@end
