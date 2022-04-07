//
//  JYBubbleMenuView.h
//  JYImageTextCombine
//
//  Created by JackYoung on 2022/4/1.
//  Copyright © 2022 Jack Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYBubbleMenuView : UIView

+ (instancetype)shareMenuView;// 单例模式

//type：类型  selectionTextRectInWindow：选中文本在window坐标系中的frame
//cursorStartRect:start的光标位置
//block是选择功能按钮的title
- (void)showViewWithButtonModels:(NSArray *)array
                 cursorStartRect:(CGRect)cursorStartRect selectionTextRectInWindow:(CGRect)rect selectBlock:(void(^)(NSString *selectTitle))block;

@end

NS_ASSUME_NONNULL_END
