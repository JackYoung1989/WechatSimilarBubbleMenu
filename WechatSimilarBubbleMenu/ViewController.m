//
//  ViewController.m
//  WechatSimilarBubbleMenu
//
//  Created by JackYoung on 2022/4/6.
//

#import "ViewController.h"
#import "JYBubbleMenuView.h"
#import "JYTextView.h"
#import "JYBubbleButtonModel.h"
#import "AppDelegate.h"

@interface ViewController ()<UITextViewDelegate, UITextInputDelegate>

//光标位置
@property (nonatomic,assign)NSRange curserRange;

@property (nonatomic, strong)JYTextView *serviceContentTextView;

@end

@implementation ViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [JYBubbleMenuView.shareMenuView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天页面";
    
    self.view.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:237 / 255.0 blue:238 / 255.0 alpha:1];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 40, 40)];
    headImageView.image = [UIImage imageNamed:@"headImage"];
    headImageView.layer.cornerRadius = 5;
    headImageView.clipsToBounds = true;
    [self.view addSubview:headImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.frame.origin.x + headImageView.frame.size.width + 10, headImageView.frame.origin.y, 200, 14)];
    nameLabel.text = @"我是杨杰";
    nameLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:nameLabel];
    
    _serviceContentTextView = [[JYTextView alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height + 5, 260, 200)];
    _serviceContentTextView.layer.cornerRadius = 5;
    _serviceContentTextView.clipsToBounds = true;
    _serviceContentTextView.editable = false;
    _serviceContentTextView.delegate = self;
    _serviceContentTextView.inputDelegate = self;
    _serviceContentTextView.text = @"If this demo helps you,please give me a buling buling star,thanks!!! \n\nJackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy!";
    [self.view addSubview:_serviceContentTextView];
    
    [((AppDelegate*)([UIApplication sharedApplication].delegate)).window addSubview:[JYBubbleMenuView shareMenuView]];
    
    [_serviceContentTextView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress)]];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self.view endEditing:true];
        return NO;
    }

    return true;
}

- (void)onLongPress {
    [self.serviceContentTextView performSelector:@selector(selectAll:) withObject:nil afterDelay:0.0];
}

- (void)selectionWillChange:(id<UITextInput>)textInput {
    NSLog(@"选择区域 _start_ 变化。。。隐藏");
}

- (void)selectionDidChange:(id<UITextInput>)textInput {
    NSLog(@"选择区域 _end_ 变化。。。显示");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITextView class]]) {
        [JYBubbleMenuView.shareMenuView removeFromSuperview];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"光标位置%ld——%ld",textView.selectedRange.location,textView.selectedRange.length);
    _curserRange = textView.selectedRange;
    NSLog(@"%@",textView.selectedTextRange);
        
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
    
    CGRect tempRect = [_serviceContentTextView convertRect:resultRect toView:((AppDelegate*)([UIApplication sharedApplication].delegate)).window];
    CGRect cursorStartRectToWindow = [_serviceContentTextView convertRect:startRect toView:((AppDelegate*)([UIApplication sharedApplication].delegate)).window];
    
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
                [self.serviceContentTextView hideTextSelection];
                [JYBubbleMenuView.shareMenuView removeFromSuperview];
                [self alertWithTitle:selectTitle];
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
                [self.serviceContentTextView hideTextSelection];
                [JYBubbleMenuView.shareMenuView removeFromSuperview];
                [self alertWithTitle:selectTitle];
            }];
        }
    } else {
        //隐藏
        [[JYBubbleMenuView shareMenuView] removeFromSuperview];
    }
}

- (void)alertWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:okAlert];
    [alertController addAction:cancelAlert];
    [self presentViewController:alertController animated:true completion:^{
            
    }];
}

@end
