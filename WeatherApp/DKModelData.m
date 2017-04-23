//
//  DKModelData.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKModelData.h"

@implementation DKLocationModel

- (instancetype)initWhithDictinary:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        
        if (dict) {
            
            NSInteger count = [dict[@"results"][0][@"address_components"] count];
            
            self.city = dict[@"results"][0][@"address_components"][count-2][@"long_name"];
            self.country = dict[@"results"][0][@"address_components"][count-1][@"long_name"];
            self.address = [dict[@"results"][0][@"address_components"][count-3][@"long_name"] stringByAppendingFormat:@" %@",dict[@"results"][0][@"address_components"][0][@"long_name"]];
            
        }
        
    }
    return self;
}

@end

@implementation DKWeatherModel

- (instancetype)initWhithDictinary:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        
        if (dict) {
            
            self.type = [[dict[@"weather"] lastObject][@"description"] uppercaseString];
            
            self.temp = [NSString stringWithFormat:@"%.0f º",[dict[@"main"][@"temp"] floatValue]];
            
        }
        
    }
    return self;
}

@end

@implementation DKInfoModel

- (instancetype)initWhithLocation:(DKLocationModel*)location andWeather:(DKWeatherModel*)weather {
    
    self = [super init];
    if (self) {
        
        self.temp = weather.temp;
        
        self.city = location.city;
        
        self.adress = location.address;
        
        self.date = [NSDate date];
        
    }
    return self;
    
}

//get formated date
-(NSString*)dateString {
    
    NSDateFormatter* dateF = [[NSDateFormatter alloc]init];
    
    dateF.dateFormat = @"MM/dd/yyyy HH:mm:ss";
    
    _dateString = [dateF stringFromDate:self.date];
    
    return _dateString;
    
}

@end
