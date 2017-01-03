@interface WWManager : NSObject

+(WWManager *)sharedInstance;

-(WWManager *)init;

-(void)didEnterBackground:(UIApplication *)app;
-(void)handleTimer:(NSTimer *)timer;
-(void)hasBecomeActive:(UIApplication *)app;

@end
