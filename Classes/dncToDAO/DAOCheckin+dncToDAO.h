//
//  DAOCheckin+dncToDAO.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

#import <DNCDataObjects/DAOCheckin.h>

@interface DAOCheckin (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOItem*)createItem;
+ (DAOLocation*)createLocation;
+ (DAOUser*)createUser;

@end
