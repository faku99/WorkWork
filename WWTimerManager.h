/**
 * WWTimerManager - WorkWork timer manager.
 */

@interface WWTimerManager : NSObject

+(WWTimerManager *)sharedInstance;

-(WWTimerManager *)init;

-(void)dealloc;
-(void)didEnterBackground:(UIApplication *)app;
-(void)handleTimer:(NSTimer *)timer;
-(void)hasBecomeActive:(UIApplication *)app;

@end
