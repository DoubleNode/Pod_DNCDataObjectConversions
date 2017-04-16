//
//  DAOLineitem+dncToDAO.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCDataObjects/DAOLineitem.h>

@class DAOCategory;
@class DAOItem;
@class DAOLocation;
@class DAOOrder;

@interface DAOLineitem (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOCategory*)createCategory;
+ (DAOItem*)createItem;
+ (DAOLocation*)createLocation;
+ (DAOOrder*)createOrder;
+ (DAOUser*)createUser;

@end
