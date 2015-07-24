//
//  MySubjectHeaderView.h
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CreateNewTagDelegate <NSObject>

- (void)careteNewTag;

@end

@interface MySubjectHeaderView : UIView

@property (nonatomic, strong) IBOutlet UIView *iconView;
@property (nonatomic, strong) IBOutlet UILabel *nickNameLabel, *signLabel, *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *createTag;

@property (nonatomic, weak) id<CreateNewTagDelegate>delegate;

- (IBAction)createNewTagAction:(id)sender;

@end
