//
//  NSMutableDictionary+daoMessageToDNC.m
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCore;

#import <DNCDataObjects/DAOMessage.h>

#import "NSMutableDictionary+daoMessageToDNC.h"

@implementation NSMutableDictionary (daoMessageToDNC)

+ (instancetype)daoMessageToDNC:(DAOMessage*)object
{
    return [NSMutableDictionary.dictionary daoMessageToDNC:object];
}

- (instancetype)daoMessageToDNC:(DAOMessage*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAOMessage.class], DNCLD_DAO, @"object is not a DAOMessage");
    
    /*
    self.id         = [self idFromString:item[@"id"]];

    self.message    = [self stringFromString:item[@"message"]];

    self.userId     = [self idFromString:item[@"from_user_id"]];
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
