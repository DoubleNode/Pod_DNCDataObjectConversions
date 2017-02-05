//
//  DAOUser+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOUser+dncToDAO.h"

@implementation DAOUser (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOUser.user dncToDAO:dictionary];
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id         = [self idFromString:dictionary[@"id"]];

    // FIXME: API Hookup
    self.me             = [dictionary[@"me"] isEqualToNumber:@1];
    self.name           = [self stringFromString:dictionary[@"name"]];
    self.username       = [self stringFromString:dictionary[@"login"]];
    self.location       = @"";
    self.email          = [self stringFromString:dictionary[@"email"]];
    self.handle         = [self stringFromString:dictionary[@"handle"]];
    self.phoneNumber    = [self stringFromString:dictionary[@"phone"]];
    if (dictionary[@"avatar"] && (dictionary[@"avatar"] != [NSNull null]))
    {
        self.avatarId   = [self idFromString:dictionary[@"avatar"][@"id"]];
    }

    self.verifyKey      = [self stringFromString:dictionary[@"verify_key"]];
    self.verifiedDate   = [self timeFromString:dictionary[@"verify_date"]];

    NSMutableDictionary*    counts             = [dictionary[@"counts"] mutableCopy];
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

    self.birthday               = [self dateFromString:dictionary[@"birthday"]];

    NSMutableDictionary*    options     = [@{ } mutableCopy];
    NSMutableDictionary*    optionIds   = [@{ } mutableCopy];
    
    NSArray*    optionsArray = dictionary[@"options"];
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
    self.options    = options;
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    
    return self.id ? self : nil;
}

@end
