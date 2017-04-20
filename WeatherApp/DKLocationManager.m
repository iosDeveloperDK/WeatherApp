//
//  DKLocationManager.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKLocationManager.h"
#import <UIKit/UIKit.h>

@interface DKLocationManager ()

{
    LocationBlock _locationBlock;
    ErrorBlock _errorBlock;
}

@property (nonatomic) CLLocationManager* locationManager;

@end

@implementation DKLocationManager


+(DKLocationManager*)sharedManager {
    
    static DKLocationManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[DKLocationManager alloc]init];
        
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.locationManager = [[CLLocationManager alloc]init];
        
        [self.locationManager requestAlwaysAuthorization];
        
        self.locationManager.delegate = self;
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.isDisable = [self isLocationDisableForApp];
        
    }
    return self;
}

#pragma mark - CLLocationDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //Нельзя получить адрес Беларуси
    
//    CLGeocoder* geoCoder = [CLGeocoder new];
//    
//    [geoCoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        
//        DKLocationModel* location = [DKLocationModel new];
//        
//        location.city = placemarks.lastObject.locality;
//        location.country = placemarks.lastObject.country;
//        
//        if (placemarks) {
//            
//            _locationBlock(location);
//            
//            
//        }else {
//            
//            _errorBlock(error);
//            
//        }
//        
//    }];

    [[DKSessionManager sharedManager] geocoder:locations.lastObject success:^(DKLocationModel *city) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _locationBlock(city);

        });
        
    } error:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _errorBlock(error);

        });
        
    }];
    
    [manager stopUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            
            self.isDisable = NO;
            break;
            
        default:
            
            self.isDisable = YES;
            break;
    }
    
}


#pragma mark Location methods

-(void)getCurrentLocation:(LocationBlock)location error:(ErrorBlock)errorBlock{
    
    [self isLocationDisableForApp] ? [self showSettingApp] : nil;
    
    [self.locationManager startUpdatingLocation];
    
    _locationBlock = location;
    _errorBlock = errorBlock;
    
}

-(BOOL)isLocationDisableForApp {
    
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        return YES;
        
    }
    
    return NO;
}

#pragma mark - Settings

-(void)showSettingApp {
    
    
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
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    
    
}

@end
