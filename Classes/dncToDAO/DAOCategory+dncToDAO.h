//
//  DAOCategory+dncToDAO.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCDataObjects/DAOCategory.h>

@interface DAOCategory (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOFavorite*)createFavorite;
+ (DAOFollow*)createFollow;
+ (DAOItem*)createItem;
+ (DAOLocation*)createLocation;
+ (DAOPhoto*)createPhoto;
+ (DAORating*)createRating;
+ (DAOReview*)createReview;
+ (DAOUser*)createUser;
+ (DAOWishlist*)createWishlist;

@end
