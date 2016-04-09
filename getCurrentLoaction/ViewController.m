//
//  ViewController.m
//  getCurrentLoaction
//
//  Created by Dvios on 09/04/16.
//  Copyright © 2016 Dvois. All rights reserved.
//

#import "ViewController.h"
#import "LocationHandler.h"
#import <Foundation/Foundation.h>
@interface ViewController ()<LocationHandlerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *CurrentAddress;
@property (weak, nonatomic) IBOutlet UITextField *Longitude;
@property (weak, nonatomic) IBOutlet UITextField *Latitude;
@property (weak, nonatomic) IBOutlet UITextField *Altitude;
@property (weak, nonatomic) IBOutlet UITextField *Speed;
@property (weak, nonatomic) IBOutlet UIButton *GetCurLocation;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
- (IBAction)GetCurLocation:(id)sender;
@property(nonatomic)UIActivityIndicatorView *ActivityIndicater;
@end

@implementation ViewController
@synthesize Latitude,Longitude,Speed,GetCurLocation,Altitude,ActivityIndicater;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ActivityIndicater=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    ActivityIndicater.center=self.view.center;
    [self.view addSubview:ActivityIndicater];
     self.view.backgroundColor=[UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)didUpdateToLocation:(CLLocation *)CurrentLocation GetCurrentAddress:(CLPlacemark *)placeMark error:(NSError *)errors{
    
    if (errors == nil) {
        Latitude.text=[NSString stringWithFormat:@"Latitude : %8.f",CurrentLocation.coordinate.latitude];
        Longitude.text=[NSString stringWithFormat:@"Longitude : %8.f",CurrentLocation.coordinate.longitude];
        Altitude.text=[NSString stringWithFormat:@"Altitude : %8.f",CurrentLocation.altitude];
        Speed.text=[NSString stringWithFormat:@"Speed : %8.f",CurrentLocation.speed];
        
        /*---- For more results
         :);
         placemark.country);
         placemark.locality);
         placemark.name);
         placemark.ocean);
         placemark.postalCode);
         placemark.subLocality);
         placemark.location);
         ------*/
        NSString *locatedAt = [[placeMark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        NSString *Address = [[NSString alloc]initWithString:locatedAt];
        self.CurrentAddress.text=[NSString stringWithFormat:@"Address : \n%@",Address];
    }
    else {
        NSLog(@"Error :%@",errors);
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"There was an problem while getting to the current location,kindly check your network." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
   
    
}
-(void)stopLoader{
    self.ScrollView.backgroundColor=[UIColor yellowColor];
    self.ScrollView.alpha=1.0;
    [ActivityIndicater stopAnimating];
}

- (IBAction)GetCurLocation:(id)sender {
    self.ScrollView.alpha=0.4;
    self.ScrollView.backgroundColor=[UIColor lightTextColor];
    [ActivityIndicater startAnimating];
    [[LocationHandler getSharedInstance]setDelegate:self];
    [[LocationHandler getSharedInstance]startUpdating];
    [self performSelector:@selector(stopLoader) withObject:nil afterDelay:4.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
