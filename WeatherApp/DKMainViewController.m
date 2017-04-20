//
//  DKMainViewController.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKMainViewController.h"
#import "DKWeatherViewController.h"

@interface DKMainViewController ()

{
    DKLocationModel* currenLocation;
}

@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UIButton *buttonShowWeather;
@property (weak, nonatomic) IBOutlet UIButton *buttonShowHistory;

@end

@implementation DKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Main";
    
}

#pragma MARK - Button Actions

- (IBAction)actionDetectLocation:(UIButton *)sender {
    
    __weak typeof(self)weakSelf = self;

    [DKLocationManager sharedManager].isDisable ? nil : [self.activityView startActivity];
    
    [[DKLocationManager sharedManager] getCurrentLocation:^(DKLocationModel *location) {
        
        __strong typeof(self)strongSelf = weakSelf;

        currenLocation = location;
        
        strongSelf.labelLocation.text = [NSString stringWithFormat:@"%@, %@, %@", location.country, location.city, location.address];
        
        [strongSelf.activityView stopActivity];
        
        [strongSelf showWeatherButtonAnimated];
        
    } error:^(NSError *error) {
        
        __strong typeof(self)strongSelf = weakSelf;

        [strongSelf.activityView stopActivity];

        [strongSelf showAlertView:@"The internet connection appears to be offline."];
        
    }];

}


- (IBAction)actionShowWeather:(UIButton *)sender {
    
    DKWeatherViewController*vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DKWeatherViewController"];
    
    vc.location = currenLocation;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Help methods

-(void)showWeatherButtonAnimated {

    [UIView transitionWithView:self.buttonShowWeather
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        self.buttonShowWeather.hidden = NO;
                        
                    }
                    completion:NULL];
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.buttonShowHistory.hidden = ![[NSUserDefaults standardUserDefaults] boolForKey:@"empty"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
