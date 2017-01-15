//
//  NSMutableDictionary+daoUserToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOUser.h>

#import "NSMutableDictionary+daoUserToDNC.h"

@implementation NSMutableDictionary (daoUserToDNC)

+ (instancetype)daoUserToDNC:(DAOUser*)object
{
    return [NSMutableDictionary.dictionary daoUserToDNC:object];
}

- (instancetype)daoUserToDNC:(DAOUser*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAOUser.class], DNCLD_DAO, @"object is not a DAOUser");
    
    /*
    self.id         = [self idFromString:item[@"id"]];

    // FIXME: API Hookup
    self.me             = [item[@"me"] isEqualToNumber:@1];
    self.name           = [self stringFromString:item[@"name"]];
    self.username       = [self stringFromString:item[@"login"]];
    self.location       = @"";
    self.email          = [self stringFromString:item[@"email"]];
    self.handle         = [self stringFromString:item[@"handle"]];
    self.phoneNumber    = [self stringFromString:item[@"phone"]];
    if (item[@"avatar"] && (item[@"avatar"] != [NSNull null]))
    {
        self.avatarId   = [self idFromString:item[@"avatar"][@"id"]];
    }
    
    NSMutableDictionary*    counts             = [item[@"counts"] mutableCopy];
    NSMutableDictionary*    usersCounts        = [counts[@"users"] mutableCopy];
    NSMutableDictionary*    locationsCounts    = [counts[@"locations"] mutableCopy];
    NSMutableDictionary*    itemsCounts        = [counts[@"items"] mutableCopy];
    
    self.numUsersFollowers      = [self numberFromString:usersCounts[@"followers"]];
    self.numUsersFollowing      = [self numberFromString:usersCounts[@"following"]];
    
    self.numLocationsFollowers  = [self numberFromString:locationsCounts[@"followers"]];
    self.numLocationsRatings    = [self numberFromString:locationsCounts[@"ratings"]];
    self.numLocationsReviews    = [self numberFromString:locationsCounts[@"reviews"]];
    self.numLocationsFavorites  = [self numberFromString:locationsCounts[@"favorites"]];
    self.numLocationsWishlists  = [self numberFromString:locationsCounts[@"wishlists"]];
    self.numLocationsCheckins   = [self numberFromString:locationsCounts[@"checkins"]];
    
    self.numItemsFollowers      = [self numberFromString:itemsCounts[@"followers"]];
    self.numItemsRatings        = [self numberFromString:itemsCounts[@"ratings"]];
    self.numItemsReviews        = [self numberFromString:itemsCounts[@"reviews"]];
    self.numItemsFavorites      = [self numberFromString:itemsCounts[@"favorites"]];
    self.numItemsWishlists      = [self numberFromString:itemsCounts[@"wishlists"]];
    self.numItemsCheckins       = [self numberFromString:itemsCounts[@"checkins"]];
    
    if (item[@"birthday"])
    {
        NSDateFormatter*   dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        self.birthday   = [dateFormatter dateFromString:item[@"birthday"]];
    }
    
    NSMutableDictionary*    options     = [@{ } mutableCopy];
    NSMutableDictionary*    optionIds   = [@{ } mutableCopy];
    
    NSArray*    optionsArray = item[@"options"];
    if (optionsArray)
    {
        [optionsArray enumerateObjectsUsingBlock:
         ^(NSDictionary* _Nonnull option, NSUInteger idx, BOOL* _Nonnull stop)
         {
             NSString*  key         = [self stringFromString:option[@"key"]];
             NSString*  optionId    = [self idFromString:option[@"id"]];

             id value   = option[@"value"];
             if (!value)
             {
                 value = option[@"value_long"];
             }
             
             options[key]   = value;
             optionIds[key] = optionId;
         }];
    }
    
    self.optionIds  = optionIds;
    
    if (options[@"didAskBrewer"])   {   self.askBrewer      = [self boolFromString:options[@"didAskBrewer"]];   }
    
    if (options[@"myBrewery"])      {   self.myBreweryId    = [self idFromString:options[@"myBrewery"]];        }
    if (options[@"goldBeer"])       {   self.goldBeerId     = [self idFromString:options[@"goldBeer"]];         }
    if (options[@"silverBeer"])     {   self.silverBeerId   = [self idFromString:options[@"silverBeer"]];       }
    if (options[@"bronzeBeer"])     {   self.bronzeBeerId   = [self idFromString:options[@"bronzeBeer"]];       }
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
