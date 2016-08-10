//
//  registerViewController.m
//  zhihu-copy
//
//  Created by Apple on 16/8/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "registerViewController.h"
#import "UIButton+backImage.h"

@interface registerViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;//名字
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;//号码
@property (weak, nonatomic) IBOutlet UITextField *passWord;//密码


@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = YES;
    self.registerButton.enabled=NO;
    self.name.delegate=self;
    self.phoneNum.delegate=self;
    self.passWord.delegate=self;
    //设置清除按钮
    self.name.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.phoneNum.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.passWord.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.name.clearsOnBeginEditing=NO;
    self.phoneNum.clearsOnBeginEditing=NO;
    self.passWord.clearsOnBeginEditing=NO;
    //点击其他地方结束编辑
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    //
    [self.registerButton setBackgroundColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.registerButton setBackgroundColor:[UIColor redColor] forState:UIControlStateDisabled];
    
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{

//    [self.view endEditing:YES];
    [self.name endEditing:YES];
    [self.phoneNum endEditing:YES];
    [self.passWord endEditing:YES];
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //全部有值才能启用注册按钮
    if (self.name.text.length&&self.phoneNum.text.length&&self.passWord.text.length) {
        
        self.registerButton.enabled=YES;//为什么不起作用?
        NSLog(@"%d",self.registerButton.enabled);
    }else{
        self.registerButton.enabled=NO;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.registerButton.enabled=NO;
    return YES;
    
}


//注册
- (IBAction)registerButton:(id)sender forEvent:(UIEvent *)event {
    //点击注册是发送请求,把用户名,号码,密码发送给服务器
    NSString*name=self.name.text;
    NSString*phoneNum=self.phoneNum.text;
    NSString*passWord=self.passWord.text;
    //全部都有数据才能点击注册按钮   //怎么实现? //kvo?代理?通知?
    //发送之前需要对格式做控制
    NSLog(@"33333");
    //需要对数据正则处理一下
    
    
    
    
    
}
//有账号,去登录
- (IBAction)goLogin:(UIButton *)sender forEvent:(UIEvent *)event {
}

//随便看一看
- (IBAction)justLook:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
