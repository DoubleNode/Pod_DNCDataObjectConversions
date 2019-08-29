//
//  DAOReview+dncToDAO.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

#import <DNCDataObjects/DAOReview.h>

@class DAOPhoto;
@class DAORating;
@class DAOUser;

@interface DAOReview (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOPhoto*)createPhoto;
+ (DAORating*)createRating;
+ (DAOUser*)createUser;

@end
