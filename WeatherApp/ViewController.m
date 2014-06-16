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

@interface ViewController ()

@end

@implementation ViewController
{
    Weather *theWeather1;
    Weather *theWeather2;
}
@synthesize FirstCity,SecondCity;
@synthesize ButFirst, ButSecond;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    theWeather1 = [[Weather alloc] init];
    theWeather2 = [[Weather alloc] init];
    
    //theWeather = [[Weather alloc] init];
    [self Restart:nil];
}

-(IBAction)Restart:(id)sender
{
   // theWeather1=nil;
    //theWeather2=nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        [theWeather1 getCurrent:@"Moscow"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            FirstCity.text = [NSString stringWithFormat:@"Temperature in Moscow: %2.1f C",theWeather1.tempCurrent];
            
        });
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [theWeather2 getCurrent:@"Saint-Petersburg"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            SecondCity.text = [NSString stringWithFormat:@"Temperature in Saint-Petersburg: %2.1f C",theWeather2.tempCurrent];
            
        });
        
    });
}

-(IBAction)Fest:(id)sender
{
    [self PushInfo:theWeather1];
}


-(IBAction)Second:(id)sender
{
    [self PushInfo:theWeather2];
}

-(void)PushInfo:(Weather*)Obj
{
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

-(IBAction)FestDay:(id)sender
{
    [self PushInfo:theWeather1];
}


-(IBAction)SecondDay:(id)sender
{
    [self PushInfo:theWeather2];
}

-(IBAction)PushDays:(id)sender
{
    UIStoryboard * storyboard = self.storyboard;
    Info7days * vc= [storyboard instantiateViewControllerWithIdentifier:@"Info7days"];
    [self.navigationController presentViewController:vc animated:YES completion:nil];

}


- (IBAction)ButtonPressed:(id)sender
{
    [theWeather1 getCurrent:self.locationTextField.text];
    
    
    NSString *report = [NSString stringWithFormat:
                        @"Weather in %@:\n"
                        @"%@\n"
                        @"Current temp.: %2.1f C\n"
                        @"High: %2.1f C\n"
                        @"Low: %2.1f C\n",
                        theWeather1.city,
                        theWeather1.conditions[0][@"description"],
                        theWeather1.tempCurrent,
                        theWeather1.tempMax,
                        theWeather1.tempMin
                        ];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Weather"
                                                    message:report
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
