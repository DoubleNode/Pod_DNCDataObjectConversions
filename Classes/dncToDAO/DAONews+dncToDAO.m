//
//  DAONews+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAONews+dncToDAO.h"

#import "DAOFavorite+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAONews (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAONews.news dncToDAO:dictionary];
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
    
    self.id         = [self idFromString:dictionary[@"id"]];

    self.title      = [self stringFromString:dictionary[@"title"]];
    self.body       = [self stringFromString:dictionary[@"body"]];
    self.bodyShort  = [self stringFromString:dictionary[@"body_short"]];

    self.imageUrl   = [self urlStringFromString:dictionary[@"image"]];

    self.expiration = [self timeFromString:dictionary[@"expiration"]];

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
