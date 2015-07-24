//
//  HomeSubjectCollectionCell.h
//  Love
//
//  Created by lee wei on 14-10-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeSubjectCollectionCellDelegate <NSObject>
@required
- (void)getClickedButton:(UIButton *)sender;

@end

@interface HomeSubjectCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *subjectId;
@property (nonatomic, strong) IBOutlet UIImageView *subjectImageView;
@property (nonatomic, strong) IBOutlet UILabel *subjectTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (weak, nonatomic) IBOutlet UILabel *likeNumLable;
@property (weak, nonatomic) IBOutlet UIImageView *followIconImage;
@property (weak, nonatomic) IBOutlet UIButton *followBackButton;
- (IBAction)followTagAction:(id)sender;

@property (nonatomic, weak) id<HomeSubjectCollectionCellDelegate>delegate;

@end
