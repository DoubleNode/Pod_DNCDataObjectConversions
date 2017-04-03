//
//  DAOConversation+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOConversation+dncToDAO.h"

#import "DAOCategory+dncToDAO.h"
#import "DAOItem+dncToDAO.h"
#import "DAOLocation+dncToDAO.h"
#import "DAOUser+dncToDAO.h"

@implementation DAOConversation (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOConversation.conversation dncToDAO:dictionary];
}

+ (DAOCategory*)createCategory
{
    return DAOCategory.category;
}

+ (DAOItem*)createItem
{
    return DAOItem.item;
}

+ (DAOLocation*)createLocation
{
    return DAOLocation.location;
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

    NSDictionary*   members = dictionary[@"members"];
    
    {
        NSArray<NSDictionary* >* categories  = members[@"categories"];
        
        NSMutableArray<DAOCategory* >*  daoCategories = [NSMutableArray arrayWithCapacity:categories.count];
        
        for (NSDictionary* category in categories)
        {
            DAOCategory*    daoCategory;
            
            if ([category isKindOfClass:DAOCategory.class])
            {
                daoCategory = (DAOCategory*)category;
            }
            else
            {
                daoCategory = [self.class.createCategory dncToDAO:category];
            }
            
            if (daoCategory)
            {
                [daoCategories addObject:daoCategory];
            }
        }
        
        self.categories  = daoCategories;
    }
    
    {
        NSArray<NSDictionary* >* items  = members[@"items"];
        
        NSMutableArray<DAOItem* >*  daoItems = [NSMutableArray arrayWithCapacity:items.count];
        
        for (NSDictionary* item in items)
        {
            DAOItem*    daoItem;
            
            if ([item isKindOfClass:DAOItem.class])
            {
                daoItem = (DAOItem*)item;
            }
            else
            {
                daoItem = [self.class.createItem dncToDAO:item];
            }
            
            if (daoItem)
            {
                [daoItems addObject:daoItem];
            }
        }
        
        self.items  = daoItems;
    }
    
    {
        NSArray<NSDictionary* >* locations  = members[@"locations"];
        
        NSMutableArray<DAOLocation* >*  daoLocations = [NSMutableArray arrayWithCapacity:locations.count];
        
        for (NSDictionary* location in locations)
        {
            DAOLocation*    daoLocation;
            
            if ([location isKindOfClass:DAOLocation.class])
            {
                daoLocation = (DAOLocation*)location;
            }
            else
            {
                daoLocation = [self.class.createLocation dncToDAO:location];
            }
            
            if (daoLocation)
            {
                [daoLocations addObject:daoLocation];
            }
        }
        
        self.locations  = daoLocations;
    }
    
    {
        NSArray<NSDictionary* >* users  = members[@"users"];
        
        NSMutableArray<DAOUser* >*  daoUsers = [NSMutableArray arrayWithCapacity:users.count];
        
        for (NSDictionary* user in users)
        {
            DAOUser*    daoUser;
            
            if ([user isKindOfClass:DAOUser.class])
            {
                daoUser = (DAOUser*)user;
            }
            else
            {
                daoUser = [self.class.createUser dncToDAO:user];
            }
            
            if (daoUser)
            {
                [daoUsers addObject:daoUser];
            }
        }
        
        self.users  = daoUsers;
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
