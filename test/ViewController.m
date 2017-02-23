//
//  ViewController.m
//  Practice-Demo-Drawer
//
//  Created by jshtmhy on 2016/12/19.
//  Copyright © 2016年 jshtmhy. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@property (nonatomic,strong) UIView * below;
@property (nonatomic,strong) UIView * middle;
@property (nonatomic,strong) UIView * main;

@property (nonatomic,assign) CGFloat height;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
}

- (void)configUI {
    _height = SCREEN_HEIGHT / 6.;
    for (NSInteger i = 0; i < 6; i ++) {
        NSLog(@"%F",SCREEN_HEIGHT / 5. * i);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0., SCREEN_HEIGHT / 6. * i, SCREEN_WIDTH, _height)];
        label.font = [UIFont systemFontOfSize:40.];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"T E S T";
        [self.view addSubview:label];
    }
    
    _middle = [[UIView alloc] initWithFrame:CGRectMake(0., 0., SCREEN_WIDTH, _height)];
    _middle.backgroundColor = [UIColor grayColor];
    _middle.userInteractionEnabled = YES;
    _middle.clipsToBounds = YES;
    [self.view addSubview:_middle];
    [_middle addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    
    _main = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _height)];
    for (NSInteger i = 0; i < 6; i ++) {
        [_main addSubview:[self returnLabel:@"T E S T" :CGRectMake(0., SCREEN_HEIGHT / 6. * i, SCREEN_WIDTH, _height) :[UIColor whiteColor]]];
    }
    [_middle addSubview:_main];
    
}



- (void)pan:(UIPanGestureRecognizer *)sender {
    CGPoint pt = [sender translationInView:self.view];
    CGPoint midCenter = _middle.center;
    CGPoint labelCenter = _main.center;
    midCenter.y += pt.y;
    labelCenter.y -= pt.y;
    //边界
    if (midCenter.y > self.view.frame.size.height - _height / 2.) {
        midCenter.y =  self.view.frame.size.height - _height / 2.;
        labelCenter.y = -self.view.frame.size.height + _height * 1.5;
    }
    if (midCenter.y < _height / 2.) {
        midCenter.y = _height / 2.;
        labelCenter.y = _height / 2.;
    }
    _middle.center = midCenter;
    _main.center = labelCenter;
    
    [sender setTranslation:CGPointZero inView:self.view];
    
}


- (UILabel *)returnLabel:(NSString *)title :(CGRect)frame :(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    CGFloat R = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat G = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat B = (CGFloat)random() / (CGFloat)RAND_MAX;
    
    label.textColor = [UIColor colorWithRed:R green:G blue:B alpha:1.];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:40.];
    label.userInteractionEnabled = YES;
    return label;
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
