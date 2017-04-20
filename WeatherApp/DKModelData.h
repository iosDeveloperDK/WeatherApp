//
//  DKModelData.h
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKLocationModel : NSObject

@property (strong,nonatomic) NSString*city;
@property (strong,nonatomic) NSString*country;
@property (strong,nonatomic) NSString*address;

- (instancetype)initWhithDictinary:(NSDictionary*)dict;

@end


@interface DKWeatherModel : NSObject

@property (nonatomic) NSString* type;
@property (nonatomic) NSString* temp;

- (instancetype)initWhithDictinary:(NSDictionary*)dict;

@end


@interface DKInfoModel : NSObject

@property (strong,nonatomic) NSString*city;
@property (strong,nonatomic) NSString*adress;
@property (strong,nonatomic) NSString*temp;
@property (strong,nonatomic) NSString*dateString;
@property (strong,nonatomic) NSDate* date;

- (instancetype)initWhithLocation:(DKLocationModel*)location andWeather:(DKWeatherModel*)weather;


@end
