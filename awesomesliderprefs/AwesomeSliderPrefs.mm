#import <Preferences/Preferences.h>
#import <Foundation/Foundation.h>

#define TWITTER_URL_COUNT 5
static NSString *TWITTER_URL_SCHEMES[TWITTER_URL_COUNT] = {
	@"tweetbot:///user_profile/supermamon",
	@"twitterrific:///profile?screen_name=supermamon",
	@"twitter://user?screen_name=supermamon",
	@"https://twitter.com/supermamon",
	@"http://twitter.com/supermamon",
};

static BOOL open_twitter_url(int index)
{
	if(index >= TWITTER_URL_COUNT) return true;
	UIApplication *app = UIApplication.sharedApplication;
	NSURL *URL = [NSURL URLWithString:TWITTER_URL_SCHEMES[index]];
	if([app canOpenURL:URL])
	{
		[app openURL:URL];
		return true;
	}
	else
	{
		//[[UIAlertView.alloc initWithTitle:@"Can't open Twitter" message:@"Probably because you need to enter your passcode?" delegate:nil cancelButtonTitle:@"Oh, my bad" otherButtonTitles:nil] show];
		return false;
	}
}

@interface AwesomeSliderPrefsListController: PSListController {
}
@end

@implementation AwesomeSliderPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"AwesomeSliderPrefs" target:self] retain];
	}
	return _specifiers;
}
//---------------------------------------------------------------------------------------------------------
-(void)open_www{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.supermamon.com"]];
}
-(void)open_twitter{
	for(int i = 0; !open_twitter_url(i); i++);
}
-(void)donate{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=BPQNBXPYB56HL&lc=US&item_name=Send%20love%20to%20@supermamon&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted"]];
}


@end



// vim:ft=objc
