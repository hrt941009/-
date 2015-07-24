//
//  SKUValueCell.m
//  Love
//
//  Created by lee wei on 15/1/1.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "SKUValueCell.h"

@implementation SKUCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorRGBWithRed:213.f green:213.f blue:213.f alpha:1.f];
        self.layer.borderColor = [[UIColor colorRGBWithRed:187.f green:187.f blue:187.f alpha:1.f] CGColor];
        self.layer.borderWidth  = 1.f;
        self.layer.cornerRadius = 3.f;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}


@end

static NSString * const kCellReuseIdentifier = @"kCellReuseIdentifier";
static CGFloat const collectionCellRowHeight = 52.f;
static NSInteger const collectionCellColumn = 3;

@implementation SKUValueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat labelWidth = self.frame.size.width - 20.f;
        CGFloat collectionViewWidth = self.frame.size.width - 10.f;
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, labelWidth, 24.f)];
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.textColor = [UIColor colorRGBWithRed:232.f green:107.f blue:136.f alpha:1.f];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.font = [UIFont systemFontOfSize:12.f];
        _typeLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_typeLabel];
        
        UIView *headerLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_typeLabel.frame), collectionViewWidth, 1.f)];
        headerLine.backgroundColor = [UIColor colorRGBWithRed:237.f green:237.f blue:237.f alpha:1.f];
        [self.contentView addSubview:headerLine];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(80.f, 30.f)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5.f, CGRectGetMaxY(headerLine.frame) + 6.f, collectionViewWidth, 30.f)
                                             collectionViewLayout:flowLayout];
        [_collectionView setAllowsSelection:YES];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        _collectionView.scrollEnabled = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_collectionView];
        
        [_collectionView registerClass:[SKUCollectionCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)cellHeight
{
    [super layoutSubviews];
    
    CGFloat height = 0;
    if ([_dataArray count] > collectionCellColumn) {
        height = collectionCellRowHeight * [self.dataArray count]/collectionCellColumn + _typeLabel.frame.size.height + 10.f;
    }else{
        height = 70.f;
    }
    return height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([_dataArray count] > collectionCellColumn) {
        CGFloat height = collectionCellRowHeight * [self.dataArray count]/collectionCellColumn;
        
        CGRect collectionRect = _collectionView.frame;
        collectionRect.size.height = height;
        _collectionView.frame = collectionRect;
    }else{
        CGRect collectionRect = _collectionView.frame;
        collectionRect.size.height = 32.f;
        _collectionView.frame = collectionRect;
    }

    UIView *footerLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_collectionView.frame) + 4.f, _collectionView.frame.size.width, 1.f)];
    footerLine.backgroundColor = [UIColor colorRGBWithRed:237.f green:237.f blue:237.f alpha:1.f];
    [self.contentView addSubview:footerLine];
    
//    CGRect rect = self.frame;
//    rect.size.height = height;
//    self.frame = rect;
    
    NSLog(@"_collectionView.frame.size.height = %f", _collectionView.frame.size.height);
}

#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SKUCollectionCell *cell = (SKUCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = _dataArray[indexPath.row];
    
    return cell;
    
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SKUCollectionCell *cell = (SKUCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [[UIColor Gimmebar] CGColor];
    
 //   SKUValueCell *kcell = (SKUValueCell *)[[collectionView superview] superview];
//    NSIndexPath *indexPath = [_myTableView indexPathForCell:kcell];
    if ([_delegate respondsToSelector:@selector(choiceColorOrSize:andCell:)]) {
        [_delegate choiceColorOrSize:_dataArray[indexPath.row] andCell:self];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SKUCollectionCell *cell = (SKUCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
