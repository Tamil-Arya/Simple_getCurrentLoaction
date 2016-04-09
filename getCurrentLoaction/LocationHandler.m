//
//  LocationHandler.m
//  getCurrentLoaction
//
//  Created by Dvios on 09/04/16.
//  Copyright © 2016 Dvois. All rights reserved.
//

#import "LocationHandler.h"
#import <UIKit/UIKit.h>

static LocationHandler *DefaultManager=nil;
@interface LocationHandler()
-(void)initiate;

@end


@implementation LocationHandler
+(id)getSharedInstance
{
    if (!DefaultManager) {
        DefaultManager =[[self allocWithZone:NULL]init];
        [DefaultManager initiate];
    }
    return DefaultManager;
}

//Initialization
-(void)initiate{
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
}

-(void)startUpdating{
    [locationManager startUpdatingLocation];
}
-(void)stopupdaing{
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error){
         NSString *CountryArea;
         if (!(error)) {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
                         
             
             //send the current location & placemark
             if ([self.delegate respondsToSelector:@selector(didUpdateToLocation:GetCurrentAddress:error:)]) {
                 [self.delegate didUpdateToLocation:currentLocation GetCurrentAddress:placemark error:nil];
             }
            
         }
         else
         {
             //send error
             if ([self.delegate respondsToSelector:@selector(didUpdateToLocation:GetCurrentAddress:error:)]) {
                 [self.delegate didUpdateToLocation:nil GetCurrentAddress:nil error:error];
             }
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
             CountryArea = NULL;
         }
            }];
}
@end
