//
//  DAORating+dncToDAO.m
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCore;

#import "DAORating+dncToDAO.h"

#import "DAOUser+dncToDAO.h"

@implementation DAORating (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAORating.rating dncToDAO:dictionary];
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
    
    self.id         = [self idFromString:dictionary[@"id"]];
    
    self.value      = [self numberFromString:dictionary[@"rating"]];
    if (self.value.intValue > 5)
    {
        self.value  = @5;
    }
    
    self.ratingType = [self stringFromString:dictionary[@"rating_type"]];
    self.userId     = [self idFromString:dictionary[@"user_id"]];
    self.reviewId   = [self idFromString:dictionary[@"review_id"]];

    NSString*   type    = [self stringFromString:dictionary[@"type"]];
    
    if ([type isEqualToString:@"item"])
    {
        self.itemId = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"location"])
    {
        self.locationId = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"user"])
    {
        self.userId = [self idFromString:dictionary[@"type_id"]];
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

