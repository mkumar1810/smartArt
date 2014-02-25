//
//  dssapiAppDelegate.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "login.h"
#import "mainController.h"
#import "mainDashBoard.h"
#import "signIn.h"


@interface dssapiAppDelegate : NSObject <UIApplicationDelegate> 
{
    UINavigationController *nav;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

//- (void) loginSuccessful : (NSNotification*) signInfo;
@end
