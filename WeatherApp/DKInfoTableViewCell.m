//
//  DKInfoTableViewCell.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKInfoTableViewCell.h"

static NSString * const adressFormat = @"Adress: %@, %@";
static NSString * const temperatureFormat = @"Temperature: %@";
static NSString * const timeFormat = @"Time: %@";

@interface DKInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;

@end

@implementation DKInfoTableViewCell

-(void)updateCellWithModel:(DKInfoModel*)model {

    self.labelCity.text = [NSString stringWithFormat:adressFormat,model.city,model.adress];
    self.labelTemp.text = [NSString stringWithFormat:temperatureFormat,model.temp];
    self.labelDate.text = [NSString stringWithFormat:timeFormat,model.dateString];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
