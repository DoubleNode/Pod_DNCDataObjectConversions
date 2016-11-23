//
//  NSMutableDictionary+daoNewsToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAONews;

@interface NSMutableDictionary (daoNewsToDNC)

+ (instancetype)daoNewsToDNC:(DAONews*)object;
- (instancetype)daoNewsToDNC:(DAONews*)object;

@end
