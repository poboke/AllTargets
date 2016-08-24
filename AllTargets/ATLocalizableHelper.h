//
//  LocalizableHelper.h
//  AllTargets
//
//  Created by Francisco Javier Trujillo Mata on 06/08/16.
//  Copyright © 2016 Jobs. All rights reserved.
//

#ifndef ATLocalizableHelper_h
#define ATLocalizableHelper_h

#import "AllTargets.h"

#endif /* ATLocalizableHelper_h */

#define ATLocalizedString(key, comment) \
[[AllTargets sharedPlugin].bundle localizedStringForKey:(key) value:@"" table:nil]
