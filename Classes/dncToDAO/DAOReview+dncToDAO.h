//
//  DAOReview+dncToDAO.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
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
