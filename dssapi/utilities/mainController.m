//
//  mainController.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "mainController.h"

enum {
    kView_First = 1,
    kView_Second,
    kView_Third
};

@implementation mainController

@synthesize tab, mdbController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withReLoginSetOrientationMethod:(METHODCALLBACK) p_rlSetOrientationMethod
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _rlOrientationMethod = p_rlSetOrientationMethod;
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removexObserver:self];
    //[super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //self.view = self.tab.view;
    [self.tab.view setFrame:self.view.frame];
    [self.view addSubview:self.tab.view];
    currOrientation = self.interfaceOrientation;
    //__block id myself = self;
    METHODCALLBACK l_pendingDocMethod = ^(NSDictionary* p_dictInfo)
    {
        [self pendingDocsInvoked:p_dictInfo];
    };
    mainMISReports* l_misReports = [self.tab.viewControllers objectAtIndex:2];
    [l_misReports pendingDocksMethod:l_pendingDocMethod];
    [super viewDidLoad];
    // Do anys additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    // Tell our subview.
    /*if( currentViewController != nil ) {
        [currentViewController viewWillAppear:animated];
    }*/
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //int selItem = tabbar.selectedItem.tag;
    NSArray *viewCtlrs = [tab viewControllers];
    UIViewController *vctrl = (UIViewController*) [viewCtlrs objectAtIndex:tabSelected];
    return [vctrl shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    currOrientation = toInterfaceOrientation;
    /*if (reLogin) {
        [loginView setFrame:CGRectMake(0, 0, 1028, 1028)];
        [reLogin setForOrientation:toInterfaceOrientation];
        return;
    }*/
    //int selItem = tabbar.selectedItem.tag;
    NSArray *viewCtlrs = [tab viewControllers];
    /*if ([loginView viewWithTag:10001]!=nil)
        [reLogin setForOrientation:toInterfaceOrientation];*/
    UIViewController *vctrl = (UIViewController*) [viewCtlrs objectAtIndex:tabSelected];
    return [vctrl willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void) pendingDocsInvoked:(NSDictionary*) pdDocsInfo
{
    [self.tab setSelectedViewController:[tab.viewControllers objectAtIndex:1]];
    tabSelected = 1;
    //[self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:0];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //NSLog(@"item %@ clicked ", item.title);
    tabSelected = item.tag;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController 
{
    UITabBar *tbar = tabBarController.tabBar;
    NSString *selitem = [tbar selectedItem].title;
    tabSelected = [tbar selectedItem].tag;
    [viewController willAnimateRotationToInterfaceOrientation:currOrientation duration:0];
    if ([selitem isEqualToString:@"Sign Out"]) {
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(logOutApplication:) userInfo:nil repeats:NO];
    }
}

-(void) logOutApplication:(NSTimer *)timer
{
    //[self.tab.view removeFromSuperview];
    NSArray *viewCtrlrs = tab.viewControllers;
    for (UIViewController *vctrl in viewCtrlrs) {
        @try {
            [vctrl viewDidUnload];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
    }
    [self viewDidUnload];
    [self.navigationController popViewControllerAnimated:YES];
    _rlOrientationMethod(nil);
    //[self.navigationController.visibleViewController willAnimateRotationToInterfaceOrientation:currOrientation duration:0.0];
    //signIn *signin=[[signIn alloc] init];
    //[self.navigationController pushViewController:signin animated:YES];
    //[signin willAnimateRotationToInterfaceOrientation:currOrientation duration:0.0];
}

@end
