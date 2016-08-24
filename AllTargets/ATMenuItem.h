//
//  ATMenuItem.h
//  AllTargets
//
//  Created by Francisco Trujillo on 22/08/2016.
//  Copyright © 2016 Jobs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ATSavedData;

@protocol ATMenuItemDelegate;

@interface ATMenuItem : NSMenuItem

@property (nonatomic, weak) id<ATMenuItemDelegate> delegate;

- (instancetype)initWithSavedData:(ATSavedData *)savedData;

@end

@protocol ATMenuItemDelegate <NSObject>

- (void)menuItem:(ATMenuItem *)menuItem didUpdateSavedData:(ATSavedData *)savedData;

@end
