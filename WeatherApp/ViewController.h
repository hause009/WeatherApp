//
//  ViewController.h
//  WeatherApp
//
//  Created by Admin on 16.06.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property IBOutlet UITextField *locationTextField;
- (IBAction)ButtonPressed:(id)sender;

@property IBOutlet UILabel * FirstCity;
@property IBOutlet UILabel * SecondCity;

@property IBOutlet UIButton * ButFirst;
@property IBOutlet UIButton * ButSecond;

@end
