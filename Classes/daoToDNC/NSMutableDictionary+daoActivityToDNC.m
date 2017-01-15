//
//  NSMutableDictionary+daoActivityToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOActivity.h>
#import <DNCDataObjects/DAOCheckin.h>
#import <DNCDataObjects/DAOFavorite.h>
#import <DNCDataObjects/DAOItem.h>
#import <DNCDataObjects/DAOLocation.h>
#import <DNCDataObjects/DAONews.h>
#import <DNCDataObjects/DAOPhoto.h>
#import <DNCDataObjects/DAORating.h>
#import <DNCDataObjects/DAOReview.h>
#import <DNCDataObjects/DAOWishlist.h>

#import "NSMutableDictionary+daoActivityToDNC.h"

#import "NSMutableDictionary+daoCheckinToDNC.h"
#import "NSMutableDictionary+daoFavoriteToDNC.h"
#import "NSMutableDictionary+daoItemToDNC.h"
#import "NSMutableDictionary+daoLocationToDNC.h"
#import "NSMutableDictionary+daoNewsToDNC.h"
#import "NSMutableDictionary+daoPhotoToDNC.h"
#import "NSMutableDictionary+daoRatingToDNC.h"
#import "NSMutableDictionary+daoReviewToDNC.h"
#import "NSMutableDictionary+daoWishlistToDNC.h"

@implementation NSMutableDictionary (daoActivityToDNC)

+ (instancetype)daoActivityToDNC:(DAOActivity*)object
{
    return [NSMutableDictionary.dictionary daoActivityToDNC:object];
}

- (instancetype)daoActivityToDNC:(DAOActivity*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAOActivity.class], DNCLD_DAO, @"object is not a DAOActivity");
    
    self[@"id"]         = object.id;
    self[@"activity"]   = object.code;
    self[@"type"]       = object.type;

    NSMutableDictionary*    data    = NSMutableDictionary.dictionary;
    
    if ([object.code isEqualToString:kActivityCodeCheckin])
    {
        [data daoCheckinToDNC:object.checkin];
        
        self[@"type_id"]        = object.checkin.id;
        self[@"checkin_id"]     = object.checkin.id;
        self[@"location_id"]    = object.checkin.locationId;
        self[@"photo_id"]       = object.checkin.photoId;
        self[@"user_id"]        = object.checkin.userId;
    }
    else if ([object.code isEqualToString:kActivityCodeFavorite])
    {
        [data daoFavoriteToDNC:object.favorite];

        self[@"type_id"]        = object.favorite.id;
        self[@"favorite_id"]    = object.favorite.id;
        self[@"user_id"]        = data[@"user_id"];

        if ([self[@"type"] isEqualToString:kActivityTypeItem])
        {
            self[@"item_id"]    = data[@"item_id"];
        }
        else if ([self[@"type"] isEqualToString:kActivityTypeLocation])
        {
            self[@"location_id"]    = data[@"location_id"];
        }
        else if ([self[@"type"] isEqualToString:kActivityTypeNews])
        {
            self[@"news_id"]    = data[@"news_id"];
        }
        else if ([self[@"type"] isEqualToString:kActivityTypePhoto])
        {
            self[@"photo_id"]   = data[@"photo_id"];
        }
    }
    else if ([object.code isEqualToString:kActivityCodeItemCreated])
    {
        [data daoItemToDNC:object.item];
        
        self[@"type_id"]    = object.item.id;
        self[@"item_id"]    = object.item.id;
    }
    else if ([object.code isEqualToString:kActivityCodeLocationCreated])
    {
        [data daoLocationToDNC:object.location];
        
        self[@"type_id"]        = object.location.id;
        self[@"location_id"]    = object.location.id;
    }
    else if ([object.code isEqualToString:kActivityCodeNewsCreated])
    {
        [data daoNewsToDNC:object.news];
        
        self[@"type_id"]    = object.news.id;
        self[@"news_id"]    = object.news.id;
    }
    else if ([object.code isEqualToString:kActivityCodeNewsUpdated])
    {
        [data daoNewsToDNC:object.news];
        
        self[@"type_id"]    = object.news.id;
        self[@"news_id"]    = object.news.id;
    }
    else if ([object.code isEqualToString:kActivityCodePhoto])
    {
        [data daoPhotoToDNC:object.photo];
        
        self[@"type_id"]        = object.photo.id;
        self[@"photo_id"]       = object.photo.id;

        self[@"item_id"]        = object.photo.itemId;
        self[@"location_id"]    = object.photo.locationId;
        self[@"review_id"]      = object.photo.reviewId;
        self[@"user_id"]        = object.photo.userId;
    }
    else if ([object.code isEqualToString:kActivityCodeRating])
    {
        [data daoRatingToDNC:object.rating];
        
        self[@"type_id"]    = object.rating.id;
        self[@"rating_id"]  = object.rating.id;
        
        self[@"item_id"]    = object.rating.itemId;
        self[@"user_id"]    = object.rating.userId;
    }
    else if ([object.code isEqualToString:kActivityCodeReview])
    {
        [data daoReviewToDNC:object.review];
        
        self[@"type_id"]    = object.review.id;
        self[@"rating_id"]  = object.review.id;
        
        self[@"item_id"]    = object.review.itemId;
        self[@"photo_id"]   = object.review.photoId;
        self[@"user_id"]    = object.review.userId;
    }
    else if ([object.code isEqualToString:kActivityCodeWishlist])
    {
        [data daoWishlistToDNC:object.wishlist];
        
        self[@"type_id"]        = object.wishlist.id;
        self[@"wishlist_id"]    = object.wishlist.id;

        self[@"item_id"]    = object.review.itemId;
        self[@"user_id"]    = object.review.userId;
    }
    else
    {
        DNCLog(DNCLL_Error, DNCLD_General, @"Unrecognized Activity code");
    }
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
