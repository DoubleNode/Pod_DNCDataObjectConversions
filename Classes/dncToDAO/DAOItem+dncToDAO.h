//
//  DAOItem+dncToDAO.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
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
