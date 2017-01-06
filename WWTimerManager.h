/**
 * WWTimerManager class - WorkWork timer manager.
 *
 * File: WWTimerManager.h
 * Created by: faku99 <faku99dev@gmail.com>
 * Created on: 03.01.2016
 */

@interface WWTimerManager : NSObject

+(WWTimerManager *)sharedInstance;

-(WWTimerManager *)init;

-(void)dealloc;
-(void)didEnterBackground:(UIApplication *)app;
-(void)handleTimer:(NSTimer *)timer;
-(void)hasBecomeActive:(UIApplication *)app;

@end
