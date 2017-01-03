/**
 * WorkWork!
 *  Stay productive.
 *  -- Based on /u/ThatGuyEveryoneLikes reddit post (https://redd.it/5ln9iq)
 *
 * Created by: faku99
 * Created on: 03.01.2016
 */

#import "WWManager.h"

static id activeObserver;
static id backgroundObserver;

%ctor {
	activeObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
            if(![[notification.object class] isSubclassOfClass:[%c(UIApplication) class]])
                return;

            UIApplication *app = (UIApplication *)notification.object;
            [[%c(WWManager) sharedInstance] hasBecomeActive:app];
		}
	];

    backgroundObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
            if(![[notification.object class] isSubclassOfClass:[%c(UIApplication) class]])
                return;

            UIApplication *app = (UIApplication *)notification.object;
            [[%c(WWManager) sharedInstance] didEnterBackground:app];
		}
	];
}

%dtor {
	[[NSNotificationCenter defaultCenter] removeObserver:activeObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:backgroundObserver];
}
