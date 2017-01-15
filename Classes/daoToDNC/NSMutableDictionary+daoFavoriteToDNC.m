//
//  NSMutableDictionary+daoFavoriteToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOFavorite.h>
#import <DNCDataObjects/DAOItem.h>
#import <DNCDataObjects/DAOUser.h>

#import "NSMutableDictionary+daoFavoriteToDNC.h"

#import "NSMutableDictionary+daoItemToDNC.h"
#import "NSMutableDictionary+daoUserToDNC.h"

@implementation NSMutableDictionary (daoFavoriteToDNC)

+ (instancetype)daoFavoriteToDNC:(DAOFavorite*)object
{
    return [NSMutableDictionary.dictionary daoFavoriteToDNC:object];
}

- (instancetype)daoFavoriteToDNC:(DAOFavorite*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAOFavorite.class], DNCLD_DAO, @"object is not a DAOFavorite");
    
    self[@"id"] = object.id;
    
    self[@"type"]       = [NSMutableDictionary daoItemToDNC:object.item];
    self[@"type_id"]    = object.item.id;

    self[@"user"]       = [NSMutableDictionary daoUserToDNC:object.user];
    self[@"user_id"]    = object.user.id;
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
