//
//  DAOPaymentAccount+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOPaymentAccount+dncToDAO.h"

#import "DAOContact+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOPaymentAccount (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOPaymentAccount.paymentAccount dncToDAO:dictionary];
}

+ (DAOContact*)createContact
{
    return DAOContact.contact;
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

    self.type           = [self stringFromString:dictionary[@"type"]];
    self.name           = [self stringFromString:dictionary[@"name"]];
    self.accountToken   = [self stringFromString:dictionary[@"token"]];
    self.accountNumber  = [self stringFromString:dictionary[@"account_number"]];
    self.expirationDate = [self dateFromString:dictionary[@"expiration_date"]];
    self.cvv            = [self stringFromString:dictionary[@"cvv_number"]];

    id  contact = dictionary[@"contact"];
    if (contact && (contact != NSNull.null))
    {
        self.contactId  = [self idFromString:contact[@"id"]];
        self.contact    = [self.class.createContact dncToDAO:contact];
    }
    
    self.userId = [self idFromString:dictionary[@"user_id"]];
    self.user   = self.class.createUser;    self.user.id    = self.userId;
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = self.class.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.class.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];

    return self.id ? self : nil;
}

@end
