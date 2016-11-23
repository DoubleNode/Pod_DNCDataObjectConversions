//
//  NSMutableDictionary+daoPhotoToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOPhoto;

@interface NSMutableDictionary (daoPhotoToDNC)

+ (instancetype)daoPhotoToDNC:(DAOPhoto*)object;
- (instancetype)daoPhotoToDNC:(DAOPhoto*)object;

@end
