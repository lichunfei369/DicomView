//
//  MedFilmNavigation.m
//  MedFilm
//
//  Created by 李春菲 on 17/2/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "MedFilmNavigation.h"
#import "UIBarButtonItem+Extension.h"
@interface MedFilmNavigation ()

@end

@implementation MedFilmNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
        if (self.viewControllers.count > 0) { //如果现在push的不是栈底控制器(最先push进来的那个控制器)
         viewController.hidesBottomBarWhenPushed = YES;
            //设置导航按钮
    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem
                                                               itemWithImageName:@"Navigation_left" highImageName:@"Navigation_left" target:self action:(@selector(back))];
      }
       [super pushViewController:viewController animated:YES];
    }
-(void)back{
    
       [self popViewControllerAnimated:YES];
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
