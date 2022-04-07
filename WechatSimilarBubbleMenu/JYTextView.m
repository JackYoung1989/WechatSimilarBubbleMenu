//
//  JYTextView.m
//  JYImageTextCombine
//
//  Created by JackYoung on 2022/3/31.
//  Copyright © 2022 Jack Young. All rights reserved.
//

#import "JYTextView.h"
#import "JYBubbleMenuView.h"

@interface JYTextView()

@end

@implementation JYTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self resignFirstResponder];
        self.tintColor = [UIColor greenColor];
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideTextSelection];
    [JYBubbleMenuView.shareMenuView removeFromSuperview];
}

- (void)hideTextSelection {
    [self setSelectedRange:NSMakeRange(0, 0)];//去掉选择的效果。
}

@end
