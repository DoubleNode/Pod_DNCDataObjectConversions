//
//  DAOCategory+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOCategory+dncToDAO.h"
#import "DAOFavorite+dncToDAO.h"
#import "DAOFollow+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAORating+dncToDAO.h"
#import "DAOReview+dncToDAO.h"
#import "DAOWishlist+dncToDAO.h"

@implementation DAOCategory (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOCategory.category dncToDAO:dictionary];
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id     = [self idFromString:dictionary[@"id"]];

    self.title              = [self idFromString:dictionary[@"title"]];
    self.descriptionString  = [self idFromString:dictionary[@"description"]];

    NSMutableDictionary*    counts  = [dictionary[@"counts"] mutableCopy];
    
    self.numCheckins        = [self numberFromString:counts[@"checkins"]];
    self.numFavorites       = [self numberFromString:counts[@"favorites"]];
    self.numFollowers       = [self numberFromString:counts[@"followers"]];
    self.numRatings         = [self numberFromString:counts[@"ratings"]];
    self.numReviews         = [self numberFromString:counts[@"reviews"]];
    self.numWishlists       = [self numberFromString:counts[@"wishlists"]];

    self.myFavorite         = [DAOFavorite dncToDAO:dictionary[@"my_favorite"]];
    self.myFollow           = [DAOFollow dncToDAO:dictionary[@"my_follow"]];
    self.myRating           = [DAORating dncToDAO:dictionary[@"my_rating"]];
    self.myReview           = [DAOReview dncToDAO:dictionary[@"my_review"]];
    self.myWishlist         = [DAOWishlist dncToDAO:dictionary[@"my_wishlist"]];

    NSMutableDictionary*    options     = [@{ } mutableCopy];
    NSMutableDictionary*    optionIds   = [@{ } mutableCopy];
    
    NSArray*    optionsArray = dictionary[@"options"];
    if (optionsArray)
    {
        for (NSDictionary* option in optionsArray)
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
        }
    }
    
    self.optionIds  = optionIds;
    self.options    = options;
    
    {
        NSArray<NSDictionary* >* locations  = dictionary[@"locations"];
        
        NSMutableArray<DAOLocation* >*  daoLocations = [NSMutableArray arrayWithCapacity:locations.count];
        
        for (NSDictionary* location in locations)
        {
            DAOLocation*    daoLocation;
            
            if ([location isKindOfClass:DAOLocation.class])
            {
                daoLocation = (DAOLocation*)location;
            }
            else
            {
                daoLocation = [DAOLocation dncToDAO:location];
            }
            
            if (daoLocation)
            {
                [daoLocations addObject:daoLocation];
            }
        }
        
        self.locations  = daoLocations;
    }
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];

    return self.id ? self : nil;
}

@end
