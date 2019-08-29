//
//  NSMutableDictionary+daoSocialAccountToDNC.m
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCore;

#import <DNCDataObjects/DAOSocialAccount.h>

#import "NSMutableDictionary+daoSocialAccountToDNC.h"

#import "NSMutableDictionary+daoLocationToDNC.h"
#import "NSMutableDictionary+daoUserToDNC.h"

@implementation NSMutableDictionary (daoSocialAccountToDNC)

+ (instancetype)daoSocialAccountToDNC:(DAOSocialAccount*)object
{
    return [NSMutableDictionary.dictionary daoSocialAccountToDNC:object];
}

- (instancetype)daoSocialAccountToDNC:(DAOSocialAccount*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAOSocialAccount.class], DNCLD_DAO, @"object is not a DAOSocialAccount");
    
    self[@"id"]         = object.id;
    
    self[@"type"]       = object.type;
    self[@"handle"]     = object.handle;
    self[@"url"]        = object.url;
    
    self[@"location"]       = [NSMutableDictionary daoLocationToDNC:object.location];
    self[@"location_id"]    = object.locationId;

    self[@"user"]           = [NSMutableDictionary daoUserToDNC:object.user];
    self[@"user_id"]        = object.userId;
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
