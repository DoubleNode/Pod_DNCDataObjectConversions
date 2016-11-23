//
//  NSMutableDictionary+daoLocationToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOLocation;

@interface NSMutableDictionary (daoLocationToDNC)

+ (instancetype)daoLocationToDNC:(DAOLocation*)object;
- (instancetype)daoLocationToDNC:(DAOLocation*)object;

@end
