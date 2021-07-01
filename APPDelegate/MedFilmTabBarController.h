//
//  MedFilmTabBarController.h
//  MedFilm
//
//  Created by 李春菲 on 17/2/21.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedFilmTabBarController : UITabBarController
@property   (readonly,nonatomic)    NSInteger lastSelecteIndex;
+(instancetype)shareTabar;
@end
