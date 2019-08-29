//
//  DAOContact+dncToDAO.m
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCore;

#import "DAOContact+dncToDAO.h"

#import "DAOUser+dncToDAO.h"

@implementation DAOContact (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOContact.contact dncToDAO:dictionary];
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

    self.type       = [self stringFromString:dictionary[@"type"]];
    self.name       = [self stringFromString:dictionary[@"name"]];
    self.email      = [self stringFromString:dictionary[@"email"]];
    self.phone      = [self stringFromString:dictionary[@"phone"]];
    self.address    = [self stringFromString:dictionary[@"address"]];
    self.address2   = [self stringFromString:dictionary[@"address2"]];
    self.city       = [self stringFromString:dictionary[@"city"]];
    self.state      = [self stringFromString:dictionary[@"state"]];
    self.postalCode = [self stringFromString:dictionary[@"postalcode"]];
    self.country    = [self stringFromString:dictionary[@"country"]];
    
    self.geohash    = [self stringFromString:dictionary[@"geohash"]];
    self.latitude   = [self numberFromString:dictionary[@"latitude"]];
    self.longitude  = [self numberFromString:dictionary[@"longitude"]];

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
