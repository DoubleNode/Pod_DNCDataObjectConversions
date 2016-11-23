//
//  NSMutableDictionary+daoActivityToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOActivity;

@interface NSMutableDictionary (daoActivityToDNC)

+ (instancetype)daoActivityToDNC:(DAOActivity*)object;
- (instancetype)daoActivityToDNC:(DAOActivity*)object;

@end
