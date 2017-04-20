//
//  DKWeatherViewController.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKWeatherViewController.h"
#import "DKCoreDataManager.h"

@interface DKWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;

@end

@implementation DKWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Weather";

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
        
        self.labelCity.text = [NSString stringWithFormat:@"%@, %@", self.location.country, self.location.city];
        self.labelDesc.text = weather.type;
        self.labelTemp.text = weather.temp;
        
        [[DKCoreDataManager sharedInstance] saveInfo:[[DKInfoModel alloc] initWhithLocation:self.location andWeather:weather]];
        
    } error:^(NSError *error) {
        
        [weakSelf.activityView stopActivity];

        [weakSelf showAlertView:[error localizedDescription]];
        
    } withLocation:self.location];
    
}

@end
