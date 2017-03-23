//
//  DAOConversation+dncToDAO.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

#import <DNCDataObjects/DAOConversation.h>

@interface DAOConversation (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary;
- (instancetype)dncToDAO:(NSDictionary*)dictionary;

@end