//
//  CHAppDelegate.m
//  TwitterCover
//

#import "Parse/Parse.h"
#import "CHAppDelegate.h"
#import "CHTwitterCoverDemoTableViewController.h"

@implementation CHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"o2aYzM4BNxrfIPbPACl9NqdqHUgONtJ2mIVgj0IQ" clientKey:@"hoC6PYVUsUPnk4YWPyvtXh9CiYjkUF2WsTUMt7Mq"];
    
    
    CHTwitterCoverDemoTableViewController *controller = [[CHTwitterCoverDemoTableViewController alloc] init];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[CHTwitterCoverDemoTableViewController alloc] init]];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self.window makeKeyAndVisible];
    PFObject *object = [PFObject objectWithClassName:@"Todo"];
    [object setObject:@"Sample Text" forKey:@"text"];
    [object setObject:@1 forKey:@"priority"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // Refresh the table when the object is done saving.
        [controller loadObjects];
    }];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
