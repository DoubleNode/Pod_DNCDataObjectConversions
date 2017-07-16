//
//  DAOUser+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOUser+dncToDAO.h"

#import "DAOContact+dncToDAO.h"
#import "DAOPhoto+dncToDAO.h"

@implementation DAOUser (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOUser.user dncToDAO:dictionary];
}

+ (DAOContact*)createContact
{
    return DAOContact.contact;
}

+ (DAOPhoto*)createPhoto
{
    return DAOPhoto.photo;
}

+ (DAOUser*)createUser
{
    return DAOUser.user;
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
    self.location       = [self stringFromString:dictionary[@"location"]];
    self.email          = [self stringFromString:dictionary[@"email"]];
    self.handle         = [self stringFromString:dictionary[@"handle"]];
    self.phoneNumber    = [self stringFromString:dictionary[@"phone"]];

    id  avatar = dictionary[@"avatar"];
    if (avatar && (avatar != NSNull.null))
    {
        self.avatarId   = [self idFromString:avatar[@"id"]];
        self.avatar     = [self.class.createPhoto dncToDAO:avatar];

    }

    id  contact = dictionary[@"contact"];
    if (contact && (contact != NSNull.null))
    {
        self.contactId  = [self idFromString:contact[@"id"]];
        self.contact    = [self.class.createContact dncToDAO:contact];
    }

    self.rating         = [self numberFromString:dictionary[@"rating"]];

    self.ratingTypes        = @{ };
    
    id  ratingTypes = dictionary[@"rating_types"];
    if (ratingTypes && (ratingTypes != NSNull.null))
    {
        NSMutableDictionary*    ratingTypes = NSMutableDictionary.dictionary;
        
        [ratingTypes enumerateKeysAndObjectsUsingBlock:
         ^(NSString* _Nonnull key, NSNumber* _Nonnull value, BOOL* _Nonnull stop)
         {
             ratingTypes[key]   = value;
         }];
        
        self.ratingTypes    = ratingTypes;
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

    NSMutableDictionary*    options     = NSMutableDictionary.dictionary;
    NSMutableDictionary*    optionIds   = NSMutableDictionary.dictionary;
    
    NSArray*    optionsArray = dictionary[@"options"];
    if (optionsArray)
    {
        [optionsArray enumerateObjectsUsingBlock:
         ^(NSDictionary* _Nonnull option, NSUInteger idx, BOOL* _Nonnull stop)
         {
             NSString*  key         = [self stringFromString:option[@"key"]];
             NSString*  optionId    = [self idFromString:option[@"id"]];

             id value   = option[@"value_long"];
             if (!value || [value isKindOfClass:NSNull.class])
             {
                 value = option[@"value"];
             }
             
             options[key]   = value;
             optionIds[key] = optionId;
         }];
    }
    
    self.optionIds  = optionIds;
    self.options    = options;
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = self.class.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.class.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];
    
    return self.id ? self : nil;
}

@end
