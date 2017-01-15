//
//  DAOWishlist+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOWishlist+dncToDAO.h"

@implementation DAOWishlist (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOWishlist.wishlist dncToDAO:dictionary];
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id         = [self idFromString:dictionary[@"id"]];
    
    self.itemId     = [self idFromString:dictionary[@"type_id"]];
    self.userId     = [self idFromString:dictionary[@"user_id"]];
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];

    return self.id ? self : nil;
}

@end
