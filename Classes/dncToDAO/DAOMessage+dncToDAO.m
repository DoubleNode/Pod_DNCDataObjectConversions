//
//  DAOMessage+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;
#import <DNCDataObjects/DAOUser.h>

#import "DAOMessage+dncToDAO.h"

#import "DAOCategory+dncToDAO.h"
#import "DAOConversation+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOMessage (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOMessage.message dncToDAO:dictionary];
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

    NSString*   conversationId  = [self idFromString:dictionary[@"user_id"]];
    
    self.conversation   = [DAOConversation dncToDAO:@{
                                                      @"id" : conversationId,
                                                      }];

    self.subject    = [self stringFromString:dictionary[@"subject"]];
    self.message    = [self stringFromString:dictionary[@"message"]];
    self.type       = [self stringFromString:dictionary[@"message_type"]];

    NSString*   fromType    = [self stringFromString:dictionary[@"from_type"]];
    NSString*   fromId      = [self idFromString:dictionary[@"from_type_id"]];
    
    if ([fromType isEqualToString:@"category"])
    {
        self.fromCategory   = [DAOCategory dncToDAO:@{
                                                      @"id" : fromId,
                                                      }];
    }
    else if ([fromType isEqualToString:@"item"])
    {
        self.fromItem   = [DAOItem dncToDAO:@{
                                              @"id" : fromId,
                                              }];
    }
    else if ([fromType isEqualToString:@"location"])
    {
        self.fromLocation   = [DAOLocation dncToDAO:@{
                                                      @"id" : fromId,
                                                      }];
    }
    else if ([fromType isEqualToString:@"user"])
    {
        self.fromUser   = [DAOUser dncToDAO:@{
                                              @"id" : fromId,
                                              }];
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
