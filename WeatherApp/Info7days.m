//
//  Info7days.m
//  WeatherApp
//
//  Created by Admin on 16.06.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Info7days.h"
#import "Weather.h"
#import "Cell.h"

@interface Info7days ()
{
    Weather *theWeather;
}
@end

@implementation Info7days
@synthesize Table;
@synthesize Name;
@synthesize idCity;
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    theWeather = [[Weather alloc] init];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString * str = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?id=%d",idCity];
        
        [theWeather getCurrent:str :2];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            Name.text = [NSString stringWithFormat:@"%@",theWeather.city];
            //NSLog(@"%@", str);
            [Table reloadData];
            
        });
        
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [theWeather.ArrayTempCurrent count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    Cell *cell = [Table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.Temp.text = [theWeather.ArrayTempCurrent objectAtIndex:indexPath.row];
    cell.Data.text = [theWeather.ArrayData objectAtIndex:indexPath.row];
    
    return cell;
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
