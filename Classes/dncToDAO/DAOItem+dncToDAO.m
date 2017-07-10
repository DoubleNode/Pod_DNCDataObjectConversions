//
//  DAOItem+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOItem+dncToDAO.h"

#import "DAOCategory+dncToDAO.h"
#import "DAOFavorite+dncToDAO.h"
#import "DAOFollow+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOPhoto+dncToDAO.h"
#import "DAORating+dncToDAO.h"
#import "DAOReview+dncToDAO.h"
#import "DAOUser+dncToDAO.h"
#import "DAOWishlist+dncToDAO.h"

@implementation DAOItem (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOItem.item dncToDAO:dictionary];
}

+ (DAOCategory*)createCategory
{
    return DAOCategory.category;
}

+ (DAOFavorite*)createFavorite
{
    return DAOFavorite.favorite;
}

+ (DAOFollow*)createFollow
{
    return DAOFollow.follow;
}

+ (DAOLocation*)createLocation
{
    return DAOLocation.location;
}

+ (DAOPhoto*)createPhoto
{
    return DAOPhoto.photo;
}

+ (DAORating*)createRating
{
    return DAORating.rating;
}

+ (DAOReview*)createReview
{
    return DAOReview.review;
}

+ (DAOUser*)createUser
{
    return DAOUser.user;
}

+ (DAOWishlist*)createWishlist
{
    return DAOWishlist.wishlist;
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id                 = [self idFromString:dictionary[@"id"]];
    self.type               = [self idFromString:dictionary[@"type"]];
    self.name               = [self stringFromString:dictionary[@"name"]];
    self.descriptionString  = [self stringFromString:dictionary[@"description"]];
    self.rating             = [self numberFromString:dictionary[@"rating"]];
    
    id  photo = dictionary[@"photo"];
    if (photo && (photo != NSNull.null))
    {
        self.defaultPhoto   = [self.class.createPhoto dncToDAO:photo];
    }
    
    {
        NSMutableDictionary*    counts  = [dictionary[@"counts"] mutableCopy];
        
        self.numCheckins        = [self numberFromString:counts[@"checkins"]];
        self.numFavorites       = [self numberFromString:counts[@"favorites"]];
        self.numFollowers       = [self numberFromString:counts[@"followers"]];
        self.numRatings         = [self numberFromString:counts[@"ratings"]];
        self.numReviews         = [self numberFromString:counts[@"reviews"]];
        self.numWishlists       = [self numberFromString:counts[@"wishlists"]];
    }
    
    self.myFavorite         = [self.class.createFavorite dncToDAO:dictionary[@"my_favorite"]];
    self.myFollow           = [self.class.createFollow dncToDAO:dictionary[@"my_follow"]];
    self.myRating           = [self.class.createRating dncToDAO:dictionary[@"my_rating"]];
    self.myReview           = [self.class.createReview dncToDAO:dictionary[@"my_review"]];
    self.myWishlist         = [self.class.createWishlist dncToDAO:dictionary[@"my_wishlist"]];
    
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
    
    {
        NSArray<NSDictionary* >* categories  = dictionary[@"categories"];
        
        NSMutableArray<DAOCategory* >*  daoCategories = [NSMutableArray arrayWithCapacity:categories.count];
        
        for (NSDictionary* category in categories)
        {
            DAOCategory*    daoCategory;
            
            if ([category isKindOfClass:DAOCategory.class])
            {
                daoCategory = (DAOCategory*)category;
            }
            else
            {
                daoCategory = [self.class.createCategory dncToDAO:category];
            }
            
            if (daoCategories)
            {
                [daoCategories addObject:daoCategory];
            }
        }
        
        self.categories  = daoCategories;
    }
    
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
                daoFavorite = [self.class.createFavorite dncToDAO:favorite];
            }
            
            if (daoFavorite)
            {
                [daoFavorites addObject:daoFavorite];
            }
        }
        
        self.favorites  = daoFavorites;
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
                daoLocation = [self.class.createLocation dncToDAO:location];
            }
            
            if (daoLocation)
            {
                [daoLocations addObject:daoLocation];
            }
        }
        
        self.locations  = daoLocations;
    }
    
    if (!self.photos.count)
    {
        NSArray<NSDictionary* >*    photos = dictionary[@"photo"];
        
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
                    DAOPhoto*   daoPhoto   = [self.class.createPhoto dncToDAO:photo];
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
            daoPhoto.item  = self;
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
                daoWishlist = [self.class.createWishlist dncToDAO:wishlist];
            }
            
            if (daoWishlist)
            {
                [daoWishlists addObject:daoWishlist];
            }
        }
        
        self.wishlists  = daoWishlists;
    }
    
    self._status    = [self stringFromString:dictionary[@"status"]];
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = self.class.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.class.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];
    
    return self.id ? self : nil;
}

@end
