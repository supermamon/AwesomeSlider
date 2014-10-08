//still need to find out how to take out the glint

// Default values
static BOOL bHideGlint = NO;
static BOOL bHideChevron = NO;
static BOOL bUseCustomText = YES; 
static NSString* sCustomText = @"Awesome!";
//------------------------------------------------------------------------------
%hook _UIGlintyStringView
- (id)chevron {
	if (bHideChevron) {return nil;} 
	else {return %orig;}
}
-(void)layoutSubviews
{
	//if(bHideGlint) {[self setAlpha:0.0];} 
	%orig;
}
%end
//------------------------------------------------------------------------------
%hook SBFGlintyStringView
-(int)chevronStyle {  
	if (bHideChevron) {return 0;} 
	else {return %orig;}
}
 -(void)setChevronStyle:(int) style {
	if (bHideChevron) {style = 0;}
    %orig(style);
}
%end
//------------------------------------------------------------------------------
%hook SBFGlintyStringSettings
-(float)speed
{
	if(bHideGlint) {return 999;}  //does not work
	else {return(%orig);}
}
%end
//------------------------------------------------------------------------------
%hook SBLockScreenView
- (void)setCustomSlideToUnlockText:(id)arg1
{
    if(bUseCustomText && sCustomText)
    {
        arg1 = sCustomText;
		%orig(arg1);
    } else {
		%orig;
	}
}
%end
//------------------------------------------------------------------------------
static void loadPrefs()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.supermamon.awesomesliderprefs.plist"];
    if(prefs)
    {
		bHideChevron   = ( [prefs objectForKey:@"bHideChevron"]   ? [[prefs objectForKey:@"bHideChevron"]   boolValue] : bHideChevron );
		bHideGlint     = ( [prefs objectForKey:@"bHideGlint"]     ? [[prefs objectForKey:@"bHideGlint"]     boolValue] : bHideGlint );
		bUseCustomText = ( [prefs objectForKey:@"bUseCustomText"] ? [[prefs objectForKey:@"bUseCustomText"] boolValue] : bUseCustomText );
        sCustomText    = ( [prefs objectForKey:@"sCustomText"]    ? [prefs objectForKey:@"sCustomText"]                : sCustomText );
        [sCustomText retain];
    }
    [prefs release];
}

%ctor 
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.supermamon.awesomesliderprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}