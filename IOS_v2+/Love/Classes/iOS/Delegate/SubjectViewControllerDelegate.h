//
//  SubjectViewControllerDelegate.h
//  Love
//
//  Created by lee wei on 14-9-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubjectViewControllerDelegate <NSObject>

//- (void)pushSubjectViewControllerWithTitle:(NSString *)title
//                                 subjectId:(NSString *)subjectId
//                               subjectDesc:(NSString *)subjectDesc
//                                  thumPath:(NSString *)thumPath;

- (void)pushTagViewControllerWithTitle:(NSString *)title labelId:(NSString *)labelId;
@required
- (void)pushLogin;

@end

