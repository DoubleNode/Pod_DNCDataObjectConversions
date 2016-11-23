//
//  NSMutableDictionary+daoWishlistToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOWishlist;

@interface NSMutableDictionary (daoWishlistToDNC)

+ (instancetype)daoWishlistToDNC:(DAOWishlist*)object;
- (instancetype)daoWishlistToDNC:(DAOWishlist*)object;

@end
