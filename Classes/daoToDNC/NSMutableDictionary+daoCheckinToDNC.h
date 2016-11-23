//
//  NSMutableDictionary+daoCheckinToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOCheckin;

@interface NSMutableDictionary (daoCheckinToDNC)

+ (instancetype)daoCheckinToDNC:(DAOCheckin*)object;
- (instancetype)daoCheckinToDNC:(DAOCheckin*)object;

@end
