//
//  NSMutableDictionary+daoWishlistToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOWishlist.h>

#import "NSMutableDictionary+daoWishlistToDNC.h"

@implementation NSMutableDictionary (daoWishlistToDNC)

+ (instancetype)daoWishlistToDNC:(DAOWishlist*)object
{
    return [[NSMutableDictionary dictionary] daoWishlistToDNC:object];
}

- (instancetype)daoWishlistToDNC:(DAOWishlist*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:[DAOWishlist class]], DNCLD_DAO, @"object is not a DAOWishlist");
    
    /*
    self.id         = [self idFromString:item[@"id"]];
    
    self.beerId     = [self idFromString:item[@"type_id"]];
    //self.beer       = item[@"bdb_style_category"];
    
    self.userId     = [self idFromString:item[@"user_id"]];
    //self.user       = item[@"bdb_style_category"];
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
