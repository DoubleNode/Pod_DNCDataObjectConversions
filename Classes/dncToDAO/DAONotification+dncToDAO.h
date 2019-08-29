//
//  DAONotification+dncToDAO.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

#import <DNCDataObjects/DAONotification.h>

@class DAOCategory;
@class DAOItem;
@class DAOLocation;

@interface DAONotification (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOCategory*)createCategory;
+ (DAOItem*)createItem;
+ (DAOLocation*)createLocation;
+ (DAOUser*)createUser;

@end
