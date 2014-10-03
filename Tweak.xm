static BOOL ASisEnabled = YES; // Default value
static BOOL ASshowChevron = YES;

static NSString* AStext = @"Slide for Awesomeness";

%hook SBLockScreenView
- (void)setCustomSlideToUnlockText:(id)arg1
{
    if(AStext && ASisEnabled)
    {
        arg1 = AStext;
    }
    %orig(arg1);
}
%end

%hook SBFGlintyStringView
-(void)setChevron:(id)arg1
{
	if(ASshowChevron) {
		%orig(arg1);
	} else {
		%orig(NULL);
	}
}
%end


static void loadPrefs()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.supermamon.awesomesliderprefs.plist"];
    if(prefs)
    {
        ASisEnabled   = ( [prefs objectForKey:@"ASisEnabled"]   ? [[prefs objectForKey:@"ASisEnabled"] boolValue]   : ASisEnabled );
		ASshowChevron = ( [prefs objectForKey:@"ASshowChevron"] ? [[prefs objectForKey:@"ASshowChevron"] boolValue] : ASshowChevron );
		//(id)[ASshowChevron retain];
        AStext        = ( [prefs objectForKey:@"AStext"] ? [prefs objectForKey:@"AStext"] : AStext );
        [AStext retain];
    }
    [prefs release];
}

%ctor 
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.supermamon.awesomesliderprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}