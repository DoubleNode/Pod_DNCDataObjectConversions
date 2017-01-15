//
//  NSMutableDictionary+daoSocialAccountToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOSocialAccount;

@interface NSMutableDictionary (daoSocialAccountToDNC)

+ (instancetype)daoSocialAccountToDNC:(DAOSocialAccount*)object;
- (instancetype)daoSocialAccountToDNC:(DAOSocialAccount*)object;

@end
