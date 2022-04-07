//
//  ViewController.m
//  WechatSimilarBubbleMenu
//
//  Created by JackYoung on 2022/4/6.
//

#import "ViewController.h"
#import "JYBubbleMenuView.h"
#import "JYTextView.h"
#import "AppDelegate.h"

@interface ViewController ()

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
    _serviceContentTextView.text = @"If this demo helps you,please give me a buling buling star,thanks!!! \n\nJackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy! JackYoung is a good boy!";
    [self.view addSubview:_serviceContentTextView];
    _serviceContentTextView.fatherViewController = self;
    
    [((AppDelegate*)([UIApplication sharedApplication].delegate)).window addSubview:[JYBubbleMenuView shareMenuView]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.serviceContentTextView hideTextSelection];
    [JYBubbleMenuView.shareMenuView removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITextView class]]) {
        [JYBubbleMenuView.shareMenuView removeFromSuperview];
    }
}

@end
