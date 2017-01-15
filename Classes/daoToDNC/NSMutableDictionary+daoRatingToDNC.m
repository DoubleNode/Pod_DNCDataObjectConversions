//
//  NSMutableDictionary+daoRatingToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAORating.h>

#import "NSMutableDictionary+daoRatingToDNC.h"

@implementation NSMutableDictionary (daoRatingToDNC)

+ (instancetype)daoRatingToDNC:(DAORating*)object
{
    return [NSMutableDictionary.dictionary daoRatingToDNC:object];
}

- (instancetype)daoRatingToDNC:(DAORating*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAORating.class], DNCLD_DAO, @"object is not a DAORating");
    
    /*
    self.id         = [self idFromString:item[@"id"]];
    
    self.value      = [self numberFromString:item[@"rating"]];
    if (self.value.intValue > 5)
    {
        self.value  = @5;
    }
    
    self.beerId     = [self idFromString:item[@"type_id"]];
    self.reviewId   = [self idFromString:item[@"review_id"]];
    self.userId     = [self idFromString:item[@"user_id"]];
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
