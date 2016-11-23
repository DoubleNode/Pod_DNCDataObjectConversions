//
//  NSMutableDictionary+daoFavoriteToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOFavorite;

@interface NSMutableDictionary (daoFavoriteToDNC)

+ (instancetype)daoFavoriteToDNC:(DAOFavorite*)object;
- (instancetype)daoFavoriteToDNC:(DAOFavorite*)object;

@end
