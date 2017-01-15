//
//  NSMutableDictionary+daoCategoryToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOCategory;

@interface NSMutableDictionary (daoCategoryToDNC)

+ (instancetype)daoCategoryToDNC:(DAOCategory*)object;
- (instancetype)daoCategoryToDNC:(DAOCategory*)object;

@end
