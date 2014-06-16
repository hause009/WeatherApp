//
//  WeatherInfo.m
//  WeatherApp
//
//  Created by Admin on 16.06.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "WeatherInfo.h"
#import "Weather.h"

@interface WeatherInfo ()

@end

@implementation WeatherInfo
@synthesize Name, Info;
@synthesize NameStr, InfoStr;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Name.text = NameStr;
    Info.text = InfoStr;
    
    Info.numberOfLines = 0;
    [Info sizeToFit];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
