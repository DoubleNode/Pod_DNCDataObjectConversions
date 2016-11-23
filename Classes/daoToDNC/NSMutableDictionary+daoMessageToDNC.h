//
//  NSMutableDictionary+daoMessageToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOMessage;

@interface NSMutableDictionary (daoMessageToDNC)

+ (instancetype)daoMessageToDNC:(DAOMessage*)object;
- (instancetype)daoMessageToDNC:(DAOMessage*)object;

@end
