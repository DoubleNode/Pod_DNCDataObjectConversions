//
//  DAOFlag+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;
#import <DNCDataObjects/DAOUser.h>

#import "DAOFlag+dncToDAO.h"

@implementation DAOFlag (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOFlag.flag dncToDAO:dictionary];
}

- (DAOUser*)createUser
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
    
    self.action     = [self idFromString:dictionary[@"action"]];
    self.text       = [self idFromString:dictionary[@"text"]];
    
    NSString*   type    = [self stringFromString:dictionary[@"type"]];
    if ([type isEqualToString:@"activity"])
    {
        self.activityId = [self idFromString:dictionary[@"type_id"]];
    }
    if ([type isEqualToString:@"category"])
    {
        self.categoryId = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"item"])
    {
        self.itemId     = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"location"])
    {
        self.locationId = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"message"])
    {
        self.messageId  = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"news"])
    {
        self.newsId     = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"photo"])
    {
        self.photoId    = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"user"])
    {
        self.userId     = [self idFromString:dictionary[@"type_id"]];
    }
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = self.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];

    return self.id ? self : nil;
}

@end
