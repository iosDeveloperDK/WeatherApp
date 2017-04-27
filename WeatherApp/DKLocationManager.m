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

@property (copy,nonatomic) LocationBlock locationBlock;
@property (copy,nonatomic) ErrorBlock errorBlock;

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

-(CLLocationManager*)locationManager {
    
    if (!_locationManager) {
        
        _locationManager = [[CLLocationManager alloc]init];
        
        [_locationManager requestAlwaysAuthorization];
        
        _locationManager.delegate = self;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    return _locationManager;
    
}

#pragma mark - CLLocationDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [[DKSessionManager sharedManager] geocoder:locations.lastObject success:^(DKLocationModel *city) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.locationBlock(city);
            
        });
        
    } error:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.errorBlock(error);
            
        });
        
    }];
    
    [manager stopUpdatingLocation];
    
}

#pragma mark Location methods

-(void)getCurrentLocation:(LocationBlock)location error:(ErrorBlock)errorBlock statusLocation:(StatusBlock)statusBlock{
    
    [self.locationManager startUpdatingLocation];
    
    self.locationBlock = location;
    self.errorBlock = errorBlock;
    statusBlock([CLLocationManager authorizationStatus]);
}

#pragma mark - Settings

@end
