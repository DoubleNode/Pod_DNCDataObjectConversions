//
//  DAOReview+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOReview+dncToDAO.h"

@implementation DAOReview (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
   return [[DAOReview review] dncToDAO:dictionary];
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:[NSDictionary class]], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id        = [self idFromString:dictionary[@"id"]];
    self.text      = [self stringFromString:dictionary[@"review"]];

    self.ratingValue    = [self numberFromString:dictionary[@"rating_value"]];
    if (self.ratingValue.intValue > 5)
    {
        self.ratingValue    = @5;
    }
    
    self.itemId    = [self idFromString:dictionary[@"type_id"]];
    self.ratingId  = [self idFromString:dictionary[@"rating_id"]];
    self.photoId   = [self idFromString:dictionary[@"photo_id"]];
    self.userId    = [self idFromString:dictionary[@"user_id"]];
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._synced    = [NSDate date];
    self._updated   = [self timeFromString:dictionary[@"modified"]];

    return self.id ? self : nil;
}

@end
