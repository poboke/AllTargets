//
//  LocalizableHelper.h
//  AllTargets
//
//  Created by Francisco Javier Trujillo Mata on 06/08/16.
//  Copyright © 2016 Jobs. All rights reserved.
//

#ifndef LocalizableHelper_h
#define LocalizableHelper_h


#endif /* LocalizableHelper_h */

#define NSPluginLocalizedString(key, comment) \
[[NSBundle bundleWithIdentifier:@"com.poboke.AllTargets"] localizedStringForKey:(key) value:@"" table:nil]
