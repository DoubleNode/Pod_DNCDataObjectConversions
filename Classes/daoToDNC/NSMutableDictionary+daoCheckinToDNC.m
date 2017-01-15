//
//  NSMutableDictionary+daoCheckinToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOCheckin.h>
#import <DNCDataObjects/DAOItem.h>
#import <DNCDataObjects/DAOLocation.h>
#import <DNCDataObjects/DAOPhoto.h>
#import <DNCDataObjects/DAOUser.h>

#import "NSMutableDictionary+daoCheckinToDNC.h"

#import "NSMutableDictionary+daoItemToDNC.h"
#import "NSMutableDictionary+daoLocationToDNC.h"
#import "NSMutableDictionary+daoPhotoToDNC.h"
#import "NSMutableDictionary+daoUserToDNC.h"

@implementation NSMutableDictionary (daoCheckinToDNC)

+ (instancetype)daoCheckinToDNC:(DAOCheckin*)object
{
    return [NSMutableDictionary.dictionary daoCheckinToDNC:object];
}

- (instancetype)daoCheckinToDNC:(DAOCheckin*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAOCheckin.class], DNCLD_DAO, @"object is not a DAOCheckin");
    
    self[@"id"] = object.id;
    
    if (object.item.id.length)
    {
        self[@"type"]       = @"item";
        self[@"item"]       = [NSMutableDictionary daoItemToDNC:object.item];
        self[@"item_id"]    = object.item.id;
    }
    else if (object.location.id.length)
    {
        self[@"type"]           = @"location";
        self[@"location"]       = [NSMutableDictionary daoLocationToDNC:object.location];
        self[@"location_id"]    = object.location.id;
    }
    
    self[@"photo"]      = [NSMutableDictionary daoPhotoToDNC:object.photo];
    self[@"photo_id"]   = object.photo.id;
    
    self[@"user"]       = [NSMutableDictionary daoUserToDNC:object.user];
    self[@"user_id"]    = object.user.id;
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
