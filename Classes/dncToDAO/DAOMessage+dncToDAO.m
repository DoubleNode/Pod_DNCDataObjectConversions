//
//  DAOMessage+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOMessage+dncToDAO.h"

@implementation DAOMessage (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [[DAOMessage message] dncToDAO:dictionary];
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id         = [self idFromString:dictionary[@"id"]];

    self.message    = [self stringFromString:dictionary[@"message"]];

    self.userId     = [self idFromString:dictionary[@"from_user_id"]];
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];

    return self.id ? self : nil;
}

@end
