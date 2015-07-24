//
//  HelpViewController.m
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpContentViewController.h"

@interface HelpViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
{
    int folder[100];
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel *cellLabel;
@property (nonatomic, strong) NSArray *itemsArray;


@end

@implementation HelpViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataArray = @[@"1.如何注册八爱？", @"2.忘记密码怎么办？", @"3.可以有哪些方式登录八爱？", @"4.账号被盗怎么办？", @"5.八爱付款方式",@"6.忘记支付密码如何找回？",@"7.八爱币兑换规则？"];
    
    _itemsArray = @[@"第一步：点击“我”，点击“登录”，进入注册页面后，按步骤填写基本注册信息，点击完成；",@"忘记密码怎么办？\n方法1：在登录右下角点击“忘记密码”，可以通过手机取回；\n方法2：场景1，账号绑定过新浪微博、QQ等，可通过授权登录进入自己的账号，场景2，未绑定第三方账号，可以发邮件给至mail.8lova.com邮箱申请找回密码。",@"可以通过手机号码登录，可以是会用第三方账号进行快速登录，包括QQ，微信，新浪微博。",@"如账号被盗登录不上，可联系mail.8lova.com邮箱，提供账号的相关资料（注册登记时的信息），证明这是自己的账号后，我们会帮助进行找回。",@"支付宝支付",@"登录支付宝官网进行找回",@"1.100个八爱币兑换1元人民币。\n2.八爱币低于500个不能兑换成现金。\n3.八爱币不用人工领取，购买返利的商品后会自动打入个人账户。"];
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (folder[section] == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UILabel *label = nil;
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
//        [label setMinimumFontSize:14.f];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:14.f]];
        [label setTag:1];
        [[cell contentView] addSubview:label];
        
    }
    NSString *text = [_itemsArray objectAtIndex:indexPath.section];
    CGSize constraint = CGSizeMake(kScreenWidth - (10 * 2), 20000.0f);
//    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGSize size = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    
    if (!label)
        label = (UILabel*)[cell viewWithTag:1];
    
    [label setText:text];
    [label setFrame:CGRectMake(10, 10, kScreenWidth - 20,MAX(size.height, 44.0f))];
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *headerID = @"headerID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableCellWithIdentifier:headerID];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerID];
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 44);
        //        创建UILabel对象
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth, 44)];
        label.tag = 500 + section;
        [headerView.contentView addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        //        创建一个手势对象
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicke:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        //        创建一个label对象，给它设置一个背景颜色，方便区分section
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, label.frame.size.height - 1, label.frame.size.width , 1)];
        tempLabel.backgroundColor= [UIColor blackColor];
        tempLabel.alpha = 0.1;
        [label  addSubview:tempLabel];
    }
    //    刷新label
    UILabel *label = (UILabel *)[headerView viewWithTag:500 + section];
    
    label.text = _dataArray[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [_itemsArray objectAtIndex:indexPath.section];
    
    CGSize constraint = CGSizeMake(kScreenWidth - (10 * 2), 20000.0f);
    
//    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGSize size = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (10 * 2);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                                 delegate:self
                                                        cancelButtonTitle:MyLocalizedString(@"OK")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"买家", @"卖家", nil];
        actionSheet.delegate = self;
        [actionSheet showInView:_tableView];
        
    }else{
        HelpContentViewController *contentVC = [[HelpContentViewController alloc] init];
        contentVC.title = _dataArray[indexPath.row];
        [self.navigationController pushViewController:contentVC animated:YES];
    }
}


#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"买家");
        HelpContentViewController *contentVC = [[HelpContentViewController alloc] init];
        contentVC.title = @"卖家帮助";
        [self.navigationController pushViewController:contentVC animated:YES];
    }
    if (buttonIndex == 1) {
        NSLog(@"卖家");
        HelpContentViewController *contentVC = [[HelpContentViewController alloc] init];
        contentVC.title = @"卖家帮助";
        [self.navigationController pushViewController:contentVC animated:YES];
    }
    if (buttonIndex == 2) {
        NSLog(@"取消");
    }
}

#pragma mark --手势触发方法
- (void)clicke:(UITapGestureRecognizer*)sender{
    NSInteger section = sender.view.tag - 500;
    //    与1异或，如果先前值是1，结果为0，相反，值为1
    folder[section] = folder[section]^1;
    
    //    1)刷新全部
    //    [self.tableView reloadData];
    //    1)刷新局部
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    
    
    
}
@end
