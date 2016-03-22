//
//  SRDelegate.h
//  QQSectionCopy
//
//  Created by Siren on 16/1/30.
//  Copyright © 2016年 Siren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SRDelegate : NSObject<UITableViewDelegate>
@property (nonatomic, strong) NSArray *items;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (id)initWithItems:(NSArray *)items;
@end
