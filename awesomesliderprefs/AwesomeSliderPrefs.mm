#import <Preferences/Preferences.h>

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
-(void)save
{
	[self.view endEditing:YES];
}
@end

// vim:ft=objc
