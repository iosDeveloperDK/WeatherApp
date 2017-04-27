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
typedef void(^StatusBlock)(CLAuthorizationStatus status);

@interface DKLocationManager : NSObject <CLLocationManagerDelegate>

-(void)getCurrentLocation:(LocationBlock)location error:(ErrorBlock)errorBlock statusLocation:(StatusBlock)statusBlock;

+(DKLocationManager*)sharedManager;

@end
