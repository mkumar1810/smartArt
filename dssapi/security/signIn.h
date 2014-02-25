//
//  signIn.h
//  dssapi
//
//  Created by Raja T S Sekhar on 2/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "login.h"
#import "mainController.h"

@interface signIn : UIViewController {
    login *signLogin;
    //NSString *_notificationName;
    //METHODCALLBACK _reloginMethod;
}
//- (id) initWithNotificationName:(NSString*) p_notifyName;
- (void) showAlertMessage:(NSString *) dispMessage;
- (void) loginSuccessful : (NSDictionary*) signInfo;
//- (id) initWithReloginMethod:(METHODCALLBACK) p_reloginMethod;
- (void) setOrientationProperly:(NSDictionary*) p_dictInfo;

@end
