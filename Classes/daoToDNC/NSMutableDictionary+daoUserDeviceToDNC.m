//
//  NSMutableDictionary+daoUserDeviceToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOUserDevice.h>

#import "NSMutableDictionary+daoUserDeviceToDNC.h"

@implementation NSMutableDictionary (daoUserDeviceToDNC)

+ (instancetype)daoUserDeviceToDNC:(DAOUserDevice*)object
{
    return [[NSMutableDictionary dictionary] daoUserDeviceToDNC:object];
}

- (instancetype)daoUserDeviceToDNC:(DAOUserDevice*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:[DAOUserDevice class]], DNCLD_DAO, @"object is not a DAOUserDevice");
    
    /*
    self.id         = [self idFromString:item[@"id"]];
    
    self.deviceId   = [self stringFromString:item[@"device_id"]];
    self.deviceType = [self stringFromString:item[@"device_type"]];

    self.userId     = [self idFromString:item[@"user_id"]];
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
