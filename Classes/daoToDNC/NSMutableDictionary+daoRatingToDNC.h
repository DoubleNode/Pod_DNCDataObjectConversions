//
//  NSMutableDictionary+daoRatingToDNC.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import UIKit;

@class DAORating;

@interface NSMutableDictionary (daoRatingToDNC)

+ (instancetype)daoRatingToDNC:(DAORating*)object;
- (instancetype)daoRatingToDNC:(DAORating*)object;

@end
