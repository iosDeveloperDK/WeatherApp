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

@property (nonatomic) NSArray<DKInfoModel*>* arrayInfo;

@end

@implementation DKInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"History";
    
    [self prepareTableView];
    
    [[DKCoreDataManager sharedInstance] getAllInfo:^(NSArray<DKInfoModel *> *arrayInfo) {
       
        self.arrayInfo = arrayInfo;
        
        [self.tableView reloadData];
        
    }];
    

}

-(void)prepareTableView {
    
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayInfo.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DKInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DKInfoTableViewCell"];
    
    DKInfoModel* info = self.arrayInfo[indexPath.row];
    
    cell.labelCity.text = [NSString stringWithFormat:@"Adress: %@, %@",info.city,info.adress];
    cell.labelTemp.text = [NSString stringWithFormat:@"Temperature: %@",info.temp];
    cell.labelDate.text = [NSString stringWithFormat:@"Time: %@",info.dateString];
    
    
    return cell;
    
}


@end
