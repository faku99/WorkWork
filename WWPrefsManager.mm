/**
 * WWPrefsManager class - WorkWork settings manager.
 *
 * File: WWPrefsManager.mm
 * Created by: faku99 <faku99dev@gmail.com>
 * Created on: 06.01.2016
 */

#import "WWPrefsManager.h"

#define SUITE   @"com.faku99.workwork"

@interface WWPrefsManager ()

@property (nonatomic, retain) NSUserDefaults *defaults;

@end

static WWPrefsManager *sharedManager;

@implementation WWPrefsManager

+(WWPrefsManager *)sharedManager {
    if(!sharedManager)
        sharedManager = [[self alloc] init];

    return sharedManager;
}

-(WWPrefsManager *)init {
    self = [super init];

    if(self) {
        _defaults = [[NSUserDefaults alloc] initWithSuiteName:SUITE];

        // We have to do this in case user settings have not been set (i.e. first launch).
        [_defaults registerDefaults:@{
            kTimeInterval: @(kDefaultTimeInterval)
        }];
    }

    return self;
}

-(double)timeInterval {
    return [[_defaults valueForKey:kTimeInterval] doubleValue];
}


@end
