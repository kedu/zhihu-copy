//
//  registerViewController.m
//  zhihu-copy
//
//  Created by Apple on 16/8/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "registerViewController.h"
#import "UIButton+backImage.h"
#import "checkViewController.h"
#import "NSString+Hash.h"

@interface registerViewController ()<NSURLSessionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;//名字

@property (weak, nonatomic) IBOutlet UITextField *passWord;//密码
@property (weak, nonatomic) IBOutlet UIButton *registerButton;//注册按钮
@property(strong,nonatomic)NSDictionary*data;

@end
@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = YES;
    self.registerButton.enabled=NO;
    self.navigationController.navigationBarHidden=YES;
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
    [self.registerButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    //创建通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //注册通知
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:self.name];
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:self.passWord];
    [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:self.phoneNum];

}
- (void)textValueChanged:(NSNotification *)notice
{
    BOOL isYes=(self.name.text.length != 0 && self.phoneNum.text.length != 0&&self.passWord.text.length != 0);
    self.registerButton.enabled =isYes;
    NSLog(@"%d",self.registerButton.enabled);
}
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{

//    [self.view endEditing:YES];
    [self.name endEditing:YES];
    [self.phoneNum endEditing:YES];
    [self.passWord endEditing:YES];
    
}
//注册
- (IBAction)registerButton:(id)sender forEvent:(UIEvent *)event {
    //点击注册是发送请求,把用户名,号码,密码发送给服务器
    NSString*name=self.name.text;
    NSString*add=@"%2B";
    NSString*phoneNum=[NSString stringWithFormat:@"%@86%@",add,self.phoneNum.text];
    
    NSString*passWord=self.passWord.text;
    //全部都有数据才能点击注册按钮   //怎么实现? //kvo?代理?通知?
    //发送之前需要对格式做控制
    NSLog(@"33333");
    //需要对数据正则处理一下  看了下,是在服务器处理的
    //
    NSString*urlStr=@"https://api.zhihu.com/validate/register_form";
    NSURL*url=[NSURL URLWithString:urlStr];
    //post
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求方法为 POST ; 默认情况下,所有的请求都是 GET 请求.
    request.HTTPMethod = @"POST";
    // POST 请求的参数,都是放在请求体中的! 注意:请求体式二进制数据!
    // 设置请求体内容:
    NSString *str = [NSString stringWithFormat:@"fullname=%@&password=%@&phone_no=%@",name,passWord,phoneNum];
    // 将请求体字符串转换成二进制数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"content-type"];//请求头
    [request setValue:@"AIBAB9SyXApLBWRhdNEy_pV8BGK2g9TVeJs=" forHTTPHeaderField:@"X-UDID"];
    [request setValue:@"oauth 5774b305d2ae4469a2c9258956ea49" forHTTPHeaderField:@"Authorization"];
    [request setValue:@" keep-alive" forHTTPHeaderField:@"Proxy-Connection"];
    [request setValue:@" OS=iOS&Release=9.3.3&Model=iPad5,4&VersionName=3.20.1&VersionCode=482&Width=2048&Height=1536" forHTTPHeaderField:@"x-app-za"];
    [request setValue:@" zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@" 3.0.23" forHTTPHeaderField:@"X-API-Version"];
    [request setValue:@" osee2unifiedRelease/482 CFNetwork/758.5.3 Darwin/15.6.0" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@" release" forHTTPHeaderField:@"X-APP-Build"];
    [request setValue:@" 3.20.1" forHTTPHeaderField:@"X-APP-VERSION"];
    //
//    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] ;
//    NSString*cookie_str=[NSString stringWithFormat:@"capsion_ticket=\"2|1:0|10:%.0f|14:capsion_ticket|44:ZDdiNTAxYjBmYjIzNDQxNDg3YmIwODJhZDUzMTEwODQ=|0cfee135ded961fb1dc01dbac9abb36a320d93fd73b945367deb3c9f42d325fd\"; d_c0=AIBAB9SyXApLBWRhdNEy_pV8BGK2g9TVeJs=|1470869897",interval];
//    [request setValue:cookie_str forHTTPHeaderField:@"Cookie"];
    // 2. 发送请求 // POST 请求只能使用下面这个方法!
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //
    [[ session  dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//        self.data=[NSDictionary dictionaryWithObject:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] forKey:@"data"];
       self.data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",self.data);
        NSLog(@"%@",phoneNum.md5String);
        
        
        //有问题就弹出提示框
        [self alert];
        //如果返回True,跳转到输入验证码界面
    }] resume];
}
-(void)alert{
    NSString*fullname=self.data[@"fullname"][@"message"];
    NSString*phone_no=self.data[@"phone_no"][@"message"];
    NSString*password=self.data[@"password"][@"message"];
    if (fullname.length!=0) {
        UIAlertController*alertContr_name=[UIAlertController alertControllerWithTitle:nil message:fullname preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertContr_name animated:YES completion:^{
            
        }];
        [alertContr_name addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
    } else if(phone_no.length!=0){
        UIAlertController*alertContr_phone=[UIAlertController alertControllerWithTitle:nil message:phone_no preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertContr_phone animated:YES completion:^{
            
        }];
        [alertContr_phone addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
        
    }
    //
    //
    else if(password.length!=0){
        
        UIAlertController*alertContr_password=[UIAlertController alertControllerWithTitle:nil message:password preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertContr_password animated:YES completion:^{
            
        }];
        [alertContr_password addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
    }else if(self.data[@"success"]){
    
        NSLog(@"我填写规范");
        //跳转界面
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"check" bundle:nil];
        UIViewController *checkVC = [storyboard instantiateViewControllerWithIdentifier:@"IDENTIFIER"];
//        [self presentViewController:checkVC animated:YES completion:nil];
        [self.navigationController pushViewController:checkVC animated:YES];
        //并且发送请求给第三方
        [self sendPhone_num2other];
    }
}
-(void)sendPhone_num2other{
    NSString*urlStr=@"https://api.zhihu.com/sms/digits";
    NSURL*url=[NSURL URLWithString:urlStr];
    //post
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求方法为 POST ; 默认情况下,所有的请求都是 GET 请求.
    request.HTTPMethod = @"POST";
    // POST 请求的参数,都是放在请求体中的! 注意:请求体式二进制数据!
    // 设置请求体内容:
    NSString*add=@"%2B";
    NSString *str = [NSString stringWithFormat:@"phone_no=%@%@",add,self.phoneNum.text];
    // 将请求体字符串转换成二进制数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
//    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"content-type"];//请求头
    [request setValue:@"AIBAB9SyXApLBWRhdNEy_pV8BGK2g9TVeJs=" forHTTPHeaderField:@"X-UDID"];
    [request setValue:@"oauth 5774b305d2ae4469a2c9258956ea49" forHTTPHeaderField:@"Authorization"];
    [request setValue:@" keep-alive" forHTTPHeaderField:@"Proxy-Connection"];
    [request setValue:@" OS=iOS&Release=9.3.3&Model=iPad5,4&VersionName=3.20.1&VersionCode=482&Width=2048&Height=1536" forHTTPHeaderField:@"x-app-za"];
    [request setValue:@" zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@" 3.0.23" forHTTPHeaderField:@"X-API-Version"];
    [request setValue:@" osee2unifiedRelease/482 CFNetwork/758.5.3 Darwin/15.6.0" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@" release" forHTTPHeaderField:@"X-APP-Build"];
    [request setValue:@" 3.20.1" forHTTPHeaderField:@"X-APP-VERSION"];
    //
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] ;
    NSLog(@"%.0f",interval);
    NSString*cookie_str=[NSString stringWithFormat:@"capsion_ticket=\"2|1:0|10:%.0f|14:capsion_ticket|44:ZDdiNTAxYjBmYjIzNDQxNDg3YmIwODJhZDUzMTEwODQ=|0cfee135ded961fb1dc01dbac9abb36a320d93fd73b945367deb3c9f42d325fd\"; d_c0=AIBAB9SyXApLBWRhdNEy_pV8BGK2g9TVeJs=|1470869897",interval];
//       NSString*cookie_str=[NSString stringWithFormat:@"capsion_ticket=\"2|1:0|10:1470993871|14:capsion_ticket|44:ZDdiNTAxYjBmYjIzNDQxNDg3YmIwODJhZDUzMTEwODQ=|0cfee135ded961fb1dc01dbac9abb36a320d93fd73b945367deb3c9f42d325fd\"; d_c0=AIBAB9SyXApLBWRhdNEy_pV8BGK2g9TVeJs=|1470869897"];
    //1470999902334
    //1470993871
    //1471000010
    //ZDdiNTAxYjBmYjIzNDQxNDg3YmIwODJhZDUzMTEwODQ
    //AIBAB9SyXApLBWRhdNEy_pV8BGK2g9TVeJs
    //这两个东西是什么加密呢?
    //Kzg2MTUyMTYxMTEyMzU=
    //带等号有可能base64加密
    //2c51e34996737dc8bb6b3554d78e0506
    //动态密码 (md5+时间).MD5
    //9afae0d84570077ee186a701d5c5fe81 9afae0d84570077ee186a701d5c5fe81
    //0cfee135ded961fb1dc01dbac9abb36a 320d93fd73b945367deb3c9f42d325fd
    //感觉是两个MD5值在这  一般是要加盐的,可盐不知道...
    //Cookie: capsion_ticket="2|1:0|10:1470987145|14:capsion_ticket|44:MzE4ZTRiZjZmZmEyNDM4ZTllMTM2ZjUxMDI0ZDM0MTk=|6956945099ea63a08bb2d2958dd1fdc9bace9f87f57d5a7b7e12331acae21525"; d_c0=AIBAB9SyXApLBWRhdNEy_pV8BGK2g9TVeJs=|1470869897
    //Cookie: capsion_ticket="2|1:0|10:1470999083|14:capsion_ticket|44:ZTFhN2E5NTNmZmU0NDQ3MDg4N2YxMjUwNmU4NzY1Yjk=|ae8b71f2203366c8e3d4f0c4c8083a676899adb0d280f16b2fa756a4a57bd9de"; d_c0=AIBAB9SyXApLBWRhdNEy_pV8BGK2g9TVeJs=|1470869897
    
    [request setValue:cookie_str forHTTPHeaderField:@"Cookie"];
    
    // 2. 发送请求 // POST 请求只能使用下面这个方法!
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //
    [[ session  dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        self.data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",self.data);
        NSLog(@"手机号发送给第三方了");
        
        
        //有问题就弹出提示框
//        [self alert];
        //如果返回True,跳转到输入验证码界面
    }] resume];

    
    







}
- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    //AFNetworking中的处理方式
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    //判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        /*disposition：如何处理证书
         NSURLSessionAuthChallengePerformDefaultHandling:默认方式处理
         NSURLSessionAuthChallengeUseCredential：使用指定的证书    NSURLSessionAuthChallengeCancelAuthenticationChallenge：取消请求
         */
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    //安装证书
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}
    


//}
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
    //把phonenum传入
    
   
}



@end
