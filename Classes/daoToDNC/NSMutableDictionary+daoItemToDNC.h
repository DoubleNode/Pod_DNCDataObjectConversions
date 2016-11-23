//
//  NSMutableDictionary+daoItemToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOItem;

@interface NSMutableDictionary (daoItemToDNC)

+ (instancetype)daoItemToDNC:(DAOItem*)object;
- (instancetype)daoItemToDNC:(DAOItem*)object;

@end
