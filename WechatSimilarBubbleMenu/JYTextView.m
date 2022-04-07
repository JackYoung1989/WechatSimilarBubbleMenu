//
//  JYTextView.m
//  JYImageTextCombine
//
//  Created by JackYoung on 2022/3/31.
//  Copyright © 2022 Jack Young. All rights reserved.
//

#import "JYTextView.h"
#import "JYBubbleMenuView.h"
#import "JYBubbleButtonModel.h"
#import "AppDelegate.h"

@interface JYTextView()<UITextViewDelegate, UITextInputDelegate>

@end

@implementation JYTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self resignFirstResponder];
        self.tintColor = [UIColor greenColor];
        self.font = [UIFont systemFontOfSize:15];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = true;
        self.editable = false;
        self.delegate = self;
        self.inputDelegate = self;
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress)]];
    }
    return self;
}

- (void)onLongPress {
    [self performSelector:@selector(selectAll:) withObject:nil afterDelay:0.0];
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

#pragma mark delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
//        [self.view endEditing:true];
        return NO;
    }

    return true;
}

- (void)selectionWillChange:(id<UITextInput>)textInput {
    NSLog(@"选择区域 _start_ 变化。。。隐藏");
}

- (void)selectionDidChange:(id<UITextInput>)textInput {
    NSLog(@"选择区域 _end_ 变化。。。显示");
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"光标位置%ld——%ld",textView.selectedRange.location,textView.selectedRange.length);
        
    CGRect startRect = [textView caretRectForPosition:[textView selectedTextRange].start];
    CGRect endRect = [textView caretRectForPosition:[textView selectedTextRange].end];
//    NSLog(@"__👂👂👂👂%.1f,%.1f,%.1f,%.1f",startRect.origin.x, startRect.origin.y, startRect.size.width, startRect.size.height);
//    NSLog(@"__👂👂👂👂%.1f,%.1f,%.1f,%.1f",endRect.origin.x, endRect.origin.y, endRect.size.width, endRect.size.height);
    
    CGRect resultRect = CGRectZero;
    if (startRect.origin.y == endRect.origin.y) {
        resultRect.origin.x = startRect.origin.x;
        resultRect.origin.y = startRect.origin.y;
        resultRect.size.width = endRect.origin.x - startRect.origin.x + 2;
        resultRect.size.height = startRect.size.height;
    } else {
        resultRect.origin.x = 0;
        resultRect.origin.y = startRect.origin.y;
        resultRect.size.width = textView.frame.size.width;
        resultRect.size.height = endRect.origin.y - startRect.origin.y + endRect.size.height;
    }
    
//    _selectedTopView.frame = resultRect;
    
    CGRect tempRect = [self convertRect:resultRect toView:((AppDelegate*)([UIApplication sharedApplication].delegate)).window];
    CGRect cursorStartRectToWindow = [self convertRect:startRect toView:((AppDelegate*)([UIApplication sharedApplication].delegate)).window];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if (textView.selectedRange.length > 0) {
        //全部选中的时候内容显示的不一样。
        if (textView.selectedRange.length == textView.text.length) {
            for (int i = 0; i < 6; i ++) {
                JYBubbleButtonModel *model = [[JYBubbleButtonModel alloc] init];
                if (i == 0) {
                    model.imageName = @"copy";
                    model.name = @"复制";
                } else if (i == 1) {
                    model.imageName = @"diliver";
                    model.name = @"转发";
                } else if (i == 2) {
                    model.imageName = @"collect";
                    model.name = @"收藏";
                } else if (i == 3) {
                    model.imageName = @"rubbish";
                    model.name = @"删除";
                } else if (i == 4) {
                    model.imageName = @"mulSelect";
                    model.name = @"多选";
                } else if (i == 5) {
                    model.imageName = @"ref";
                    model.name = @"引用";
                }
                [array addObject:model];
            }
            
            [[JYBubbleMenuView shareMenuView] showViewWithButtonModels:array cursorStartRect:cursorStartRectToWindow selectionTextRectInWindow:tempRect selectBlock:^(NSString * _Nonnull selectTitle) {
                [self hideTextSelection];
                [JYBubbleMenuView.shareMenuView removeFromSuperview];
//                [self alertWithTitle:selectTitle];
            }];
        } else {
            
            for (int i = 0; i < 4; i ++) {
                JYBubbleButtonModel *model = [[JYBubbleButtonModel alloc] init];
                
                if (i == 0) {
                    model.imageName = @"copy";
                    model.name = @"复制";
                } else if (i == 1) {
                    model.imageName = @"diliver";
                    model.name = @"转发";
                } else if (i == 2) {
                    model.imageName = @"collect";
                    model.name = @"收藏";
                } else if (i == 3) {
                    model.imageName = @"rubbish";
                    model.name = @"删除";
                }
                
                [array addObject:model];
            }
            [[JYBubbleMenuView shareMenuView] showViewWithButtonModels:array cursorStartRect:cursorStartRectToWindow selectionTextRectInWindow:tempRect selectBlock:^(NSString * _Nonnull selectTitle) {
                [self hideTextSelection];
                [JYBubbleMenuView.shareMenuView removeFromSuperview];
//                [self alertWithTitle:selectTitle];
            }];
        }
    } else {
        //隐藏
        [[JYBubbleMenuView shareMenuView] removeFromSuperview];
    }
}

@end
