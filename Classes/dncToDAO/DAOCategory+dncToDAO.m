//
//  DAOCategory+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;
#import <DNCDataObjects/DAOUser.h>

#import "DAOCategory+dncToDAO.h"
#import "DAOFavorite+dncToDAO.h"
#import "DAOFollow+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOPhoto+dncToDAO.h"
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
    self.rating             = [self numberFromString:dictionary[@"rating"]];

    NSMutableDictionary*    counts  = [dictionary[@"counts"] mutableCopy];
    
    self.numCheckins        = [self numberFromString:counts[@"checkins"]];
    self.numFavorites       = [self numberFromString:counts[@"favorites"]];
    self.numFlags           = [self numberFromString:counts[@"flags"]];
    self.numFollowers       = [self numberFromString:counts[@"followers"]];
    self.numItems           = [self numberFromString:counts[@"items"]];
    self.numRatings         = [self numberFromString:counts[@"ratings"]];
    self.numReviews         = [self numberFromString:counts[@"reviews"]];
    self.numTags            = [self numberFromString:counts[@"tags"]];
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
            
            id value   = option[@"value_long"];
            if (!value || [value isKindOfClass:NSNull.class])
            {
                value = option[@"value"];
            }
            
            options[key]   = value;
            optionIds[key] = optionId;
        }
    }
    
    self.optionIds  = optionIds;
    self.options    = options;

    {
        NSArray<NSDictionary* >* favorites  = dictionary[@"favorites"];
        
        NSMutableArray<DAOFavorite* >*  daoFavorites = [NSMutableArray arrayWithCapacity:favorites.count];
        
        for (NSDictionary* favorite in favorites)
        {
            DAOFavorite*    daoFavorite;
            
            if ([favorite isKindOfClass:DAOFavorite.class])
            {
                daoFavorite = (DAOFavorite*)favorite;
            }
            else
            {
                daoFavorite = [DAOFavorite dncToDAO:favorite];
            }
            
            if (daoFavorite)
            {
                [daoFavorites addObject:daoFavorite];
            }
        }
        
        self.favorites  = daoFavorites;
    }
    
    {
        NSArray<NSDictionary* >* items  = dictionary[@"items"];
        
        NSMutableArray<DAOItem* >*  daoItems = [NSMutableArray arrayWithCapacity:items.count];
        
        for (NSDictionary* item in items)
        {
            DAOItem*    daoItem;
            
            if ([item isKindOfClass:DAOItem.class])
            {
                daoItem = (DAOItem*)item;
            }
            else
            {
                daoItem = [DAOItem dncToDAO:item];
            }
            
            if (daoItem)
            {
                [daoItems addObject:daoItem];
            }
        }
        
        self.items  = daoItems;
    }
    
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
    
    {
        NSArray<NSDictionary* >*    photos = dictionary[@"photos"];
        
        NSMutableArray<DAOPhoto* >* daoPhotos = [NSMutableArray arrayWithCapacity:photos.count];
        
        if ([photos isKindOfClass:NSDictionary.class])
        {
            photos = @[ photos ];
        }
        if (photos)
        {
            for (NSDictionary* photo in photos)
            {
                if (photo[@"path"] && ![photo[@"path"] isEqual:NSNull.null])
                {
                    DAOPhoto*   daoPhoto   = [DAOPhoto dncToDAO:photo];
                    if (daoPhoto)
                    {
                        [daoPhotos addObject:daoPhoto];
                    }
                }
            }
        }
        
        self.photos = daoPhotos;
        
        for (DAOPhoto* daoPhoto in self.photos)
        {
            daoPhoto.category  = self;
        }
    }
    
    {
        NSArray<NSDictionary* >* wishlists  = dictionary[@"wishlists"];
        
        NSMutableArray<DAOWishlist* >*  daoWishlists = [NSMutableArray arrayWithCapacity:wishlists.count];
        
        for (NSDictionary* wishlist in wishlists)
        {
            DAOWishlist*    daoWishlist;
            
            if ([wishlist isKindOfClass:DAOWishlist.class])
            {
                daoWishlist = (DAOWishlist*)wishlist;
            }
            else
            {
                daoWishlist = [DAOWishlist dncToDAO:wishlist];
            }
            
            if (daoWishlist)
            {
                [daoWishlists addObject:daoWishlist];
            }
        }
        
        self.wishlists  = daoWishlists;
    }
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = DAOUser.user;     self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = DAOUser.user;     self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];

    return self.id ? self : nil;
}

@end
