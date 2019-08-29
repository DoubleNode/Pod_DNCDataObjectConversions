//
//  DAOTransmission+dncToDAO.m
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCore;

#import "DAOTransmission+dncToDAO.h"

#import "DAONotification+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOTransmission (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOTransmission.transmission dncToDAO:dictionary];
}

+ (DAONotification*)createNotification
{
    return DAONotification.notification;
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

    self.to     = [self stringFromString:dictionary[@"to"]];
    self.body   = [self stringFromString:dictionary[@"body"]];

    self.sent   = [self dateFromString:dictionary[@"sent"]];
    self.read   = [self dateFromString:dictionary[@"read"]];

    self.notificationId = [self idFromString:dictionary[@"notification_id"]];
    self.notification   = self.class.createNotification;    self.notification.id    = self.notificationId;
    
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
