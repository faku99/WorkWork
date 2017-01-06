/**
 * WWPrefsManager class - WorkWork settings manager.
 *
 * File: WWPrefsManager.h
 * Created by: faku99 <faku99dev@gmail.com>
 * Created on: 06.01.2016
 */

// Settings key constants.
#define kTimeInterval           @"timeInterval"

// Default settings values.
#define kDefaultTimeInterval    300.0

@interface WWPrefsManager : NSObject

+(WWPrefsManager *)sharedManager;

-(WWPrefsManager *)init;

-(double)timeInterval;

@end
