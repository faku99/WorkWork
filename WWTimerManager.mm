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

@interface WWTimerManager ()

@property (nonatomic, assign) BOOL hasBeenFired;
@property (nonatomic, retain) NSTimer *timer;

@end

static WWTimerManager *sharedInstance = nil;

@implementation WWTimerManager

+(WWTimerManager *)sharedInstance {
    if(!sharedInstance)
        sharedInstance = [[self alloc] init];

    return sharedInstance;
}

-(WWTimerManager *)init {
    self = [super init];

    if(self) {
        _hasBeenFired = false;
        _timer = nil;
    }

    return self;
}

-(void)dealloc {
    _timer = nil;

    [super dealloc];
}

-(void)didEnterBackground:(UIApplication *)app {
    if(_hasBeenFired)
        return;

    [_timer invalidate];
}

-(void)handleTimer:(NSTimer *)timer {
    _hasBeenFired = true;
    _timer = nil;

    NSString *title = @"WorkWork!";
    NSString *message = @"Lazy peon!";

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];

    // We retrieve the current application window so we can display the alert.
    UIViewController *controller = [[[UIScreen mainScreen] _preferredFocusedWindow] rootViewController];
    [controller presentViewController:alert animated:YES completion:nil];
}

-(void)hasBecomeActive:(UIApplication *)app {
    _hasBeenFired = false;
    _timer = [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:NO];
}

@end
