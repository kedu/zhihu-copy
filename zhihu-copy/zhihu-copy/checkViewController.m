//
//  checkViewController.m
//  zhihu-copy
//
//  Created by Apple on 16/8/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "checkViewController.h"

@interface checkViewController ()
@property (weak, nonatomic) IBOutlet UILabel *send2num;
@property (weak, nonatomic) IBOutlet UITextField *check_messsage;

@end

@implementation checkViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     registerViewController*registe=self.navigationController.viewControllers[0];
    NSString*phoneNum=registe.phoneNum.text;
    self.send2num.text=[NSString stringWithFormat:@"短信验证码已发送至%@请注意查收",phoneNum];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)end:(id)sender {
}

- (IBAction)restart:(id)sender {
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
