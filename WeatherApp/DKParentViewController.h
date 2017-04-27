//
//  DKParentViewController.h
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKActivityView.h"
#import "DKSessionManager.h"
#import "DKLocationManager.h"

@interface DKParentViewController : UIViewController

@property (strong,nonatomic) DKActivityView*activityView;

-(void)showAlertView:(NSString*)message;
-(void)showAppSetting;

@end

