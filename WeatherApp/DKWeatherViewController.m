//
//  DKWeatherViewController.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKWeatherViewController.h"
#import "DKCoreDataManager.h"

static NSString * const title = @"Weather";
static NSString * const cityFormat = @"%@, %@";

@interface DKWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;

@end

@implementation DKWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = title;

    [self getCurrentWeather];
    
}

#pragma mark - Button Action

- (IBAction)actionRefresh:(UIButton *)sender {
    
    [self getCurrentWeather];
    
}

#pragma mark - Weather method

-(void)getCurrentWeather {

    [self.activityView startActivity];

    __weak typeof(self)weakSelf = self;

    [[DKSessionManager sharedManager] getCurrentWeather:^(DKWeatherModel *weather) {
        
        [weakSelf.activityView stopActivity];
        
        [self updateLabelWithBodel:weather];
        
        [[DKCoreDataManager sharedInstance] saveInfo:[[DKInfoModel alloc] initWhithLocation:self.location andWeather:weather]];
        
    } error:^(NSError *error) {
        
        [weakSelf.activityView stopActivity];

        [weakSelf showAlertView:[error localizedDescription]];
        
    } withLocation:self.location];
    
}

-(void)updateLabelWithBodel:(DKWeatherModel*)model {

    self.labelCity.text = [NSString stringWithFormat:cityFormat, self.location.country, self.location.city];
    self.labelDesc.text = model.type;
    self.labelTemp.text = model.temp;

}

@end
