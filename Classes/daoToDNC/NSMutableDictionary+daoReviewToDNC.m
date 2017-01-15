//
//  NSMutableDictionary+daoReviewToDNC.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import <DNCDataObjects/DAOReview.h>

#import "NSMutableDictionary+daoReviewToDNC.h"

@implementation NSMutableDictionary (daoReviewToDNC)

+ (instancetype)daoReviewToDNC:(DAOReview*)object
{
    return [NSMutableDictionary.dictionary daoReviewToDNC:object];
}

- (instancetype)daoReviewToDNC:(DAOReview*)object
{
    if (!object)
    {
        return nil;
    }
    
    DNCAssert([object isKindOfClass:DAOReview.class], DNCLD_DAO, @"object is not a DAOReview");
    
    /*
    self.id        = [self idFromString:item[@"id"]];
    self.text      = [self stringFromString:item[@"review"]];

    self.ratingValue    = [self numberFromString:item[@"rating_value"]];
    if (self.ratingValue.intValue > 5)
    {
        self.ratingValue    = @5;
    }
    
    self.beerId    = [self idFromString:item[@"type_id"]];
    //self.beer      = item[@"bdb_style_category"];
    
    self.ratingId  = [self idFromString:item[@"rating_id"]];
    //self.rating    = item[@"bdb_style_category"];
    
    self.photoId   = [self idFromString:item[@"photo_id"]];
    //self.photo     = item[@"bdb_style_category"];
    
    self.userId    = [self idFromString:item[@"user_id"]];
    //self.user      = item[@"bdb_style_category"];
    */
    
    self[@"added"]      = object._created;
    self[@"modified"]   = object._updated;
    
    return self;
}

@end
