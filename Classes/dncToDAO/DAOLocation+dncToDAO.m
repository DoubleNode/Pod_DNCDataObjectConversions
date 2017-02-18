//
//  DAOLocation+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;
#import <DNCDataObjects/DAOUser.h>

#import "DAOLocation+dncToDAO.h"

#import "DAOCategory+dncToDAO.h"
#import "DAOFavorite+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOPhoto+dncToDAO.h"
#import "DAOSocialAccount+dncToDAO.h"
#import "DAOWishlist+dncToDAO.h"

@implementation DAOLocation (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOLocation.location dncToDAO:dictionary];
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id         = [self idFromString:dictionary[@"id"]];
    self.externalId = dictionary[@"bdb_id"];

    if (dictionary[@"bdb_id"])
    {
        self.name               = [self stringFromString:dictionary[@"bdb_name"]];
        self.descriptionString  = [self stringFromString:dictionary[@"bdb_description"]];
        self.website            = [self urlFromString:dictionary[@"bdb_website"]];
    }
    else
    {
        self.name               = [self stringFromString:dictionary[@"name"]];
        self.descriptionString  = [self stringFromString:dictionary[@"description"]];
        self.website            = [self urlFromString:dictionary[@"website"]];
    }
    self.rating     = [self numberFromString:dictionary[@"rating"]];
    
    self.followingFlag        = ([dictionary[@"my_follow"] isKindOfClass:NSDictionary.class] ? YES : NO);
    
    NSMutableDictionary*    counts  = [dictionary[@"counts"] mutableCopy];
    if (counts)
    {
        self.numFollowers     = [self numberFromString:counts[@"followers"]];
        self.numRatings       = [self numberFromString:counts[@"ratings"]];
        self.numReviews       = [self numberFromString:counts[@"reviews"]];
        self.numFavorites     = [self numberFromString:counts[@"favorites"]];
        self.numWishlists     = [self numberFromString:counts[@"wishlists"]];
        self.numCheckins      = [self numberFromString:counts[@"checkins"]];
    }
    
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
                daoCategory = [DAOCategory dncToDAO:category];
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
            daoPhoto.location  = self;
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
    
    NSArray<NSDictionary* >* socialAccounts = dictionary[@"socialAccounts"];
    
    NSMutableArray<DAOSocialAccount* >* daoSocialAccounts = [NSMutableArray arrayWithCapacity:socialAccounts.count];
    
    for (NSDictionary* socialAccount in socialAccounts)
    {
        DAOSocialAccount*   daoSocialAccount;
        
        if ([socialAccount isKindOfClass:DAOSocialAccount.class])
        {
            daoSocialAccount = (DAOSocialAccount*)socialAccount;
        }
        else
        {
            daoSocialAccount = [DAOSocialAccount dncToDAO:socialAccount];
        }
        
        if (daoSocialAccount)
        {
            [daoSocialAccounts addObject:daoSocialAccount];
        }
    }
    
    self.socialAccounts  = daoSocialAccounts;
    
    self._status    = [self stringFromString:dictionary[@"status"]];
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = DAOUser.user;     self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = DAOUser.user;     self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];
    
    return self.id ? self : nil;
}

@end
