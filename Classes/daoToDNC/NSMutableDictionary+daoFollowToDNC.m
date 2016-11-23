//
//  NSMutableDictionary+daoFollowToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOFollow.h>

#import "NSMutableDictionary+daoFollowToDNC.h"

@implementation NSMutableDictionary (daoFollowToDNC)

+ (instancetype)daoFollowToDNC:(DAOFollow*)object
{
    return [[NSMutableDictionary dictionary] daoFollowToDNC:object];
}

- (instancetype)daoFollowToDNC:(DAOFollow*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:[DAOFollow class]], DNCLD_DAO, @"object is not a DAOFollow");
    
    /*
    self.id         = [self idFromString:item[@"id"]];

    // TODO: Fields missing due to API error
    //self.name        = item[@"bdb_style_category"];
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
