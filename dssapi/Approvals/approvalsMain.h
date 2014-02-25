//
//  approvalsMain.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "approvalsHeader.h"
#import "docApprovals.h"
#import "dssWSCallsProxy.h"

@interface approvalsMain : UIViewController 
{
    IBOutlet UIBarButtonItem *menuButton;
    UIPopoverController *popover;    
    NSMutableArray *apiData;
    NSMutableArray *flxData;
    BOOL initialized;
    int headerinforeceived;
    IBOutlet UIActivityIndicatorView *actview;
    IBOutlet UINavigationBar *nBar;
    IBOutlet UIView *reorientView;
    //docApprovals *da;
    UIInterfaceOrientation currOrientation;
}

@property (nonatomic, retain) UIPopoverController *popover;

- (IBAction) menuButtonClicked:(id)sender;
- (IBAction) refreshClicked:(id) sender;
- (void) generateHeaderInformation;
- (void) initialize;
- (void) approvalsHeaderDataGenerated : (NSDictionary*) approvalsHeaderInfo;
- (void) approvalsDocSelected : (NSDictionary*) approvalsDocInfo;
- (void) setActivityIndicatorProperly;
- (void) hidePopover:(NSDictionary *)notif;

@end
