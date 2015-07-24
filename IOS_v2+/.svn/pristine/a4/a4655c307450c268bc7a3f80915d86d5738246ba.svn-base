//
//  SellerSearchViewController.m
//  Love
//
//  Created by lee wei on 14-7-15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SellerSearchViewController.h"

@interface SellerSearchViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation SellerSearchViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];

    //---
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.f)];
    if (VersionNumber_iOS_7) {
        _searchBar.barTintColor = [UIColor colorRGBWithRed:191.f green:30.f blue:39.f alpha:1];
    }else{
        _searchBar.tintColor = [UIColor colorRGBWithRed:191.f green:30.f blue:39.f alpha:1];
    }
    _searchBar.placeholder = @"搜索 扫货买手";
    [_searchBar becomeFirstResponder];
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - search bar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{

    return YES;
}

@end
