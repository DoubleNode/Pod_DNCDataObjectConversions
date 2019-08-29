//
//  DAOTransaction+dncToDAO.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

#import <DNCDataObjects/DAOTransaction.h>

@class DAOCategory;
@class DAOContact;
@class DAOItem;
@class DAOLocation;
@class DAOOrder;
@class DAOPaymentAccount;

@interface DAOTransaction (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOCategory*)createCategory;
+ (DAOContact*)createContact;
+ (DAOItem*)createItem;
+ (DAOLocation*)createLocation;
+ (DAOOrder*)createOrder;
+ (DAOPaymentAccount*)createPaymentAccount;
+ (DAOUser*)createUser;

@end
