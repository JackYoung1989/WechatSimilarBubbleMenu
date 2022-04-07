//
//  JYTextView.h
//  JYImageTextCombine
//
//  Created by JackYoung on 2022/3/31.
//  Copyright © 2022 Jack Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYTextView : UITextView

@property (nonatomic, copy)void (^selectBlock)(NSString *selectedButtonTitle);
@property (nonatomic, strong)UIViewController *fatherViewController;

//取消文本选中效果
- (void)hideTextSelection;

@end

NS_ASSUME_NONNULL_END
