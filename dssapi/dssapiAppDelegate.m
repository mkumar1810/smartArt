//
//  dssapiAppDelegate.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "dssapiAppDelegate.h"


@implementation dssapiAppDelegate


@synthesize window=_window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessful:) name:@"loginSuccessful" object:nil];*/
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reStartApplication:) name:@"reStartApplication" object:nil];

    // Override point for customization after application launch.
    /*nav=[[UINavigationController alloc]init];
    nav.navigationBar.hidden=YES;
    [self.window addSubview:nav.view];*/
    nav=[[UINavigationController alloc]init];
    nav.navigationBar.hidden=YES;
    [self.window addSubview:nav.view];
    signIn *signin=[[signIn alloc] init];
    [nav pushViewController:signin animated:YES];
    [self.window makeKeyAndVisible];
    return YES;
    //Login *li=[[Login alloc]init];
    //[nav pushViewController:li animated:YES];
    //CGRect myframe = [nav.view bounds];
    //NSLog(@"the bounds of my frame is %f  %f  %f  %f",myframe.origin.x, myframe.origin.y, myframe.size.width, myframe.size.height);
    /*login *signin = [[login alloc] initWithFrame:myframe];
    [nav.view addSubview:signin];
    [self.window makeKeyAndVisible];
    return YES;*/
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removexObserver:self];
    //[_window release];
    //[super dealloc];
}
/*
- (void) reStartApplication : (NSDictionary*) logoutInfo
{
    [nav popViewControllerAnimated:YES];
    nav.navigationBar.hidden=YES;
    [self.window addSubview:nav.view];
    signIn *signin=[[signIn alloc]initWithReloginMethod:_reloginCallBack];
    [nav pushViewController:signin animated:YES];
    [self.window makeKeyAndVisible];
*/
    
    /*[nav popViewControllerAnimated:YES];
    CGRect myframe = [nav.view bounds];
    login *signin = [[login alloc] initWithFrame:myframe];
    [nav.view addSubview:signin];
    [self.window makeKeyAndVisible];*/
//}

@end
