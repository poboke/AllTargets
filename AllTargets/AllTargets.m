//
//  AllTargets.m
//  AllTargets
//
//  Created by Jobs on 15/2/22.
//  Copyright (c) 2015年 Jobs. All rights reserved.
//

#import "AllTargets.h"
#include <objc/runtime.h>

static AllTargets *sharedPlugin;

@interface AllTargets() <NSTableViewDelegate>

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@end

static IMP originalImp = NULL;

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
        
        [self addPluginsMenu];
        
        [self hookMethod];
    }
    
    return self;
}


- (void)addPluginsMenu
{
    // Add Plugins menu next to Window menu
    NSMenu *mainMenu = [NSApp mainMenu];
    NSMenuItem *pluginsMenuItem = [mainMenu itemWithTitle:@"Plugins"];
    if (!pluginsMenuItem) {
        pluginsMenuItem = [[NSMenuItem alloc] init];
        pluginsMenuItem.title = @"Plugins";
        pluginsMenuItem.submenu = [[NSMenu alloc] initWithTitle:pluginsMenuItem.title];
        NSInteger windowIndex = [mainMenu indexOfItemWithTitle:@"Window"];
        [mainMenu insertItem:pluginsMenuItem atIndex:windowIndex];
    }
    
    // Add Subitem
    NSMenuItem *subItem = [[NSMenuItem alloc] init];
    subItem.title = @"Auto Select All Targets";
    subItem.target = self;
    subItem.action = @selector(toggleMenu:);
    subItem.state = NSOnState;
    [pluginsMenuItem.submenu addItem:subItem];
}


- (void)toggleMenu:(NSMenuItem *)menuItem
{
    menuItem.state = !menuItem.state;
    [self hookMethod];
}


- (void)hookMethod
{
    SEL method = @selector(updateTargets);
    
    Class originalClass = NSClassFromString(@"Xcode3TargetMembershipDataSource");
    Method originalMethod = class_getInstanceMethod(originalClass, method);
    originalImp = method_getImplementation(originalMethod);
    
    Class replacedClass = self.class;
    Method replacedMethod = class_getInstanceMethod(replacedClass, method);
    method_exchangeImplementations(originalMethod, replacedMethod);
}


- (void)updateTargets
{
    // We first call the original method
    originalImp();
    
    // Run our custom code
    NSMutableArray *wrappedTargets = [self valueForKey:@"wrappedTargets"];
    for (id wrappedTarget in wrappedTargets) {
        [wrappedTarget setValue:@YES forKey:@"selected"];
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end










