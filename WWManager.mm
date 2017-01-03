#import <UIKit2/UIApplication.h>

#import "WWManager.h"

@interface WWManager () {
    NSTimer *_timer;
}

@end

@implementation WWManager

+(WWManager *)sharedInstance {
    static dispatch_once_t pred;
    static WWManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[WWManager alloc] init];
    });

    return sharedInstance;
}

-(WWManager *)init {
    self = [super init];

    if(self) {
        _timer = nil;
    }

    return self;
}

-(void)didEnterBackground:(UIApplication *)app {
    NSLog(@"[WWManager] didEnterBackground: %@", [app displayIdentifier]);

    [_timer invalidate];
    _timer = nil;
}

-(void)handleTimer:(NSTimer *)timer {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WorkWork!" message:@"Lazy peon!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];

    // We retrieve the current application window so we can display the alert.
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

-(void)hasBecomeActive:(UIApplication *)app {
    NSString *identifier = [app displayIdentifier];

    // We have to check that a timer isn't added for SpringBoard otherwise it will crash.
    if([identifier isEqualToString:@"com.apple.springboard"])
        return;

    NSLog(@"[WWManager] Starting timer for <%@>", [app displayIdentifier]);

    _timer = [NSTimer scheduledTimerWithTimeInterval:300.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:NO];
}

@end
