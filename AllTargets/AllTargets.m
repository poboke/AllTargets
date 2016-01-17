//
//  AllTargets.m
//  AllTargets
//
//  Created by Jobs on 15/2/22.
//  Copyright (c) 2015年 Jobs. All rights reserved.
//

#import "AllTargets.h"
#import "Xcode3TargetMembershipDataSource+Hook.h"

static AllTargets *sharedPlugin;

@interface AllTargets() <NSTableViewDelegate>

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@end


@implementation AllTargets

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}


+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}


- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        
        // Reference to plugin's bundle, for resource access
        self.bundle = plugin;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPluginsMenu) name:NSMenuDidChangeItemNotification object:nil];
        
        [Xcode3TargetMembershipDataSource hookAllTargets];
    }
    
    return self;
}


- (void)addPluginsMenu
{
    NSMenu *mainMenu = [NSApp mainMenu];
    if (!mainMenu) {
        return;
    }
    
    // Add Plugins menu next to Window menu
    NSMenuItem *pluginsMenuItem = [mainMenu itemWithTitle:@"Plugins"];
    if (!pluginsMenuItem) {
        pluginsMenuItem = [[NSMenuItem alloc] init];
        pluginsMenuItem.title = @"Plugins";
        pluginsMenuItem.submenu = [[NSMenu alloc] initWithTitle:pluginsMenuItem.title];
        NSInteger windowIndex = [mainMenu indexOfItemWithTitle:@"Window"];
        [mainMenu insertItem:pluginsMenuItem atIndex:windowIndex];
    }
    
    // Add Subitem
    NSMenuItem *subMenuItem = [[NSMenuItem alloc] init];
    subMenuItem.title = @"Auto Select All Targets";
    subMenuItem.target = self;
    subMenuItem.action = @selector(toggleMenu:);
    subMenuItem.state = NSOnState;
    [pluginsMenuItem.submenu addItem:subMenuItem];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMenuDidChangeItemNotification object:nil];
}


- (void)toggleMenu:(NSMenuItem *)menuItem
{
    menuItem.state = !menuItem.state;
    [Xcode3TargetMembershipDataSource hookAllTargets];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end










