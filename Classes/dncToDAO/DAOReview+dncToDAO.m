//
//  DAOReview+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOReview+dncToDAO.h"

#import "DAOUser+dncToDAO.h"

@implementation DAOReview (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
   return [DAOReview.review dncToDAO:dictionary];
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
    
    self.id        = [self idFromString:dictionary[@"id"]];
    self.text      = [self stringFromString:dictionary[@"review"]];

    self.ratingValue    = [self numberFromString:dictionary[@"rating_value"]];
    if (self.ratingValue.intValue > 5)
    {
        self.ratingValue    = @5;
    }
    
    self.ratingId  = [self idFromString:dictionary[@"rating_id"]];
    self.photoId   = [self idFromString:dictionary[@"photo_id"]];
    self.userId    = [self idFromString:dictionary[@"user_id"]];
    
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
