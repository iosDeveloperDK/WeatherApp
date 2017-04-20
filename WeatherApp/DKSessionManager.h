//
//  DKSessionManager.h
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKModelData.h"
@import CoreLocation;

typedef void(^WeatherBlock)(DKWeatherModel*weather);
typedef void(^CityBlock)(DKLocationModel*city);
typedef void(^ErrorBlock)(NSError*error);

@interface DKSessionManager : NSObject

//get current weather
-(void)getCurrentWeather:(WeatherBlock)successBlock error:(ErrorBlock)errorBlock withLocation:(DKLocationModel*)location;

//use google geocoder
-(void)geocoder:(CLLocation*)location success:(CityBlock)successBlock error:(ErrorBlock)errorBlock;

+(DKSessionManager*)sharedManager;

@end
