//
//  NSMutableDictionary+daoFollowToDNC.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import UIKit;

@class DAOFollow;

@interface NSMutableDictionary (daoFollowToDNC)

+ (instancetype)daoFollowToDNC:(DAOFollow*)object;
- (instancetype)daoFollowToDNC:(DAOFollow*)object;

@end
