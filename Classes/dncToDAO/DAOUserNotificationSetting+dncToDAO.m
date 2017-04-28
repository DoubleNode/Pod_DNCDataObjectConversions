//
//  DAOUserNotificationSetting+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOUserNotificationSetting+dncToDAO.h"

#import "DAOUser+dncToDAO.h"

@implementation DAOUserNotificationSetting (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOUserNotificationSetting.userNotificationSetting dncToDAO:dictionary];
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
    
    self.emailEnabled   = [self boolFromString:dictionary[@"email"]];
    self.pushEnabled    = [self boolFromString:dictionary[@"push"]];
    self.smsEnabled     = [self boolFromString:dictionary[@"sms"]];

    self.keycode    = [self stringFromString:dictionary[@"type"]];

    self.userId     = [self idFromString:dictionary[@"user_id"]];
    self.user       = self.class.createUser;    self.user.id    = self.userId;
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = self.class.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.class.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];

    return self.id ? self : nil;
}

@end
