/**
 * WWTimerManager class - WorkWork timer manager.
 *
 * File: WWTimerManager.mm
 * Created by: faku99 <faku99dev@gmail.com>
 * Created on: 03.01.2016
 */

#import <UIKit2/UIApplication.h>
#import <UIKit2/UIScreen.h>

#import "WWTimerManager.h"

#define SUITE   @"com.faku99.workwork"

@interface WWTimerManager ()

// Here we need a boolean 'hasBeenFired' to know if the _timer has been fired (v0.0.2 fix).
// Don't ask me why but when I called [_timer isValid], it made the app crash.
@property (nonatomic, retain) UIApplication *currentApp;
@property (nonatomic, retain) NSUserDefaults *defaults;
@property (nonatomic, assign) BOOL hasBeenFired;
@property (nonatomic, retain) NSTimer *timer;

@end

// Variable used to implement a shared instance.
static WWTimerManager *sharedInstance = nil;

@implementation WWTimerManager

+(WWTimerManager *)sharedInstance {
    // If no instance already exists, we create one. Else, if use the existing one.
    if(!sharedInstance)
        sharedInstance = [[self alloc] init];

    return sharedInstance;
}

-(WWTimerManager *)init {
    self = [super init];

    if(self) {
        // We initialize properties.
        _defaults = [[NSUserDefaults alloc] initWithSuiteName:SUITE];
        _hasBeenFired = false;
        _timer = nil;

        // We have to do this in case user settings have not been set (i.e. first launch).
        [_defaults registerDefaults:@{
            @"timeInterval": @(kDefaultTimeInterval)
        }];
    }

    return self;
}

-(void)dealloc {
    // Sanity.
    _timer = nil;

    [super dealloc];
}

-(void)didEnterBackground:(UIApplication *)app {
    // If the timer has already been fired, we do nothing.
    if(_hasBeenFired)
        return;

    // Else, we cancel the timer.
    [_timer invalidate];
}

-(void)handleTimer:(NSTimer *)timer {
    // We retrieve user settings values for alert.
    // TODO: Implement.
    NSString *title = @"WorkWork!";
    NSString *message = [_currentApp displayIdentifier];
    NSString *OK = @"OK";

    // Declare the alert controller.
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:OK style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];

    // We retrieve the current application window so we can display the alert.
    UIViewController *controller = [[[UIScreen mainScreen] _preferredFocusedWindow] rootViewController];
    [controller presentViewController:alert animated:YES completion:nil];

    // We save the fact that the timer has been fired and we set it to 'nil'.
    _hasBeenFired = true;
    _timer = nil;
}

-(void)hasBecomeActive:(UIApplication *)app {
    // We set '_hasBeenFired' to false even if it shouldn't be necessary.
    _currentApp = app;
    _hasBeenFired = false;

    NSTimeInterval timeInterval = [[_defaults objectForKey:kTimeInterval] doubleValue];

    // We initialize the timer.
    _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleTimer:) userInfo:nil repeats:NO];
}

@end
