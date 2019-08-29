//
//  NSMutableDictionary+daoCategoryToDNC.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import UIKit;

@class DAOCategory;

@interface NSMutableDictionary (daoCategoryToDNC)

+ (instancetype)daoCategoryToDNC:(DAOCategory*)object;
- (instancetype)daoCategoryToDNC:(DAOCategory*)object;

@end
