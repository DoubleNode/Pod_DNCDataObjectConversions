//
//  NSMutableDictionary+daoUserToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOUser;

@interface NSMutableDictionary (daoUserToDNC)

+ (instancetype)daoUserToDNC:(DAOUser*)object;
- (instancetype)daoUserToDNC:(DAOUser*)object;

@end
