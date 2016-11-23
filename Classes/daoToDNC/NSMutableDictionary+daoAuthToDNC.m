//
//  NSMutableDictionary+daoAuthToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOAuth.h>
#import <DNCDataObjects/DAOUser.h>

#import "NSMutableDictionary+daoAuthToDNC.h"

#import "NSMutableDictionary+daoUserToDNC.h"

@implementation NSMutableDictionary (daoAuthToDNC)

+ (instancetype)daoAuthToDNC:(DAOAuth*)object
{
    return [[NSMutableDictionary dictionary] daoAuthToDNC:object];
}

- (instancetype)daoAuthToDNC:(DAOAuth*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:[DAOAuth class]], DNCLD_DAO, @"object is not a DAOAuth");
    
    self[@"id"]         = object.id;
    self[@"type"]       = object.type;
    self[@"token"]      = object.token;

    self[@"bucketId"]   = object.bucketId;
    self[@"bucketName"] = object.bucketName;

    self[@"accountId"]          = object.accountId;
    self[@"apiUrl"]             = object.apiUrl;
    self[@"downloadUrl"]        = object.downloadUrl;
    self[@"minimumPartSize"]    = object.minimumPartSize;

    self[@"user"]       = [NSMutableDictionary daoUserToDNC:object.user];
    self[@"user_id"]    = object.user.id;

    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
