//
//  NSMutableDictionary+daoAuthToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOAuth;

@interface NSMutableDictionary (daoAuthToDNC)

+ (instancetype)daoAuthToDNC:(DAOAuth*)object;
- (instancetype)daoAuthToDNC:(DAOAuth*)object;

@end
