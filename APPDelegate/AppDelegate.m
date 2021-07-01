//
//  AppDelegate.m
//  DICOMViewer
//
//  Created by ZJQ on 2017/3/20.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MedFilmNavigation.h"
#import "MedFilmTabBarController.h"
#import "QueryController.h"
#import <IQKeyboardManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    MainViewController *main = [[MainViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:main];
//    
//    self.window.rootViewController = nav;

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;

    /*
     *  将要进入视图移除Documents下所有文件夹 这样为了移除之前所有下载数据,重新下载文件.防止由于文件过多造成崩溃卡顿现象.
     */
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:DocumentsPath];
    for (NSString *fileName in enumerator) {
        [[NSFileManager defaultManager] removeItemAtPath:[DocumentsPath stringByAppendingPathComponent:fileName] error:nil];
    }

         [self showMainController];
    
    
    return YES;
}
-(void)showMainController{
    
    MainViewController * AccordingVC = [[MainViewController alloc] init];
    AccordingVC.title = @"案例";
    AccordingVC.tabBarItem.image = [UIImage imageNamed:@"According"];
    MedFilmNavigation * AccordingNa = [[MedFilmNavigation alloc] initWithRootViewController:AccordingVC];
 
    QueryController * QueryVc = [[QueryController alloc]init];
    QueryVc.title = @"查询&检索";
    QueryVc.tabBarItem.image = [UIImage imageNamed:@"Query"];
    MedFilmNavigation * QueryNa = [[MedFilmNavigation alloc] initWithRootViewController:QueryVc];
    
    
    
    MedFilmTabBarController * taBar = [MedFilmTabBarController shareTabar];
    taBar.viewControllers = @[AccordingNa,QueryNa];
    taBar.tabBar.tintColor = [UIColor whiteColor];
    
    self.window.rootViewController = taBar;
    
    [[UITabBar appearance] setBackgroundImage:[self GetImageWithColor:[UIColor colorWithRed:34 / 255.0 green:31 / 255.0  blue:35 / 255.0 alpha:1.] andHeight:1.]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, taBar.tabBar.bounds);
    taBar.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    taBar.tabBar.layer.shadowColor = [UIColor whiteColor].CGColor;
    taBar.tabBar.layer.shadowOffset = CGSizeMake(0, -0.5);
    taBar.tabBar.layer.shadowRadius = 2;
    taBar.tabBar.layer.shadowOpacity = .5;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    taBar.tabBar.clipsToBounds = NO;
    
    
    
}

- (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DICOMViewer"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
