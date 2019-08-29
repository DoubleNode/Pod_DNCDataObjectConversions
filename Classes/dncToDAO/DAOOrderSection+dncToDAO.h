//
//  DAOOrderSection+dncToDAO.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCDataObjects;

@class DAOCategory;
@class DAOItem;
@class DAOLineitem;
@class DAOLocation;
@class DAOOrder;

@interface DAOOrderSection (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOCategory*)createCategory;
+ (DAOItem*)createItem;
+ (DAOLineitem*)createLineitem;
+ (DAOLocation*)createLocation;
+ (DAOOrder*)createOrder;
+ (DAOUser*)createUser;

@end
