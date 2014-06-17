//
//  Weather.h
//  WeatherApp
//
//  Created by Admin on 16.06.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
// Place and time
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *country;

@property (nonatomic) CGFloat latitude;
@property (nonatomic) CGFloat longitude;
@property (nonatomic, copy, readonly) NSDate *reportTime;
@property (nonatomic, copy, readonly) NSDate *sunrise;
@property (nonatomic, copy, readonly) NSDate *sunset;

// Qualitative
@property (nonatomic, copy, readonly) NSArray *conditions;
@property (nonatomic, copy, readonly) NSMutableArray *ArrayTempCurrent;
@property (nonatomic, copy, readonly) NSMutableArray *ArrayData;
// Quantitative
@property (nonatomic, readonly) NSInteger idCity;
@property (nonatomic, readonly) NSInteger cloudCover;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger pressure;
@property (nonatomic, readonly) NSInteger rain3hours;
@property (nonatomic, readonly) NSInteger snow3hours;
@property (nonatomic, readonly) CGFloat tempCurrent;
@property (nonatomic, readonly) CGFloat tempMin;
@property (nonatomic, readonly) CGFloat tempMax;
@property (nonatomic, readonly) NSInteger windDirection;
@property (nonatomic, readonly) CGFloat windSpeed;

// Methods
// =======

- (void)getCurrent:(NSString *)query : (int) var;

@end
