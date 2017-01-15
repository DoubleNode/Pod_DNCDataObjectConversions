//
//  DAOAuth+dncToDAO.m
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import DNCore;

#import "DAOAuth+dncToDAO.h"

#import "DAOUser+dncToDAO.h"

@implementation DAOAuth (dncToDAO)

+ (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    return [DAOAuth.auth dncToDAO:dictionary];
}

- (instancetype)dncToDAO:(NSDictionary*)dictionary
{
    if (!dictionary || [dictionary isKindOfClass:NSNull.class])
    {
        return nil;
    }
    
    DNCAssert([dictionary isKindOfClass:NSDictionary.class], DNCLD_DAO, @"dictionary is not a NSDictionary");
    
    self.id         = [self idFromString:dictionary[@"user"][@"id"]];

    self.type       = [self stringFromString:dictionary[@"type"]];
    self.token      = [self stringFromString:dictionary[@"token"]];

    self.bucketId   = [self idFromString:dictionary[@"bucketId"]];
    self.bucketName = [self stringFromString:dictionary[@"bucketName"]];

    self.accountId          = [self idFromString:dictionary[@"accountId"]];
    self.apiUrl             = [self urlFromString:dictionary[@"apiUrl"]];
    self.downloadUrl        = [self urlFromString:dictionary[@"downloadUrl"]];
    self.minimumPartSize    = [self numberFromString:dictionary[@"minimumPartSize"]];

    self.user       = [DAOUser dncToDAO:dictionary[@"user"]];
    self.userId     = self.user.id;
    
    self._status    = @"success";
    self._created   = [self timeFromString:dictionary[@"added"]];
    self._synced    = NSDate.date;
    self._updated   = [self timeFromString:dictionary[@"modified"]];

    return self.id ? self : nil;
}

@end
