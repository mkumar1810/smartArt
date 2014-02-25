//
//  docApprovals.h
//  dssapi
//
//  Created by Raja T S Sekhar on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "docApprovalMasterData.h"
#import "docApprovalDetail.h"

@interface docApprovals : UIView 
{
    IBOutlet UILabel *lbldivname,*lbldocumentname, *lblTotalpending, *lblnoofApproved;
    IBOutlet UILabel *lblheadingdesc1, *lblheadingdesc2, *lblheadingdesc3, *lblheadingdesc4, *lblheadingdesc5;
    IBOutlet UILabel *lblsubheadingdesc1, *lblsubheadingdesc2, *lblsubheadingdesc3, *lblsubheadingdesc4, *lblsubheadingdesc5;
    IBOutlet UITextField *txtpending,*txtapproved;
    IBOutlet UIButton *btnapprove;
    NSString *_divisioncode;
    NSDictionary *_docdict;
    IBOutlet UITableView  *tvdetaildata;
    IBOutlet UITableView *tvmasterdata;
    IBOutlet UIView *myview;
    IBOutlet UINavigationBar *nbar;
    IBOutlet UIBarButtonItem *menuButtonItem, *refreshButtonItem;
    IBOutlet UIActivityIndicatorView *actview;
    int _noofRecs, _noofRecsApproved;
    //NSString *approvalNotifyName, *approveDeapproveNotifyName, *docDetGenNotifyName;
    docApprovalMasterData *damd;
    docApprovalDetail *dadd;
    UIInterfaceOrientation intOrientation;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *menuButtonItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refreshButtonItem;

- (id) initWithDivision:(NSString*) p_divcode andDictData:(NSDictionary*) p_dictdata andFrame:(CGRect) frame andOrientation:(UIInterfaceOrientation) p_intOrientation;
- (void) initialize;
- (void) docApproveNotify:(NSDictionary *)notifyInfo;
- (IBAction) approveButtonClicked:(id) sender;
- (void) showAlertMessage:(NSString *) dispMessage;
- (void) changeInterfaceOrientation:(UIInterfaceOrientation) p_intOrientation;
- (int) getXPosition :(int) lblNo;
- (int) getXPositionSub :(int) subLblNo;
- (void) docDetailGenerateNotify:(NSDictionary *)detailGenInfo;
- (void) approveDeapproveNotify:(NSDictionary*) appDeappNotifyInfo;
- (void) reloadMasterandDetailViews:(NSDictionary*) p_resultDict;
@end
