//
//  DKSessionManager.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKSessionManager.h"

static NSString * const OpenWeatherMapKey = @"bb115bb9270e0eca298e514f001a4be8";
static NSString * const OpenWeatherMapURL = @"http://api.openweathermap.org/data/2.5/weather?q=";
static NSString * const OpenWeatherFormat = @"%@%@&units=metric&lang=ru&appid=%@";

static NSString * const GoogleGeocoderURL = @"http://maps.googleapis.com/maps/api/geocode/json?latlng=";
static NSString * const GoogleGeocoderFormat = @"%@%f,%f&sensor=false";


@interface DKSessionManager ()

@property (strong,nonatomic) NSURLSession* session;

@end

@implementation DKSessionManager

+(DKSessionManager*)sharedManager {
    
    static DKSessionManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[DKSessionManager alloc]init];
        
    });
    
    return manager;
}

-(NSURLSession*)session {
    
    if (!_session) {
        
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
    }
    return _session;
    
}

#pragma mark - Weather

-(void)getCurrentWeather:(WeatherBlock)successBlock error:(ErrorBlock)errorBlock withLocation:(DKLocationModel*)location {
    
    NSString* str = [NSString stringWithFormat:OpenWeatherFormat,OpenWeatherMapURL,[location.city stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]],OpenWeatherMapKey];
    
    NSURL *url = [NSURL URLWithString:str];
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data && data.length > 0) {
            
            NSError* error;
            
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (!error) {
                
                DKWeatherModel* weather = [[DKWeatherModel alloc]initWhithDictinary:json];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    successBlock(weather);
                    
                });
                
            }else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    errorBlock(error);
                    
                });
                
            }
            
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                errorBlock(error);
                
            });
            
        }
        
    }] resume];
    
}

#pragma mark - Location

-(void)geocoder:(CLLocation*)location success:(CityBlock)successBlock error:(ErrorBlock)errorBlock{
    
    NSString* str = [NSString stringWithFormat:GoogleGeocoderFormat,GoogleGeocoderURL,location.coordinate.latitude,location.coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:str];
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data && data.length > 0) {
            
            NSError* error;
            
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (!error) {
                
                DKLocationModel* location = [[DKLocationModel alloc]initWhithDictinary:json];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    successBlock(location);
                    
                });
                
            }else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    errorBlock(error);
                    
                });
                
            }
            
            
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                errorBlock(error);
                
            });
            
        }
        
    }] resume];
    
}



@end
