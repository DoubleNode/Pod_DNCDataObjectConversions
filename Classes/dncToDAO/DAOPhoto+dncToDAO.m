//
//  DAOPhoto+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOPhoto+dncToDAO.h"

#import "DAOFavorite+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOPhoto (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOPhoto.photo dncToDAO:dictionary];
}

+ (DAOFavorite*)createFavorite
{
    return DAOFavorite.favorite;
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
    
    self.id             = [self idFromString:dictionary[@"id"]];
    self.url            = [self urlStringFromString:dictionary[@"path"]];
    self.url_preload    = [self urlStringFromString:dictionary[@"path_preload"]];
    self.comment        = [self stringFromString:dictionary[@"comment"]];
    self.userId         = [self idFromString:dictionary[@"user_id"]];
    
    NSString*   type    = [self stringFromString:dictionary[@"type"]];
    if ([type isEqualToString:@"review"])
    {
        self.reviewId   = [self idFromString:dictionary[@"type_id"]];
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
    else if ([type isEqualToString:@"user"])
    {
        self.userId     = [self idFromString:dictionary[@"type_id"]];
    }
    
    NSMutableDictionary*    counts  = [dictionary[@"counts"] mutableCopy];
    
    self.numFavorites   = [self numberFromString:counts[@"favorites"]];
    
    self.myFavorite     = [self.class.createFavorite dncToDAO:dictionary[@"my_favorite"]];
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = self.class.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.class.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];
    
    return self.id ? self : nil;
}

@end
