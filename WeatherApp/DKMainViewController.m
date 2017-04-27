//
//  DKMainViewController.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKMainViewController.h"
#import "DKWeatherViewController.h"

static NSString * const title = @"Main";
static NSString * const indetifierVC = @"DKWeatherViewController";
static NSString * const historyKey = @"empty";
static NSTimeInterval const duration = 0.4;
static NSString * const labelLocationFormat = @"%@, %@, %@";

@interface DKMainViewController ()

@property (strong,nonatomic) DKLocationModel* currenLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UIButton *buttonShowWeather;
@property (weak, nonatomic) IBOutlet UIButton *buttonShowHistory;

@end

@implementation DKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = title;
    
}

#pragma MARK - Button Actions

- (IBAction)actionDetectLocation:(UIButton *)sender {
    
    __weak typeof(self)weakSelf = self;

    [[DKLocationManager sharedManager] getCurrentLocation:^(DKLocationModel *location) {
        
        __strong typeof(self)strongSelf = weakSelf;

        self.currenLocation = location;
        
        strongSelf.labelLocation.text = [NSString stringWithFormat:labelLocationFormat, location.country, location.city, location.address];
        
        [strongSelf.activityView stopActivity];
        
        [strongSelf showWeatherButtonAnimated];
        
    } error:^(NSError *error) {
        
        __strong typeof(self)strongSelf = weakSelf;

        [strongSelf.activityView stopActivity];

        [strongSelf showAlertView:[error localizedDescription]];
        
    } statusLocation:^(CLAuthorizationStatus status) {
        
        switch (status) {
                
            case kCLAuthorizationStatusDenied:
                [weakSelf showAppSetting];
                break;
                
            case kCLAuthorizationStatusAuthorizedAlways:
                [weakSelf.activityView startActivity];
                break;

            default:
                break;
        }
        
    }];

}


- (IBAction)actionShowWeather:(UIButton *)sender {
    
    DKWeatherViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:indetifierVC];
    
    vc.location = self.currenLocation;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Help methods

-(void)showWeatherButtonAnimated {

    [UIView transitionWithView:self.buttonShowWeather
                      duration:duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        self.buttonShowWeather.hidden = NO;
                        
                    }
                    completion:NULL];
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.buttonShowHistory.hidden = ![[NSUserDefaults standardUserDefaults] boolForKey:historyKey];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
