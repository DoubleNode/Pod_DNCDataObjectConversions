//
//  NSMutableDictionary+daoNewsToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAONews.h>

#import "NSMutableDictionary+daoNewsToDNC.h"

#import "NSMutableDictionary+daoFavoriteToDNC.h"

@implementation NSMutableDictionary (daoNewsToDNC)

+ (instancetype)daoNewsToDNC:(DAONews*)object
{
    return [[NSMutableDictionary dictionary] daoNewsToDNC:object];
}

- (instancetype)daoNewsToDNC:(DAONews*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:[DAONews class]], DNCLD_DAO, @"object is not a DAONews");
    
    /*
    self.id         = [self idFromString:item[@"id"]];

    self.title      = [self stringFromString:item[@"title"]];
    self.body       = [self stringFromString:item[@"body"]];
    self.bodyShort  = [self stringFromString:item[@"body_short"]];

    self.imageUrl   = [self urlFromString:item[@"image"]];

    self.expiration = [self dateFromString:item[@"expiration"]];

    NSMutableDictionary*    counts  = [item[@"counts"] mutableCopy];
    
    self.numFavorites   = [self numberFromString:counts[@"favorites"]];
    
    self.myFavorite     = [DAOFavorite daoToDNC:item[@"my_favorite"]];
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
