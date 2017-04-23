//
//  DKThemeManager.m
//  WeatherApp
//
//  Created by Denis on 23.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKThemeManager.h"

@implementation DKThemeManager

-(void)setThemeType:(ThemeType)themeType {

    UIColor*color = nil;
    
    switch (themeType) {
        case DarkTheme:
            color = [UIColor blackColor];
            break;
        case LightTheme:
            color = [UIColor whiteColor];
            break;
        default:
            break;
    }
    
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: color,NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:18.f]};
    [UINavigationBar appearance].tintColor = color;
    
    _themeType = themeType;
    
}

@end
