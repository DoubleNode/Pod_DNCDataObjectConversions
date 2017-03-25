//
//  DAOItem+dncToDAO.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCDataObjects/DAOItem.h>

@interface DAOItem (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOCategory*)createCategory;
+ (DAOFavorite*)createFavorite;
+ (DAOFollow*)createFollow;
+ (DAOLocation*)createLocation;
+ (DAOPhoto*)createPhoto;
+ (DAORating*)createRating;
+ (DAOReview*)createReview;
+ (DAOUser*)createUser;
+ (DAOWishlist*)createWishlist;

@end
