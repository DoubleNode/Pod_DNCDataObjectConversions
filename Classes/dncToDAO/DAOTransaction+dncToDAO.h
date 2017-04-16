//
//  DAOTransaction+dncToDAO.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
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
