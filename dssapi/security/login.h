//
//  login.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dssWSCallsProxy.h"


@interface login : UIView 
{
    IBOutlet UITextField *Email,*Password;
    CGPoint scrollOffset;
	NSMutableString *parseElement,*value;
    NSMutableData *webData;
    NSXMLParser *xmlParser;
    NSMutableString *respcode, *respmessage;
    IBOutlet UIActivityIndicatorView *actview;
    IBOutlet UIView *loginControl;
    IBOutlet UIImageView *mainImage;
    IBOutlet UIScrollView *scrollView;
    UIInterfaceOrientation intOrientationType;
    //NSString *_notificationName;
    METHODCALLBACK _loginReturnMethod;
}
- (IBAction)Login;
- (BOOL) validate;
- (void) showAlertMessage:(NSString *) dispMessage;
- (void) setForOrientation:(UIInterfaceOrientation) orientationType;
- (id) initWithFrame:(CGRect)frame andReturnMethod:(METHODCALLBACK) p_loginReturn;
- (void) resetValues;
@end
