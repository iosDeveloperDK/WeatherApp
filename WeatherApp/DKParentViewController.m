//
//  DKParentViewController.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKParentViewController.h"

@interface DKParentViewController ()

@end

@implementation DKParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.activityView = [[DKActivityView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:self.activityView];
}

-(void)showAlertView:(NSString*)message {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Try again"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirm = [UIAlertAction
                              actionWithTitle:@"Ok"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction *action)
                              {}];
    
    [alertController addAction:confirm];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)showAppSetting {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Location disable"
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *openSettings = [UIAlertAction
                                   actionWithTitle:@"Open settings"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                       
                                   }];
    
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action)
                             {}];
    
    [alertController addAction:openSettings];
    
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
