//
//  FriendsGroup.m
//  QQSectionCopy
//
//  Created by Siren on 16/1/30.
//  Copyright © 2016年 Siren. All rights reserved.
//

#import "FriendsGroup.h"

@implementation FriendsGroup
+(instancetype)friendGroupWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        _friends = [NSMutableArray array];
        for (NSDictionary *dict in _friends) {
            Friend *friend = [Friend friendWithDict:dict];
            [_friends addObject:friend];
        }
    }
    return self;
}

@end
