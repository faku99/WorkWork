#import <Social/Social.h>

#import "../WWTimerManager.h"
#import "WWPRootListController.h"

#define BUNDLE_PATH @"/Library/PreferenceBundles/WWPrefs.bundle"

@implementation WWPRootListController

-(void)email {
	NSString *subject = [NSString stringWithFormat:@"WorkWork! Support"];
	NSString *mail = [NSString stringWithFormat:@"faku99dev@gmail.com"];
	NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];

	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"mailto:?to=%@&subject=%@", [mail stringByAddingPercentEncodingWithAllowedCharacters:set], [subject stringByAddingPercentEncodingWithAllowedCharacters:set]]];

	[[UIApplication sharedApplication] openURL:url];

	[url release];
}

// Pragmas are here because 'system()' is deprecated since iOS 8.0.
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-(void)killBackboardd {
    // Is there a nicer way to do that ?
    NSString *title = @"Warning";
    NSString *message = @"Do you want to respring your device ?";
    NSString *no = @"No";
    NSString *yes = @"Yes";

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:no style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:yes style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        system("killall -9 backboardd");
    }];
    [alert addAction:noAction];
    [alert addAction:yesAction];

    [[self parentViewController] presentViewController:alert animated:YES completion:nil];
}
#pragma GCC diagnostic pop

-(void)paypal {
	NSURL *url = [[NSURL alloc] initWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=PJPUWDWLQAJRC&lc=US&item_name=faku99%20development&item_number=Goodges&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted"];

	[[UIApplication sharedApplication] openURL:url];

	[url release];
}

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)tweet {
	if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
  	SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
	[tweetSheet setInitialText:@"Thanks to #WorkWork from @faku99dev, I can finally get off of Twitter!"];
    [self presentViewController:tweetSheet animated:YES completion:nil];
  }
}

-(void)twitter {
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/faku99dev"]];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=faku99dev"]];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=faku99dev"]];
	} else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/faku99dev"]];
	}
}

-(void)viewDidLoad {
	[super viewDidLoad];

    NSBundle *bundle = [NSBundle bundleWithPath:BUNDLE_PATH];

	UIImage *heartNorm = [UIImage imageNamed:@"images/heart" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImage *heartHigh = [UIImage imageNamed:@"images/heart_filled" inBundle:bundle compatibleWithTraitCollection:nil];

    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(0, 13, 22, 22)];
    [shareButton setImage:heartNorm forState:UIControlStateNormal];
    [shareButton setImage:heartHigh forState:UIControlStateHighlighted];
 	[shareButton addTarget:self action:@selector(tweet) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:shareButton] autorelease];
}

-(void)viewWillDisappear:(BOOL)arg1 {
	[self.view endEditing:YES];

    [super viewWillDisappear:arg1];
}

-(void)_returnKeyPressed:(id)arg1 {
	[self.view endEditing:YES];

	[super _returnKeyPressed:arg1];
}

@end
