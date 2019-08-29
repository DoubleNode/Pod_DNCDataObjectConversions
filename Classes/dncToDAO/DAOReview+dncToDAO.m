//
//  DAOReview+dncToDAO.m
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

@import DNCore;

#import "DAOReview+dncToDAO.h"

#import "DAOPhoto+dncToDAO.h"
#import "DAORating+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOReview (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
   return [DAOReview.review dncToDAO:dictionary];
}

+ (DAOPhoto*)createPhoto
{
    return DAOPhoto.photo;
}

+ (DAORating*)createRating
{
    return DAORating.rating;
}

+ (DAOUser*)createUser
{
    return DAOUser.user;
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id        = [self idFromString:dictionary[@"id"]];
    self.text      = [self stringFromString:dictionary[@"review"]];

    self.ratingValue    = [self numberFromString:dictionary[@"rating_value"]];
    if (self.ratingValue.intValue > 5)
    {
        self.ratingValue    = @5;
    }
    
    self.ratingId  = [self idFromString:dictionary[@"rating_id"]];
    self.photoId   = [self idFromString:dictionary[@"photo_id"]];
    self.userId    = [self idFromString:dictionary[@"user_id"]];
    
    if (!self.photos.count)
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
            daoPhoto.review  = self;
        }
    }
    
    if (!self.ratings.count)
    {
        NSArray<NSDictionary* >*    ratings = dictionary[@"ratings"];
        
        NSMutableArray<DAORating* >* daoRatings = [NSMutableArray arrayWithCapacity:ratings.count];
        
        NSMutableDictionary<NSString*, DAORating* >* daoKeyedRatings = NSMutableDictionary.dictionary;

        if ([ratings isKindOfClass:NSDictionary.class])
        {
            ratings = @[ (NSDictionary*)ratings ];
        }
        if (ratings)
        {
            for (NSDictionary* rating in ratings)
            {
                DAORating*   daoRating = [self.class.createRating dncToDAO:rating];
                if (daoRating)
                {
                    [daoRatings addObject:daoRating];
                    daoKeyedRatings[daoRating.ratingType] = daoRating;
                }
            }
        }
        
        self.ratings        = daoRatings;
        self.keyedRatings   = daoKeyedRatings;
        
        for (DAORating* daoRating in self.ratings)
        {
            daoRating.review  = self;
        }
    }
    
    NSString*   type    = [self stringFromString:dictionary[@"type"]];
    
    if ([type isEqualToString:@"item"])
    {
        self.itemId = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"location"])
    {
        self.locationId = [self idFromString:dictionary[@"type_id"]];
    }
    else if ([type isEqualToString:@"user"])
    {
        self.userId = [self idFromString:dictionary[@"type_id"]];
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
