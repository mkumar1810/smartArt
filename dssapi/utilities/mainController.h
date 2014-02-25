//
//  mainController.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainDashBoard.h"
#import "signIn.h"
//#import "login.h"
#import "mainMISReports.h"

@class mainDashBoard;

@interface mainController : UIViewController <UITabBarDelegate, UITabBarControllerDelegate>
{
    IBOutlet UITabBarController *tab;
    IBOutlet UITabBar *tabbar;
    IBOutlet UIView *loginView;
    NSTimer *timer;
    int tabSelected;
    //login *reLogin;
    //login *reLogin;
    UIInterfaceOrientation currOrientation;
    METHODCALLBACK _rlOrientationMethod;
}

@property (nonatomic, retain) mainDashBoard *mdbController;
@property(nonatomic,retain)IBOutlet UITabBarController *tab;
- (void) pendingDocsInvoked:(NSDictionary*) pdDocsInfo;
//- (void) reloginSuccessful : (NSDictionary*) reLoginInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withReLoginSetOrientationMethod:(METHODCALLBACK) p_rlSetOrientationMethod;
@end
