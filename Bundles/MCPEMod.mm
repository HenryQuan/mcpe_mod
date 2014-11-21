#import <Preferences/Preferences.h>
#import <Preferences/PSSwitchTableCell.h>
#import <SKListControllerProtocol.h>

@interface MCPEModListController: PSListController {
}
@end

@implementation MCPEModListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"MCPEMod" target:self] retain];
	}
	return _specifiers;
}

-(void) luckyDraw
{
system("killall -9 SpringBoard");
}

-(void) visit82Flex
{
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apt.82flex.com"]];
}

-(void) showID
{
// I find a better website to find ID
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://minecraft-ids.grahamedgecombe.com/"]];
}

-(void) showTutorial
{
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://bbs.feng.com/forum.php?mod=viewthread&tid=8530379"]];
}

-(void) showSourceCode
{
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/HenryQuan/MCPEMod"]];
}

@end

@interface SRSwitchTableCell : PSSwitchTableCell
@end
 
@implementation SRSwitchTableCell
 
-(id)initWithStyle:(int)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3 
{
self = [super initWithStyle:arg1 reuseIdentifier:arg2 specifier:arg3];

if (self)
{
NSString* systemString = [UIDevice currentDevice].systemVersion;
int system = [systemString intValue];
// The green frame looks nice on IOS 7/8 but terrible on IOS 5/6
if (system >= 7)
{
UIColor *defaultGreen = [UIColor colorWithRed:76/255.0f green:217/255.0f blue:100/255.0f alpha:1.0f];
[((UISwitch *)[self control]) setOnTintColor:defaultGreen];
[((UISwitch *)[self control]) setTintColor:defaultGreen];
}
}

return self;
}
 
@end
