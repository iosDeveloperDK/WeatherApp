//
//  InfoEntity+CoreDataProperties.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "InfoEntity+CoreDataProperties.h"

@implementation InfoEntity (CoreDataProperties)

+ (NSFetchRequest<InfoEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"InfoEntity"];
}

@dynamic city;
@dynamic temp;
@dynamic time;
@dynamic adress;

@end
