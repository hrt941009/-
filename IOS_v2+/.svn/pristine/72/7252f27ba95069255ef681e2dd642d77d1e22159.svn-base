//
//  MeView.m
//  Love
//
//  Created by lee wei on 14-10-1.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MeView.h"

@implementation MeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MeView" owner:nil options:nil] lastObject];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapAction:)];
        [_headerView addGestureRecognizer:gestureRecognizer];
        
        _orderButton.backgroundColor = [UIColor clearColor];
        _subjectButton.backgroundColor = [UIColor clearColor];
        _likeButton.backgroundColor = [UIColor clearColor];
        _discountAndCoinButton.backgroundColor = [UIColor clearColor];
        _couponButton.backgroundColor = [UIColor clearColor];
        _settingButton.backgroundColor = [UIColor clearColor];
        _friendButton.backgroundColor = [UIColor clearColor];
        _cartButton.backgroundColor = [UIColor clearColor];
        _sellerCenterButton.backgroundColor = [UIColor clearColor];
        
        [self addSomeButton:_orderButton andImageName:@"icon_order_center_normal" andLabelText:@"买家中心"];
        [self addSomeButton:_subjectButton andImageName:@"icon_my_album_normal" andLabelText:@"我的标签"];
        [self addSomeButton:_likeButton andImageName:@"icon_my_love_normal" andLabelText:@"我的喜欢"];
        [self addSomeButton:_discountAndCoinButton andImageName:@"icon_my_rebate_normal" andLabelText:@"钱包"];
        [self addSomeButton:_couponButton andImageName:@"icon_my_notification_normal" andLabelText:@"消息中心"];
        [self addSomeButton:_settingButton andImageName:@"icon_setting_normal" andLabelText:@"设置"];
        [self addSomeButton:_friendButton andImageName:@"icon_friends_management_normal" andLabelText:@"美妆师"];
        [self addSomeButton:_cartButton andImageName:@"icon_shopping_cart_normal" andLabelText:@"购物车"];
        [self addSomeButton:_sellerCenterButton andImageName:@"icon_seller_center_normal" andLabelText:@"卖家中心"];
        
        _orderButton.tag = MyViewButtonTagWithOrder;
        _subjectButton.tag = MyViewButtonTagWithSubject;
        _likeButton.tag = MyViewButtonTagWithLike;
        _discountAndCoinButton.tag = MyViewButtonTagWithRebateAndCoin;
        _couponButton.tag = MyViewButtonTagWithNotifacitionCenter;
        _settingButton.tag = MyViewButtonTagWithSetting;
        _friendButton.tag = MyViewButtonTagWithFriend;
        _cartButton.tag = MyViewButtonTagWithCart;
        _sellerCenterButton.tag = MyViewButtonTagWithSellerCenter;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _orderButton.frame = CGRectMake(10, 108, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
    _subjectButton.frame = CGRectMake(10 + (kScreenWidth - 80)/3 +30, 108, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
    _likeButton.frame = CGRectMake(10 + 2*(kScreenWidth - 80)/3 + 60, 108, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
    _discountAndCoinButton.frame = CGRectMake(10, 108 + (kScreenWidth - 80)/3 + 10, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
    _couponButton.frame = CGRectMake(10 + (kScreenWidth - 80)/3 +30, 108 + (kScreenWidth - 80)/3 + 10, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
    _settingButton.frame = CGRectMake(10 + 2*(kScreenWidth - 80)/3 + 60, 108 + (kScreenWidth - 80)/3 + 10, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
    _friendButton.frame = CGRectMake(10, 108 + 2*(kScreenWidth - 80)/3 + 20, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
    _cartButton.frame = CGRectMake(10 + (kScreenWidth - 80)/3 +30, 108 + 2*(kScreenWidth - 80)/3 + 20, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
    _sellerCenterButton.frame = CGRectMake(10 + 2*(kScreenWidth - 80)/3 + 60, 108 + 2*(kScreenWidth - 80)/3 + 20, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
}

- (void)headerTapAction:(UITapGestureRecognizer *)recognizer
{
    [_delegate tapHeaderView];
}

- (IBAction)meButtonAction:(id)sender
{
    [_delegate meViewButtonActionWithTag:[sender tag]];
}

//button上添加图片和文字方法
- (void)addSomeButton:(UIButton*)bnt andImageName:(NSString*)imageName andLabelText:(NSString*)labelText{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 40, 40)];
    imageView.image = [UIImage imageNamed:imageName];
    [bnt addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 15)];
    label.text = labelText;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [bnt addSubview:label];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
