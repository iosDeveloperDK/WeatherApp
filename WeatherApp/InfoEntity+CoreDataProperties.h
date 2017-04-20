//
//  InfoEntity+CoreDataProperties.h
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "InfoEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface InfoEntity (CoreDataProperties)

+ (NSFetchRequest<InfoEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *temp;
@property (nullable, nonatomic, copy) NSDate *time;
@property (nullable, nonatomic, copy) NSString *adress;

@end

NS_ASSUME_NONNULL_END
