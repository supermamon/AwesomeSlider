static BOOL ASisEnabled = YES; // Default value
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

static void loadPrefs()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.supermamon.awesomesliderprefs.plist"];
    if(prefs)
    {
        ASisEnabled = ( [prefs objectForKey:@"ASisEnabled"] ? [[prefs objectForKey:@"ASisEnabled"] boolValue] : ASisEnabled );
        AStext = ( [prefs objectForKey:@"AStext"] ? [prefs objectForKey:@"AStext"] : AStext );
        [AStext retain];
    }
    [prefs release];
}

%ctor 
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.supermamon.awesomesliderprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}