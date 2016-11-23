//
//  NSMutableDictionary+daoRatingToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAORating;

@interface NSMutableDictionary (daoRatingToDNC)

+ (instancetype)daoRatingToDNC:(DAORating*)object;
- (instancetype)daoRatingToDNC:(DAORating*)object;

@end
