//
//  DAOTransaction+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOTransaction+dncToDAO.h"

#import "DAOCategory+dncToDAO.h"
#import "DAOContact+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOOrder+dncToDAO.h"
#import "DAOPaymentAccount+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOTransaction (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOTransaction.transaction dncToDAO:dictionary];
}

+ (DAOCategory*)createCategory
{
    return DAOCategory.category;
}

+ (DAOContact*)createContact
{
    return DAOContact.contact;
}

+ (DAOItem*)createItem
{
    return DAOItem.item;
}

+ (DAOLocation*)createLocation
{
    return DAOLocation.location;
}

+ (DAOOrder*)createOrder
{
    return DAOOrder.order;
}

+ (DAOPaymentAccount*)createPaymentAccount
{
    return DAOPaymentAccount.paymentAccount;
}

+ (DAOUser*)createUser
{
    return DAOUser.user;
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id = [self idFromString:dictionary[@"id"]];

    self.orderId    = [self idFromString:dictionary[@"order_id"]];
    self.order      = self.class.createOrder;   self.order.id = self.orderId;
    
    id  contactData = dictionary[@"contact"];
    if (contactData && (contactData != NSNull.null))
    {
        self.contactId  = [self idFromString:dictionary[@"contact_id"]];
        self.contact    = [self.class.createContact dncToDAO:contactData];
    }
    
    id  paymentAccountData = dictionary[@"paymentaccount"];
    if (paymentAccountData && (paymentAccountData != NSNull.null))
    {
        self.paymentAccountId   = [self idFromString:dictionary[@"paymentaccount_id"]];
        self.paymentAccount     = [self.class.createPaymentAccount dncToDAO:paymentAccountData];
    }

    self.type               = [self stringFromString:dictionary[@"transaction_type"]];
    self.status             = [self stringFromString:dictionary[@"status"]];
    self.authorizationCode  = [self stringFromString:dictionary[@"auth_code"]];
    self.discountCode       = [self stringFromString:dictionary[@"discount_code"]];

    self.subtotal   = [self numberFromString:dictionary[@"subtotal"]];
    self.discount   = [self numberFromString:dictionary[@"discount"]];
    self.tax        = [self numberFromString:dictionary[@"tax"]];
    self.total      = [self numberFromString:dictionary[@"total"]];
    self.data       = [self dictionaryFromJsonString:dictionary[@"data"]];

    self.paymentType    = [self stringFromString:dictionary[@"payment_type"]];
    self.paymentData    = dictionary[@"payment_type"];

    self.chargeAfter    = [self dateFromNumber:dictionary[@"charge_after"]];
    self.holdUntil      = [self dateFromNumber:dictionary[@"hold_until"]];
    self.cancelAfter    = [self dateFromNumber:dictionary[@"cancel_after"]];
    self.charged        = [self dateFromNumber:dictionary[@"charged"]];
    self.captured       = [self dateFromNumber:dictionary[@"captured"]];

    NSString*   type    = [self stringFromString:dictionary[@"type"]];
    if ([type isEqualToString:@"category"])
    {
        self.categoryId = [self idFromString:dictionary[@"type_id"]];
        self.category   = self.class.createCategory;    self.category.id    = self.categoryId;
    }
    else if ([type isEqualToString:@"item"])
    {
        self.itemId = [self idFromString:dictionary[@"type_id"]];
        self.item   = self.class.createItem;    self.item.id = self.itemId;
    }
    else if ([type isEqualToString:@"location"])
    {
        self.locationId = [self idFromString:dictionary[@"type_id"]];
        self.location   = self.class.createLocation;    self.location.id = self.locationId;
    }
    else if ([type isEqualToString:@"user"])
    {
        self.userId     = [self idFromString:dictionary[@"type_id"]];
        self.user   = self.class.createUser;    self.user.id    = self.userId;
    }
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = self.class.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.class.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];

    return self.id ? self : nil;
}

@end
