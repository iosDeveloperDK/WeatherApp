//
//  DKThemeManager.h
//  WeatherApp
//
//  Created by Denis on 23.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ThemeType) {
    DarkTheme,
    LightTheme,
};

@interface DKThemeManager : NSObject

@property (nonatomic) ThemeType themeType;

@end
