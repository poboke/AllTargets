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
#import "ATSavedData.h"

@interface ATMenuItem()

@property (nonatomic, strong) ATSavedData *savedData;
@property (nonatomic, strong) NSArray<NSMenuItem *> *submenuOptions;

@end

@implementation ATMenuItem

- (instancetype)initWithSavedData:(ATSavedData *)savedData
{
    self = [super init];
    
    if (self) {
        _submenuOptions = @[];
        _savedData = savedData;
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
    
    //Add the different options
    self.submenuOptions = @[[self selectApps], [self selectExtensions], [self selectTest]];
    for (NSMenuItem *menuItem in self.submenuOptions) {
        [subMenu addItem:menuItem];
    }
    
    subMenu.autoenablesItems = NO;
    [self enableMenuOptions:!self.savedData.allTargetSelected];
    
    return subMenu;
}

- (NSMenuItem *)selectAll
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = ATLocalizedString(@"ATTargetMenuItem::AllTargets", nil);
    menuItem.target = self;
    menuItem.action = @selector(toggleSelectAllTargetsMenu:);
    menuItem.state = self.savedData.allTargetSelected;
    
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
    menuItem.target = self;
    menuItem.action = @selector(toggleSelectAllAppsMenu:);
    menuItem.state = self.savedData.allAppsSelected;
    
    return menuItem;
}

- (NSMenuItem *)selectExtensions
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = ATLocalizedString(@"ATTargetMenuItem::ExtensionTargets", nil);
    menuItem.target = self;
    menuItem.action = @selector(toggleSelectAllExtensionsMenu:);
    menuItem.state = self.savedData.allExtensionsSelected;
    
    return menuItem;
}

- (NSMenuItem *)selectTest
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = ATLocalizedString(@"ATTargetMenuItem::TestTargets", nil);
    menuItem.target = self;
    menuItem.action = @selector(toggleSelectAllTestsMenu:);
    menuItem.state = self.savedData.allTestsSelected;
    
    return menuItem;
}

- (void)toggleSelectAllTargetsMenu:(NSMenuItem *)menuItem
{
    self.savedData.allTargetSelected = !self.savedData.allTargetSelected;
    menuItem.state = self.savedData.allTargetSelected;
    [self enableMenuOptions:!self.savedData.allTargetSelected];
    [self updateSavedData];
}

- (void)toggleSelectAllAppsMenu:(NSMenuItem *)menuItem
{
    self.savedData.allAppsSelected = !self.savedData.allAppsSelected;
    menuItem.state = self.savedData.allAppsSelected;
    [self updateSavedData];
}

- (void)toggleSelectAllExtensionsMenu:(NSMenuItem *)menuItem
{
    self.savedData.allExtensionsSelected = !self.savedData.allExtensionsSelected;
    menuItem.state = self.savedData.allExtensionsSelected;
    [self updateSavedData];
}

- (void)toggleSelectAllTestsMenu:(NSMenuItem *)menuItem
{
    self.savedData.allTestsSelected = !self.savedData.allTestsSelected;
    menuItem.state = self.savedData.allTestsSelected;
    [self updateSavedData];
}

- (void)enableMenuOptions:(BOOL)enabled
{
    for (NSMenuItem *item in self.submenuOptions) {
        item.enabled = enabled;
    }
}

- (void)updateSavedData
{
    if ([self.delegate respondsToSelector:@selector(menuItem:didUpdateSavedData:)]) {
        [self.delegate menuItem:self didUpdateSavedData:self.savedData];
    }
}

@end
