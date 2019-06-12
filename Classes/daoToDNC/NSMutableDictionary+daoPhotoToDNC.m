//
//  NSMutableDictionary+daoPhotoToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOPhoto.h>

#import "NSMutableDictionary+daoPhotoToDNC.h"

#import "NSMutableDictionary+daoFavoriteToDNC.h"

@implementation NSMutableDictionary (daoPhotoToDNC)

+ (instancetype)daoPhotoToDNC:(DAOPhoto*)object
{
    return [NSMutableDictionary.dictionary daoPhotoToDNC:object];
}

- (instancetype)daoPhotoToDNC:(DAOPhoto*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAOPhoto.class], DNCLD_DAO, @"object is not a DAOPhoto");
    
    /*
    self.id             = [self idFromString:item[@"id"]];
    self.url            = [self urlStringFromString:item[@"path"]];
    self.url_preload    = [self urlStringFromString:item[@"path_preload"]];
    self.comment        = [self stringFromString:item[@"comment"]];
    self.userId         = [self idFromString:item[@"user_id"]];
    
    NSString*   type    = [self stringFromString:item[@"type"]];
    if ([type isEqualToString:@"review"])
    {
        self.reviewId   = [self idFromString:item[@"type_id"]];
    }
    else if ([type isEqualToString:@"item"])
    {
        self.beerId     = [self idFromString:item[@"type_id"]];
    }
    else if ([type isEqualToString:@"location"])
    {
        self.breweryId  = [self idFromString:item[@"type_id"]];
    }
    else if ([type isEqualToString:@"user"])
    {
        self.userId     = [self idFromString:item[@"type_id"]];
    }
    
    NSMutableDictionary*    counts  = [item[@"counts"] mutableCopy];
    
    self.numFavorites   = [self numberFromString:counts[@"favorites"]];
    
    self.myFavorite     = [DAOFavorite daoToDNC:item[@"my_favorite"]];
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
