//
//  NSMutableDictionary+daoLocationToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOLocation.h>

#import "NSMutableDictionary+daoLocationToDNC.h"

#import "NSMutableDictionary+daoPhotoToDNC.h"

@implementation NSMutableDictionary (daoLocationToDNC)

+ (instancetype)daoLocationToDNC:(DAOLocation*)object
{
    return [[NSMutableDictionary dictionary] daoLocationToDNC:object];
}

- (instancetype)daoLocationToDNC:(DAOLocation*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:[DAOLocation class]], DNCLD_DAO, @"object is not a DAOLocation");
    
    /*
    self.id         = [self idFromString:item[@"id"]];
    self.externalId = item[@"bdb_id"];

    if (item[@"bdb_id"])
    {
        self.name               = [self stringFromString:item[@"bdb_name"]];
        self.descriptionString  = [self stringFromString:item[@"bdb_description"]];
        self.website            = [self urlFromString:item[@"bdb_website"]];
    }
    else
    {
        self.name               = [self stringFromString:item[@"name"]];
        self.descriptionString  = [self stringFromString:item[@"description"]];
        self.website            = [self urlFromString:item[@"website"]];
    }
    
    self.followingFlag        = ([item[@"my_follow"] isKindOfClass:[NSDictionary class]] ? YES : NO);
    
    NSMutableDictionary*    brewery = [item[@"brewery"] mutableCopy];
    
    if (!brewery)
    {
        if (item[@"bdb_established"])
        {
            brewery  = [item mutableCopy];
        }
    }
    if (brewery)
    {
        self.externalId = brewery[@"bdb_id"];

        self.established          = brewery[@"bdb_established"];
        //self.mailingListURL       = brewery[@"bdb_mailingListURL"];
        self.organic              = brewery[@"bdb_isOrganic"];
        
        NSString*   imageLarge  = [self urlFromString:brewery[@"bdb_image_large"]];
        NSString*   imageMedium = [self urlFromString:brewery[@"bdb_image_medium"]];
        NSString*   imageIcon   = [self urlFromString:brewery[@"bdb_image_icon"]];
        
        self.images     = @{
                            @"large"    : (imageLarge  ? imageLarge : @""),
                            @"medium"   : (imageMedium ? imageMedium : @""),
                            @"icon"     : (imageIcon   ? imageIcon : @""),
                            };
    }
    
    NSMutableDictionary*    counts  = [item[@"counts"] mutableCopy];
    if (counts)
    {
        self.numFollowers     = [self numberFromString:counts[@"followers"]];
        self.numRatings       = [self numberFromString:counts[@"ratings"]];
        self.numReviews       = [self numberFromString:counts[@"reviews"]];
        self.numFavorites     = [self numberFromString:counts[@"favorites"]];
        self.numWishlists     = [self numberFromString:counts[@"wishlists"]];
        self.numCheckins      = [self numberFromString:counts[@"checkins"]];
    }
    
    NSDictionary* photo = item[@"photo"];
    if (photo)
    {
        if (photo[@"path"] && ![photo[@"path"] isEqual:[NSNull null]])
        {
            DAOPhoto*   daoPhoto   = [DAOPhoto daoToDNC:photo];
            
            self.photo    = daoPhoto;
            
            if (!self.images)
            {
                self.images   = @{
                                  @"large"    : daoPhoto.url,
                                  @"medium"   : daoPhoto.url,
                                  @"icon"     : daoPhoto.url,
                                  };
            }
        }
    }
    
    NSArray<NSDictionary* >* sites  = item[@"sites"];
    
    NSMutableArray<DAOSite* >*  daoSites = [NSMutableArray arrayWithCapacity:sites.count + 1];
    
    [sites enumerateObjectsUsingBlock:
     ^(NSDictionary* _Nonnull site, NSUInteger idx, BOOL* _Nonnull stop)
     {
         NSMutableDictionary*   siteM   = [site mutableCopy];
         siteM[@"brewery"]   = self;
         
         DAOSite*    daoSite = [DAOSite daoToDNC:siteM];
         
         if (daoSite)
         {
             [daoSites addObject:daoSite];
         }
     }];
    
    if (daoSites.count == 0)
    {
        NSMutableDictionary*   itemM   = [item mutableCopy];
        itemM[@"brewery"]   = self;
        
        DAOSite*    daoSite = [DAOSite daoToDNC:itemM];
        
        if (daoSite)
        {
            [daoSites addObject:daoSite];
        }
    }
    
    self.sites    = daoSites;
    
    [self.sites enumerateObjectsUsingBlock:
     ^(DAOSite* _Nonnull brewerySite, NSUInteger idx, BOOL* _Nonnull stop)
     {
         brewerySite.brewery  = self;
     }];
     */
     
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
