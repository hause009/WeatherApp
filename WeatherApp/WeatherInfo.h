//
//  WeatherInfo.h
//  WeatherApp
//
//  Created by Admin on 16.06.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherInfo : UIViewController
@property NSString * NameStr;
@property NSString * InfoStr;
@property IBOutlet UILabel * Name;
@property IBOutlet UILabel * Info;

@end
