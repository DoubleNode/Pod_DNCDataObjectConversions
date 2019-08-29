//
//  DAOMessage+dncToDAO.h
//  DoubleNode Dsta Object Conversions
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC.
//
//  DNCDataObjectConversions is released under the MIT license. See LICENSE for details.
//

#import <DNCDataObjects/DAOMessage.h>

@interface DAOMessage (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

+ (DAOCategory*)createCategory;
+ (DAOConversation*)createConversation;
+ (DAOItem*)createItem;
+ (DAOLocation*)createLocation;
+ (DAOPhoto*)createPhoto;
+ (DAOUser*)createUser;

@end
