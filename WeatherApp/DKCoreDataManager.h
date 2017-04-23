//
//  DKLocationManager.h
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoEntity+CoreDataProperties.h"
#import "DKModelData.h"

typedef void(^InfoBlock)(NSArray<DKInfoModel*>*arrayInfo);

@interface DKCoreDataManager : NSObject <NSFetchedResultsControllerDelegate>

//info methods
-(void)saveInfo:(DKInfoModel*)info;
-(DKInfoModel*)convertInfoEntityToModelAtIndex:(NSIndexPath*)index;

//NSFetchedResultsController
@property (strong, nonatomic) NSFetchedResultsController<InfoEntity *> *fetchedResultsController;

+(DKCoreDataManager*)sharedInstance;

@end
