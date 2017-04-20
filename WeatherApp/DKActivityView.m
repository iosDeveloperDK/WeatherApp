//
//  DKActivityView.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKActivityView.h"

@interface DKActivityView ()

{
    UIActivityIndicatorView* activity;
}

@end

@implementation DKActivityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.hidden = YES;
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        
        activity = [[UIActivityIndicatorView alloc]initWithFrame:self.frame];
        
        [self addSubview:activity];

        
    }
    return self;
}

-(void)startActivity {

    self.hidden = NO;
    
    [activity startAnimating];
    
}

-(void)stopActivity {
    
    self.hidden = YES;
    
    [activity stopAnimating];
    
}

@end
