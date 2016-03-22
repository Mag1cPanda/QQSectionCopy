//
//  FriendsGroup.h
//  QQSectionCopy
//
//  Created by Siren on 16/1/30.
//  Copyright © 2016年 Siren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"
@interface FriendsGroup : NSObject
@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger online;

+(instancetype)friendGroupWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
