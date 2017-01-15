//
//  DAOLocation+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOLocation+dncToDAO.h"

#import "DAOPhoto+dncToDAO.h"
#import "DAOSocialAccount+dncToDAO.h"

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
    
    NSMutableArray<DAOPhoto* >* daoPhotos = [NSMutableArray array];

    NSDictionary* photoDictionary = dictionary[@"photo"];
    if (photoDictionary)
    {
        if (photoDictionary[@"path"] && ![photoDictionary[@"path"] isEqual:[NSNull null]])
        {
            DAOPhoto*   daoPhoto   = [DAOPhoto dncToDAO:photoDictionary];
            if (daoPhoto)
            {
                [daoPhotos addObject:daoPhoto];
            }
        }
    }
    
    self.photos = daoPhotos;

    for (DAOPhoto* daoPhoto in self.photos)
    {
        daoPhoto.location   = self;
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
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    
    return self.id ? self : nil;
}

@end
