//
//  NSMutableDictionary+daoFollowToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOFollow;

@interface NSMutableDictionary (daoFollowToDNC)

+ (instancetype)daoFollowToDNC:(DAOFollow*)object;
- (instancetype)daoFollowToDNC:(DAOFollow*)object;

@end
