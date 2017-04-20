//
//  DKCoreDataManager.h
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DKModelData.h"
#import "DKSessionManager.h"

typedef void(^LocationBlock)(DKLocationModel*location);
typedef void(^ErrorBlock)(NSError*error);

@interface DKLocationManager : NSObject <CLLocationManagerDelegate>

//if user disable location
@property (nonatomic) BOOL isDisable;

-(void)getCurrentLocation:(LocationBlock)location error:(ErrorBlock)errorBlock;

+(DKLocationManager*)sharedManager;

@end
