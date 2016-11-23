//
//  NSMutableDictionary+daoUserDeviceToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOUserDevice;

@interface NSMutableDictionary (daoUserDeviceToDNC)

+ (instancetype)daoUserDeviceToDNC:(DAOUserDevice*)object;
- (instancetype)daoUserDeviceToDNC:(DAOUserDevice*)object;

@end
