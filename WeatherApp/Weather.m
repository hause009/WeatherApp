//
//  Weather.m
//  WeatherApp
//
//  Created by Admin on 16.06.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Weather.h"
#import "SBJson.h"

@implementation Weather{
    NSDictionary *weatherServiceResponse;
}

- (id)init
{
    self = [super init];
    
    weatherServiceResponse = @{};
    
    return self;
}

- (void)getCurrent:(NSString *)query :(int)var
{
    NSURL *url = [NSURL URLWithString:query];
    
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    theRequest.HTTPMethod = @"GET";
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse* response;
    NSError* error;
    
    NSData * Data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    NSString *result = [[NSString alloc]initWithData:Data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
    SBJsonParser *jsonParser = [[SBJsonParser alloc]init];
    weatherServiceResponse = [jsonParser objectWithString:result error:NULL];
    
    if (var == 1)
    {
        [self parseWeatherServiceResponse];
    }
   else if (var == 2)
   {
       [self parseWeatherServiceResponse2];
   }
}

- (void)parseWeatherServiceResponse
{
    // clouds
    _cloudCover = [weatherServiceResponse[@"clouds"][@"all"] integerValue];
    
    // coord
    _latitude = [weatherServiceResponse[@"coord"][@"lat"] doubleValue];
    _longitude = [weatherServiceResponse[@"coord"][@"lon"] doubleValue];
    
    // dt
    _reportTime = [NSDate dateWithTimeIntervalSince1970:[weatherServiceResponse[@"dt"] doubleValue]];
    
    // main
    _humidity = [weatherServiceResponse[@"main"][@"humidity"] integerValue];
    _pressure = [weatherServiceResponse[@"main"][@"pressure"] integerValue];
    _tempCurrent = [Weather kelvinToCelsius:[weatherServiceResponse[@"main"][@"temp"] integerValue]];
    _tempMin = [Weather kelvinToCelsius:[weatherServiceResponse[@"main"][@"temp_min"] doubleValue]];
    _tempMax = [Weather kelvinToCelsius:[weatherServiceResponse[@"main"][@"temp_max"] doubleValue]];
    
    // name
    _city = weatherServiceResponse[@"name"];
    
    // id
    _idCity = [weatherServiceResponse[@"id"] integerValue];
    
    // rain
    _rain3hours = [weatherServiceResponse[@"rain"][@"3h"] integerValue];
    
    // snow
    _snow3hours = [weatherServiceResponse[@"snow"][@"3h"] integerValue];
    
    // sys
    _country = weatherServiceResponse[@"sys"][@"country"];
    _sunrise = [NSDate dateWithTimeIntervalSince1970:[weatherServiceResponse[@"sys"][@"sunrise"] doubleValue]];
    _sunset = [NSDate dateWithTimeIntervalSince1970:[weatherServiceResponse[@"sys"][@"sunset"] doubleValue]];
    
    // weather
    _conditions = weatherServiceResponse[@"weather"];

    // wind
    _windDirection = [weatherServiceResponse[@"wind"][@"dir"] integerValue];
    _windSpeed = [weatherServiceResponse[@"wind"][@"speed"] doubleValue];
}

- (void)parseWeatherServiceResponse2
{
    // name
    _city = weatherServiceResponse[@"city"][@"name"];
    
    // temp
    NSArray * array1 = weatherServiceResponse[@"list"];
    NSDictionary * dic = [NSDictionary new];
    _ArrayTempCurrent = [NSMutableArray new];
    _ArrayData = [NSMutableArray new];
    for (int i = 0; i<[array1 count]; i++) {
        
        NSDictionary * undMitems = [array1 objectAtIndex:i];
        dic = undMitems [@"temp"];
        NSInteger temp = [Weather kelvinToCelsius:[dic [@"day"]doubleValue]];
        NSString * str = [NSString stringWithFormat:@"%d C",temp];
        [_ArrayTempCurrent addObject:str];
  
        // dt
        _reportTime = [NSDate dateWithTimeIntervalSince1970:[array1[i][@"dt"] doubleValue]];
        NSString * str2 = [NSString stringWithFormat:@"%@",_reportTime];
        [_ArrayData addObject:str2];
    }
}

+ (double)kelvinToCelsius:(double)degreesKelvin
{
    const double ZERO_CELSIUS_IN_KELVIN = 273.15;
    return degreesKelvin - ZERO_CELSIUS_IN_KELVIN;
}


@end
