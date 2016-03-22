//
//  SRDelegate.m
//  QQSectionCopy
//
//  Created by Siren on 16/1/30.
//  Copyright © 2016年 Siren. All rights reserved.
//

#import "SRDelegate.h"

@implementation SRDelegate
-(id)initWithItems:(NSArray *)items{
    if (self = [super init]) {
        _items = items;
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",self.items[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return self.items[indexPath.row];
}
@end
