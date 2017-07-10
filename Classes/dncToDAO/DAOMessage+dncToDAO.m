//
//  DAOMessage+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOMessage+dncToDAO.h"

#import "DAOCategory+dncToDAO.h"
#import "DAOConversation+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOPhoto+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOMessage (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOMessage.message dncToDAO:dictionary];
}

+ (DAOCategory*)createCategory
{
    return DAOCategory.category;
}

+ (DAOConversation*)createConversation
{
    return DAOConversation.conversation;
}

+ (DAOItem*)createItem
{
    return DAOItem.item;
}

+ (DAOLocation*)createLocation
{
    return DAOLocation.location;
}

+ (DAOPhoto*)createPhoto
{
    return DAOPhoto.photo;
}

+ (DAOUser*)createUser
{
    return DAOUser.user;
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id = [self idFromString:dictionary[@"id"]];

    NSString*   conversationId  = [self idFromString:dictionary[@"conversation_id"]];
    
    if (conversationId.length)
    {
        self.conversation   = [self.class.createConversation dncToDAO:@{
                                                                        @"id" : conversationId,
                                                                        }];
    }
    
    self.subject    = [self stringFromString:dictionary[@"subject"]];
    self.message    = [self stringFromString:dictionary[@"message"]];
    self.type       = [self stringFromString:dictionary[@"message_type"]];

    if (!self.photos.count)
    {
        NSArray<NSDictionary* >*    photos = dictionary[@"photo"];
        
        NSMutableArray<DAOPhoto* >* daoPhotos = [NSMutableArray arrayWithCapacity:photos.count];
        
        if ([photos isKindOfClass:NSDictionary.class])
        {
            photos = @[ photos ];
        }
        if (photos)
        {
            for (NSDictionary* photo in photos)
            {
                if (photo[@"path"] && ![photo[@"path"] isEqual:NSNull.null])
                {
                    DAOPhoto*   daoPhoto   = [self.class.createPhoto dncToDAO:photo];
                    if (daoPhoto)
                    {
                        [daoPhotos addObject:daoPhoto];
                    }
                }
            }
        }
        
        self.photos = daoPhotos;
        
        for (DAOPhoto* daoPhoto in self.photos)
        {
            daoPhoto.message = self;
        }
    }
    
    NSString*   fromType    = [self stringFromString:dictionary[@"from_type"]];
    NSString*   fromId      = [self idFromString:dictionary[@"from_type_id"]];
    
    if ([fromType isEqualToString:@"category"])
    {
        self.fromCategory   = [self.class.createCategory dncToDAO:@{
                                                                    @"id" : fromId,
                                                                    }];
        self.fromCategory._created  = nil;
    }
    else if ([fromType isEqualToString:@"item"])
    {
        self.fromItem   = [self.class.createItem dncToDAO:@{
                                                            @"id" : fromId,
                                                            }];
        self.fromItem._created  = nil;
    }
    else if ([fromType isEqualToString:@"location"])
    {
        self.fromLocation   = [self.class.createLocation dncToDAO:@{
                                                                    @"id" : fromId,
                                                                    }];
        self.fromLocation._created  = nil;
    }
    else if ([fromType isEqualToString:@"user"])
    {
        self.fromUser   = [self.class.createUser dncToDAO:@{
                                                            @"id" : fromId,
                                                            }];
        self.fromUser._created  = nil;
    }
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._createdBy = self.class.createUser;  self._createdBy.id  = [self stringFromString:dictionary[@"added_by"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];
    self._updatedBy = self.class.createUser;  self._updatedBy.id  = [self stringFromString:dictionary[@"modified_by"]];

    return self.id ? self : nil;
}

@end
