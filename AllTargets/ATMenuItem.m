//
//  ATMenuItem.m
//  AllTargets
//
//  Created by Francisco Trujillo on 22/08/2016.
//  Copyright © 2016 Jobs. All rights reserved.
//

#import "ATMenuItem.h"
#import "Xcode3TargetMembershipDataSource+HookAllTargets.h"
#import "ATLocalizableHelper.h"

@implementation ATMenuItem

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.title = ATLocalizedString(@"ATTargetMenuItem::AutoSelectTargets", nil);
        self.submenu = [self subMenu];
    }
    
    return self;
}

- (NSMenu *)subMenu
{
    NSMenu *subMenu = [[NSMenu alloc] init];
    [subMenu addItem:[self selectAll]];
    [subMenu addItem:[self separator]];
    [subMenu addItem:[self selectApps]];
    [subMenu addItem:[self selectExtensions]];
    [subMenu addItem:[self selectTest]];
    
    return subMenu;
}

- (NSMenuItem *)selectAll
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = ATLocalizedString(@"ATTargetMenuItem::AllTargets", nil);
    menuItem.target = self;
    menuItem.action = @selector(toggleSelectAllMenu:);
    menuItem.state = NSOnState;
    
    return menuItem;
}

- (NSMenuItem *)separator
{
    return [NSMenuItem separatorItem];
}

- (NSMenuItem *)selectApps
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = ATLocalizedString(@"ATTargetMenuItem::AppTargets", nil);
    
    return menuItem;
}

- (NSMenuItem *)selectExtensions
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = ATLocalizedString(@"ATTargetMenuItem::ExtensionTargets", nil);
    
    return menuItem;
}

- (NSMenuItem *)selectTest
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = ATLocalizedString(@"ATTargetMenuItem::TestTargets", nil);
    
    return menuItem;
}

- (void)toggleSelectAllMenu:(NSMenuItem *)menuItem
{
//    menuItem.state = !menuItem.state;
    [Xcode3TargetMembershipDataSource hookAllTargets];
}

@end
