//
//  DAOCheckin+dncToDAO.m
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCore;

#import "DAOCheckin+dncToDAO.h"

#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOReview+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOCheckin (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOCheckin.checkin dncToDAO:dictionary];
}

+ (DAOItem*)createItem
{
    return DAOItem.item;
}

+ (DAOLocation*)createLocation
{
    return DAOLocation.location;
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
    
    self.id     = [self idFromString:dictionary[@"id"]];

    NSString*   type    = [self stringFromString:dictionary[@"type"]];
    
    if ([type isEqualToString:@"item"])
    {
        id  item = dictionary[@"item"];
        if (item && (item != NSNull.null))
        {
            self.itemId  = [self idFromString:item[@"id"]];
            self.item    = [self.class.createItem dncToDAO:item];
        }
    }
    else if ([type isEqualToString:@"location"])
    {
        id  location = dictionary[@"location"];
        if (location && (location != NSNull.null))
        {
            self.locationId = [self idFromString:location[@"id"]];
            self.location   = [self.class.createLocation dncToDAO:location];
        }
    }
    else if ([type isEqualToString:@"review"])
    {
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
