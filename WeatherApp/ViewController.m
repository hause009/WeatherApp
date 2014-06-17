//
//  ViewController.m
//  WeatherApp
//
//  Created by Admin on 16.06.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"
#import "WeatherInfo.h"
#import "Info7days.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
{
    Weather *theWeather1;
    Weather *theWeather2;
    Weather *theWeather3;
    Weather *theWeather4;
    AppDelegate * delegat;
}
@synthesize FirstCity,SecondCity,ThirdCity;
@synthesize ViewInfo, ViewCreat;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ViewCreat.frame = CGRectMake(-320, 60, 320, 60);
    
    theWeather1 = [[Weather alloc] init];
    theWeather2 = [[Weather alloc] init];
    theWeather3 = [[Weather alloc] init];
    
    delegat = [[UIApplication sharedApplication]delegate];
    
    [self Restart:nil];
    
    NSLog(@"%@",[delegat.userDefaults objectForKey:@"name"]);
    if ([delegat.userDefaults objectForKey:@"name"])
    {
        
        [self CreatView:[delegat.userDefaults objectForKey:@"name"]];
    }
    else
    {
        ViewInfo.frame = CGRectMake(0, 60, 320, 222);
    }
}

-(void)Restart:(id)sender
{
    theWeather1 = [self PushInfo:theWeather1 :@"Moscow"];
    theWeather2 = [self PushInfo:theWeather2 :@"Saint-Petersburg"];
}

-(void)ShowText
{
    FirstCity.text = [NSString stringWithFormat:@"Temperature in Moscow: %2.1f C",theWeather1.tempCurrent];
    SecondCity.text = [NSString stringWithFormat:@"Temperature in Saint-Petersburg: %2.1f C",theWeather2.tempCurrent];
    ThirdCity.text = [NSString stringWithFormat:@"Temperature in %@: %2.1f C",theWeather3.city,theWeather3.tempCurrent];
}

-(IBAction)Fest:(id)sender
{
    [self PushInfo:theWeather1];
}

-(IBAction)Second:(id)sender
{
    [self PushInfo:theWeather2];
}

-(IBAction)Thir:(id)sender
{
    [self PushInfo:theWeather3];
}

-(void)PushInfo:(Weather*)Obj
{
    if (Obj) {
    UIStoryboard * storyboard = self.storyboard;
    WeatherInfo * vc= [storyboard instantiateViewControllerWithIdentifier:@"WeatherInfo"];
    vc.NameStr = [NSString stringWithFormat:@"%@",Obj.city];
    vc.InfoStr = [NSString stringWithFormat:
                    @"Weather in %@:\n"
                    @"Description: %@\n"
                    @"Current temp: %2.1f C\n"
                    @"High: %2.1f C\n"
                    @"Low: %2.1f C\n"
                    @"Humidity: %d \n"
                    @"Pressure: %d \n"
                  ,
                    Obj.city,
                    Obj.conditions[0][@"description"],
                    Obj.tempCurrent,
                    Obj.tempMax,
                    Obj.tempMin,
                    Obj.humidity,
                    Obj.pressure

                    ];
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}

-(IBAction)FestDay:(id)sender
{
    [self PushDays:theWeather1.idCity];
}


-(IBAction)SecondDay:(id)sender
{
    [self PushDays:theWeather2.idCity];
}

-(IBAction)ThirdDay:(id)sender
{
    [self PushDays:theWeather3.idCity];
}

-(void)PushDays:(NSInteger)idCity
{
    if (idCity) {
        UIStoryboard * storyboard = self.storyboard;
        Info7days * vc= [storyboard instantiateViewControllerWithIdentifier:@"Info7days"];
        vc.idCity = idCity;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)ButtonPressed:(id)sender
{
    theWeather4 = [[Weather alloc] init];
    
    NSString * str = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@",self.locationTextField.text];
    [theWeather4 getCurrent:str :1];
    
    NSString *report = [NSString stringWithFormat:
                        @"Weather in %@:\n"
                        @"%@\n"
                        @"Current temp.: %2.1f C\n"
                        @"High: %2.1f C\n"
                        @"Low: %2.1f C\n",
                        theWeather4.city,
                        theWeather4.conditions[0][@"description"],
                        theWeather4.tempCurrent,
                        theWeather4.tempMax,
                        theWeather4.tempMin
                        ];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Weather"
                                                    message:report
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:@"Add",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
        if (buttonIndex == 0) {
            
        }
        else if (buttonIndex == 1) {

            [delegat.userDefaults setObject:theWeather4.city forKey:@"name"];
            [self CreatView:[delegat.userDefaults objectForKey:@"name"]];
        }
    NSLog(@"%@",[delegat.userDefaults objectForKey:@"name"]);
}

-(Weather *)PushInfo:(Weather*)Object : (NSString*)String
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString * str = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@", String];
        [Object getCurrent:str :1];
        
        dispatch_sync(dispatch_get_main_queue(), ^{

            [self ShowText];
        });
        
    });
    return Object;
}

-(void)CreatView:(NSString*)String
{
    theWeather3 = [self PushInfo:theWeather3 :String];
    
    ViewCreat.frame = CGRectMake(0, 60, 320, 60);
    ViewInfo.frame = CGRectMake(0, ViewCreat.frame.origin.y+ViewCreat.frame.size.height, 320, 222);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
