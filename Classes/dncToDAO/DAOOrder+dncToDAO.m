//
//  DAOOrder+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOOrder+dncToDAO.h"

#import "DAOCategory+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOLineitem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOTransaction+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOOrder (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOOrder.order dncToDAO:dictionary];
}

+ (DAOCategory*)createCategory
{
    return DAOCategory.category;
}

+ (DAOItem*)createItem
{
    return DAOItem.item;
}

+ (DAOLineitem*)createLineitem
{
    return DAOLineitem.lineitem;
}

+ (DAOLocation*)createLocation
{
    return DAOLocation.location;
}

+ (DAOTransaction*)createTransaction
{
    return DAOTransaction.transaction;
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

    self.status = [self stringFromString:dictionary[@"status"]];
    self.state  = [self stringFromString:dictionary[@"state"]];
    self.total  = [self numberFromString:dictionary[@"total"]];

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
    
    {
        NSArray<NSDictionary* >* lineitems = dictionary[@"lineitems"];
        
        NSMutableArray<DAOLineitem* >*  daoLineitems = [NSMutableArray arrayWithCapacity:lineitems.count];
        
        for (NSDictionary* lineitem in lineitems)
        {
            DAOLineitem*    daoLineitem;
            
            if ([lineitem isKindOfClass:DAOLineitem.class])
            {
                daoLineitem = (DAOLineitem*)lineitem;
            }
            else
            {
                daoLineitem = [self.class.createLineitem dncToDAO:lineitem];
            }
            
            if (daoLineitem)
            {
                [daoLineitems addObject:daoLineitem];
            }
        }
        
        self.lineitems = daoLineitems;
    }
    
    {
        NSArray<NSDictionary* >* transactions = dictionary[@"transactions"];
        
        NSMutableArray<DAOTransaction* >*  daoTransactions = [NSMutableArray arrayWithCapacity:transactions.count];
        
        for (NSDictionary* transaction in transactions)
        {
            DAOTransaction*     daoTransaction;
            
            if ([transaction isKindOfClass:DAOTransaction.class])
            {
                daoTransaction = (DAOTransaction*)transaction;
            }
            else
            {
                daoTransaction = [self.class.createTransaction dncToDAO:transaction];
            }
            
            if (daoTransaction)
            {
                [daoTransactions addObject:daoTransaction];
            }
        }
        
        self.transactions = daoTransactions;
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
