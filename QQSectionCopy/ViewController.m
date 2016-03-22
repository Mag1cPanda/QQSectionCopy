//
//  ViewController.m
//  QQSectionCopy
//
//  Created by Siren on 16/1/30.
//  Copyright © 2016年 Siren. All rights reserved.
//

#import "ViewController.h"
#import "SRSectionHeader.h"
#import "FriendsGroup.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
<UITableViewDataSource,
UITableViewDelegate,
SRSectionHeaderDelegate>
@property (nonatomic, strong) NSArray *dataList;//section数组
@property (nonatomic, strong) NSMutableArray *friendsData;//数据源
@property (nonatomic, strong) NSMutableDictionary *sectionDict;
@property (nonatomic, strong) UITableView *table;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
    self.dataList = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"_dataList ->%zi",_dataList.count);
    
    
    _friendsData = [NSMutableArray array];
    for (NSDictionary *dict in _dataList) {
        FriendsGroup *friendGroup = [FriendsGroup friendGroupWithDict:dict];
        [_friendsData addObject:friendGroup];
    }
    NSLog(@"_friendsData ->%zi",_friendsData.count);
    NSLog(@"%@",_friendsData);
    

    self.table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.sectionHeaderHeight = kHeaderHeight;
    self.table.rowHeight = 50;
    self.table.backgroundColor = [UIColor darkGrayColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
    [self.table registerClass:[SRSectionHeader class] forHeaderFooterViewReuseIdentifier:@"SRSectionHeader"];
    
    self.sectionDict = [NSMutableDictionary dictionaryWithCapacity:self.dataList.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataSource and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    SRSectionHeader *header = self.sectionDict[@(section)];
    if (header.isOpen) {
        NSDictionary *dict = self.dataList[section];
        
        NSArray *array = dict[@"friends"];
        
        return array.count;
    }
    else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    FriendsGroup *group = _friendsData[indexPath.section];
//    Friend *friend  = group.friends[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:friend.icon];
//    cell.textLabel.textColor = friend.isVip ? [UIColor redColor] : [UIColor blackColor];
//    cell.textLabel.text = friend.name;
//    cell.detailTextLabel.text = friend.intro;
    
    NSDictionary *dic = self.dataList[indexPath.section];
    NSArray *friendsArray = dic[@"friends"];
    NSDictionary *friendDic = friendsArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:friendDic[@"icon"]];
    cell.textLabel.textColor = [friendDic[@"vip"] boolValue] ? [UIColor redColor] : [UIColor blackColor];
    
//    NSLog(@"isVip ->%@",friendDic[@"vip"]);
    cell.textLabel.text = friendDic[@"name"];
    cell.detailTextLabel.text = friendDic[@"intro"];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *headerID = @"srHeader";
    SRSectionHeader *header = self.sectionDict[@(section)];
    if (!header) {
        
        header = [[SRSectionHeader alloc]initWithReuseIdentifier:headerID];
        header.delegate = self;
        //把sectionheader保存到字典中
        [self.sectionDict setObject:header forKey:@(section)];
    }
    
    
    //设置分组名
    NSDictionary *dict = self.dataList[section];
    NSString *groupname = dict[@"name"];
    [header.btn setTitle:groupname forState:0];
    [header setSection:section];
    
    return header;
}

- (void)sr_SectionHeaderDidSelectedHeader:(SRSectionHeader *)header{
    
    NSLog(@"点击分组 -> %zi",header.section);
    SRSectionHeader *srHeader = self.sectionDict[@(header.section)];
    
    BOOL isOpen = srHeader.isOpen;
    [srHeader setIsOpen:!isOpen];
    
    [self.table reloadSections:[NSIndexSet indexSetWithIndex:header.section] withRowAnimation:UITableViewRowAnimationFade];

}


@end
