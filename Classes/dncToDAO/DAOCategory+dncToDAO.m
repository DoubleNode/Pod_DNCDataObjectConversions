//
//  DAOCategory+dncToDAO.m
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCore;

#import "DAOCategory+dncToDAO.h"

#import "DAOFavorite+dncToDAO.h"
#import "DAOFollow+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOPhoto+dncToDAO.h"
#import "DAORating+dncToDAO.h"
#import "DAOReview+dncToDAO.h"
#import "DAOUser+dncToDAO.h"
#import "DAOWishlist+dncToDAO.h"

@implementation DAOCategory (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOCategory.category dncToDAO:dictionary];
}

+ (DAOFavorite*)createFavorite
{
    return DAOFavorite.favorite;
}

+ (DAOFollow*)createFollow
{
    return DAOFollow.follow;
}

+ (DAOItem*)createItem
{
    return DAOItem.item;
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
    
    self.id     = [self idFromString:dictionary[@"id"]];

    self.title              = [self idFromString:dictionary[@"title"]];
    self.descriptionString  = [self idFromString:dictionary[@"description"]];
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
        self.numFlags           = [self numberFromString:counts[@"flags"]];
        self.numFollowers       = [self numberFromString:counts[@"followers"]];
        self.numItems           = [self numberFromString:counts[@"items"]];
        self.numRatings         = [self numberFromString:counts[@"ratings"]];
        self.numReviews         = [self numberFromString:counts[@"reviews"]];
        self.numTags            = [self numberFromString:counts[@"tags"]];
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
                daoItem = [self.class.createItem dncToDAO:item];
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
                daoLocation = [self.class.createLocation dncToDAO:location];
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
            photos = @[ (NSDictionary*)photos ];
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
                daoWishlist = [self.class.createWishlist dncToDAO:wishlist];
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
    self._createdBy = self.class.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.class.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];

    return self.id ? self : nil;
}

@end
