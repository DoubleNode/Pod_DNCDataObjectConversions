//
//  DAOLineitem+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOLineitem+dncToDAO.h"

#import "DAOCategory+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOOrder+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOLineitem (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOLineitem.lineitem dncToDAO:dictionary];
}

+ (DAOCategory*)createCategory
{
    return DAOCategory.category;
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

    self.name       = [self stringFromString:dictionary[@"type_name"]];

    self.quantity   = [self numberFromString:dictionary[@"quantity"]];
    self.price      = [self numberFromString:dictionary[@"price"]];
    self.total      = [self numberFromString:dictionary[@"total"]];
    self.data       = [self dictionaryFromJsonString:dictionary[@"data"]];

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
