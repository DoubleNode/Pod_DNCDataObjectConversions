//
//  NSMutableDictionary+daoItemToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOItem.h>

#import "NSMutableDictionary+daoItemToDNC.h"

#import "NSMutableDictionary+daoFavoriteToDNC.h"
#import "NSMutableDictionary+daoFollowToDNC.h"
#import "NSMutableDictionary+daoLocationToDNC.h"
#import "NSMutableDictionary+daoRatingToDNC.h"
#import "NSMutableDictionary+daoReviewToDNC.h"
#import "NSMutableDictionary+daoWishlistToDNC.h"

@implementation NSMutableDictionary (daoItemToDNC)

+ (instancetype)daoItemToDNC:(DAOItem*)object
{
    return [[NSMutableDictionary dictionary] daoItemToDNC:object];
}

- (instancetype)daoItemToDNC:(DAOItem*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:[DAOItem class]], DNCLD_DAO, @"object is not a DAOItem");
    
    /*
    NSMutableDictionary*    beer    = [item[@"beer"] mutableCopy];
    NSMutableDictionary*    counts  = [item[@"counts"] mutableCopy];
    
    beer[@"added"]      = item[@"added"];
    beer[@"modified"]   = item[@"modified"];
    
    self.id                  = [self idFromString:item[@"id"]];
    self.type                = [self idFromString:item[@"type"]];
    self.name                = [self stringFromString:item[@"name"]];
    self.descriptionString   = [self stringFromString:item[@"description"]];
    self.rating              = [self numberFromString:item[@"rating"]];
    
    self.foodPairings        = @"";
    self.originalGravity     = @"";
    
    self.numFollowers       = [self numberFromString:counts[@"followers"]];
    self.numRatings         = [self numberFromString:counts[@"ratings"]];
    self.numReviews         = [self numberFromString:counts[@"reviews"]];
    self.numFavorites       = [self numberFromString:counts[@"favorites"]];
    self.numWishlists       = [self numberFromString:counts[@"wishlists"]];
    self.numCheckins        = [self numberFromString:counts[@"checkins"]];
    
    self.myFavorite         = [DAOFavorite daoToDNC:item[@"my_favorite"]];
    //self.myFollow           = [DAOFollow daoToDNC:item[@"my_follow"]];
    //self.myRating           = [DAORating daoToDNC:item[@"my_rating"]];
    self.myReview           = [DAOReview daoToDNC:item[@"my_review"]];
    self.myWishlist         = [DAOWishlist daoToDNC:item[@"my_wishlist"]];
    
    if (beer.count > 2)
    {
        self.remoteId       = [self idFromString:beer[@"bdb_id"]];
        
        self.abv            = [self numberFromString:beer[@"bdb_abv"]];
        self.ibu            = [self numberFromString:beer[@"bdb_ibu"]];
        
        self.organic        = [self boolFromString:beer[@"bdb_isOrganic"]];
        
        self.available      = @{
                                @"name"         : [self stringFromString:beer[@"bdb_available"]],
                                @"description"  : [self stringFromString:beer[@"bdb_available_description"]],
                                };
        
        self.labels         = @{
                                @"large"    : [self urlFromString:beer[@"bdb_image_large"]],
                                @"medium"   : [self urlFromString:beer[@"bdb_image_medium"]],
                                @"icon"     : [self urlFromString:beer[@"bdb_image_icon"]],
                                };
    }
    else
    {
        self.remoteId       = self.id;
        
        self.abv            = @(0);
        self.ibu            = @(0);
        
        self.organic        = NO;
        
        self.available      = @{ };
        
        self.labels         = @{ };
    }
    
    NSArray<NSDictionary* >* breweries  = item[@"breweries"];
    
    NSMutableArray<DAOLocation* >*  daoBreweries = [NSMutableArray arrayWithCapacity:breweries.count];
    
    [breweries enumerateObjectsUsingBlock:
     ^(NSDictionary* _Nonnull brewery, NSUInteger idx, BOOL* _Nonnull stop)
     {
         DAOLocation*    DAOLocation;
         
         if ([brewery isKindOfClass:[DAOLocation class]])
         {
             DAOLocation = (DAOLocation*)brewery;
         }
         else
         {
             DAOLocation = [DAOLocation daoToDNC:brewery];
         }
         
         if (DAOLocation)
         {
             [daoBreweries addObject:DAOLocation];
         }
     }];
    
    self.breweries   = daoBreweries;
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
