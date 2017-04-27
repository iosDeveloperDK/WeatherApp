//
//  DKInfoTableViewCell.h
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKModelData.h"

@interface DKInfoTableViewCell : UITableViewCell

-(void)updateCellWithModel:(DKInfoModel*)model;

@end
