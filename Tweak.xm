/**
 * WorkWork! - Stay productive.
 * Based on /u/ThatGuyEveryoneLikes reddit post (https://redd.it/5ln9iq)
 *
 * File: Tweak.xm
 * Created by: faku99 <faku99dev@gmail.com>
 * Created on: 03.01.2016
 */

#import "WWTimerManager.h"

static id _activeObserver = nil;
static id _backgroundObserver = nil;

%ctor {
	_activeObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
            if(![[notification.object class] isSubclassOfClass:[%c(UIApplication) class]])
                return;

            UIApplication *app = (UIApplication *)notification.object;
            [[%c(WWTimerManager) sharedInstance] hasBecomeActive:app];
		}
	];

    _backgroundObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
            if(![[notification.object class] isSubclassOfClass:[%c(UIApplication) class]])
                return;

            UIApplication *app = (UIApplication *)notification.object;
            [[%c(WWTimerManager) sharedInstance] didEnterBackground:app];
		}
	];
}

%dtor {
	[[NSNotificationCenter defaultCenter] removeObserver:_activeObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:_backgroundObserver];
}
