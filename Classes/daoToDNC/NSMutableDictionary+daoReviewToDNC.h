//
//  NSMutableDictionary+daoReviewToDNC.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2016/10/16.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//

@import UIKit;

@class DAOReview;

@interface NSMutableDictionary (daoReviewToDNC)

+ (instancetype)daoReviewToDNC:(DAOReview*)object;
- (instancetype)daoReviewToDNC:(DAOReview*)object;

@end
