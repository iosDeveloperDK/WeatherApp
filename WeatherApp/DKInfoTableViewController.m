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

@interface DKInfoTableViewController ()

@property (nonatomic) NSArray* arrayInfo;

@end

@implementation DKInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"History";
    
    [self prepareTableView];
    
}

-(void)prepareTableView {
    
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = ([DKCoreDataManager sharedInstance].fetchedResultsController).sections[section];
    
    return sectionInfo.numberOfObjects;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DKInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DKInfoTableViewCell"];
    
    DKInfoModel* info = [[DKCoreDataManager sharedInstance]convertInfoEntityToModelAtIndex:indexPath];
    
    cell.labelCity.text = [NSString stringWithFormat:@"Adress: %@, %@",info.city,info.adress];
    cell.labelTemp.text = [NSString stringWithFormat:@"Temperature: %@",info.temp];
    cell.labelDate.text = [NSString stringWithFormat:@"Time: %@",info.dateString];
    
    
    return cell;
    
}



@end
