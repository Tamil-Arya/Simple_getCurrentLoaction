//
//  LocationHandler.h
//  getCurrentLoaction
//
//  Created by Dvios on 09/04/16.
//  Copyright © 2016 Dvois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationHandlerDelegate <NSObject>
@required
-(void)didUpdateToLocation:(CLLocation *)CurrentLocation GetCurrentAddress:(CLPlacemark *)placeMark error:(NSError *)errors;
@end

@interface LocationHandler : NSObject<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@property(nonatomic,strong) id<LocationHandlerDelegate>delegate;

+(id)getSharedInstance;
-(void)startUpdating;
-(void)stopupdaing;

@end
