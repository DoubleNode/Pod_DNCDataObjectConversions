//
//  DAOActivity+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOActivity+dncToDAO.h"

#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOCheckin+dncToDAO.h"
#import "DAOFavorite+dncToDAO.h"
#import "DAONews+dncToDAO.h"
#import "DAOPhoto+dncToDAO.h"
#import "DAORating+dncToDAO.h"
#import "DAOReview+dncToDAO.h"
#import "DAOWishlist+dncToDAO.h"

@implementation DAOActivity (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [[DAOActivity activity] dncToDAO:dictionary];
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id         = [self idFromString:dictionary[@"id"]];
    self.code       = [self stringFromString:dictionary[@"activity"]];
    self.type       = [self stringFromString:dictionary[@"type"]];
    
    id  data    = dictionary[@"data"];
    
    if ([self.code isEqualToString:kActivityCodeCheckin])
    {
        DAOCheckin* daoCheckin  = [DAOCheckin dncToDAO:data];
        
        self.typeId     = daoCheckin.id;
        self.checkinId  = daoCheckin.id;
        self.checkin    = daoCheckin;
        
        self.locationId = daoCheckin.locationId;
        self.location   = daoCheckin.location;
        
        self.photoId    = daoCheckin.photoId;
        self.photo      = daoCheckin.photo;
        
        self.userId     = daoCheckin.userId;
        self.user       = daoCheckin.user;
    }
    else if ([self.code isEqualToString:kActivityCodeFavorite])
    {
        DAOFavorite*    daoFavorite = [DAOFavorite dncToDAO:data];
        
        self.typeId      = daoFavorite.id;
        self.favoriteId  = daoFavorite.id;
        self.favorite    = daoFavorite;
        
        if ([self.type isEqualToString:kActivityTypeItem])
        {
            self.itemId = daoFavorite.itemId;
            self.item   = daoFavorite.item;
        }
        else if ([self.type isEqualToString:kActivityTypeLocation])
        {
            self.locationId = daoFavorite.locationId;
            self.location   = daoFavorite.location;
        }
        else if ([self.type isEqualToString:kActivityTypeNews])
        {
            self.newsId     = daoFavorite.newsId;
            self.news       = daoFavorite.news;
        }
        else if ([self.type isEqualToString:kActivityTypePhoto])
        {
            self.photoId    = daoFavorite.photoId;
            self.photo      = daoFavorite.photo;
        }
        
        self.userId      = daoFavorite.userId;
        self.user        = daoFavorite.user;
    }
    else if ([self.code isEqualToString:kActivityCodeItemCreated])
    {
        DAOItem*    daoItem = [DAOItem dncToDAO:data];
        
        self.typeId = daoItem.id;
        
        self.itemId = daoItem.id;
        self.item   = daoItem;
    }
    else if ([self.code isEqualToString:kActivityCodeLocationCreated])
    {
        DAOLocation*    daoLocation = [DAOLocation dncToDAO:data];
        
        self.typeId     = daoLocation.id;
        
        self.locationId = daoLocation.id;
        self.location   = daoLocation;
    }
    else if ([self.code isEqualToString:kActivityCodeNewsCreated])
    {
        DAONews*    daoNews = [DAONews dncToDAO:data];
        
        self.typeId     = daoNews.id;
        self.newsId     = daoNews.id;
        self.news       = daoNews;
    }
    else if ([self.code isEqualToString:kActivityCodeNewsUpdated])
    {
        DAONews*    daoNews = [DAONews dncToDAO:data];
        
        self.typeId     = daoNews.id;
        self.newsId     = daoNews.id;
        self.news       = daoNews;
    }
    else if ([self.code isEqualToString:kActivityCodePhoto])
    {
        DAOPhoto*   daoPhoto    = [DAOPhoto dncToDAO:data];
        
        self.typeId     = daoPhoto.id;
        self.photoId    = daoPhoto.id;
        self.photo      = daoPhoto;
        
        self.itemId     = daoPhoto.itemId;
        self.item       = daoPhoto.item;
        
        self.locationId = daoPhoto.locationId;
        self.location   = daoPhoto.location;
        
        self.reviewId   = daoPhoto.reviewId;
        self.review     = daoPhoto.review;
        
        self.userId     = daoPhoto.userId;
        self.user       = daoPhoto.user;
    }
    else if ([self.code isEqualToString:kActivityCodeRating])
    {
        DAORating*  daoRating   = [DAORating dncToDAO:data];
        
        self.typeId     = daoRating.id;
        self.ratingId   = daoRating.id;
        self.rating     = daoRating;
        
        self.itemId     = daoRating.itemId;
        self.item       = daoRating.item;
        
        self.userId     = daoRating.userId;
        self.user       = daoRating.user;
    }
    else if ([self.code isEqualToString:kActivityCodeReview])
    {
        DAOReview*  daoReview   = [DAOReview dncToDAO:data];
        
        self.typeId     = daoReview.id;
        self.reviewId   = daoReview.id;
        self.review     = daoReview;
        
        self.itemId     = daoReview.itemId;
        self.item       = daoReview.item;
        
        self.photoId    = daoReview.photoId;
        self.photo      = daoReview.photo;
        
        self.userId     = daoReview.userId;
        self.user       = daoReview.user;
    }
    else if ([self.code isEqualToString:kActivityCodeWishlist])
    {
        DAOWishlist*    daoWishlist = [DAOWishlist dncToDAO:data];
        
        self.typeId     = daoWishlist.id;
        self.wishlistId = daoWishlist.id;
        self.wishlist   = daoWishlist;
        
        self.itemId     = daoWishlist.itemId;
        self.item       = daoWishlist.item;
        
        self.userId     = daoWishlist.userId;
        self.user       = daoWishlist.user;
    }
    else
    {
        DNCLog(DNCLL_Error, DNCLD_General, @"Unrecognized Activity code");
    }
    
    NSMutableDictionary*    counts  = [dictionary[@"counts"] mutableCopy];
    
    self.numFavorites   = [self numberFromString:counts[@"favorites"]];
    
    self.myFavorite     = [DAOFavorite dncToDAO:dictionary[@"my_favorite"]];
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    
    return self.id ? self : nil;
}

@end
