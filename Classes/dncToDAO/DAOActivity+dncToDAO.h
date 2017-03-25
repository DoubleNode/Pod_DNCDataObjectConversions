//
//  DAOActivity+dncToDAO.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCDataObjects/DAOActivity.h>

@interface DAOActivity (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOCheckin*)createCheckin;
+ (DAOFavorite*)createFavorite;
+ (DAOItem*)createItem;
+ (DAOLocation*)createLocation;
+ (DAONews*)createNews;
+ (DAOPhoto*)createPhoto;
+ (DAORating*)createRating;
+ (DAOReview*)createReview;
+ (DAOUser*)createUser;
+ (DAOWishlist*)createWishlist;

@end
