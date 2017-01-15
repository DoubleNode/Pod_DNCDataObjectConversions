//
//  DAORating+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAORating+dncToDAO.h"

@implementation DAORating (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [[DAORating rating] dncToDAO:dictionary];
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
    
    self.itemId     = [self idFromString:dictionary[@"type_id"]];
    self.reviewId   = [self idFromString:dictionary[@"review_id"]];
    self.userId     = [self idFromString:dictionary[@"user_id"]];
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];

    return self.id ? self : nil;
}

@end
