//
//  docApprovals.m
//  dssapi
//
//  Created by Raja T S Sekhar on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "docApprovals.h"


@implementation docApprovals

@synthesize menuButtonItem, refreshButtonItem;

- (id) initWithDivision:(NSString*) p_divcode andDictData:(NSDictionary*) p_dictdata andFrame:(CGRect) frame andOrientation:(UIInterfaceOrientation) p_intOrientation
{
    self = [super initWithFrame:frame];
    if (self) {
        myview = [[[NSBundle mainBundle] loadNibNamed:@"docApprovals" owner:self options:nil] objectAtIndex:0];
        _divisioncode = p_divcode;
        _docdict = p_dictdata;
        intOrientation = p_intOrientation;
        [self addSubview:myview];    
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"yyyyMMddHHmmss"];
        [self initialize];
        dadd=[[docApprovalDetail alloc] init];
        [dadd setinterfaceOrientation:intOrientation];
        actview.transform = CGAffineTransformMakeScale(5.00, 5.00);        
        actview.hidesWhenStopped = TRUE;
        [actview startAnimating];
    }
    return self;    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) initialize
{
    if ([_divisioncode isEqualToString:@"API"]) 
        lbldivname.text = @"Al Ahli Plastic";
    else
        lbldivname.text = @"Al Ahli Flexible";
    lbldocumentname.text = [_docdict valueForKey:@"DOCDESC"];
    _noofRecs = [[_docdict valueForKey:@"DOC_COUNT"] intValue];
    [txtpending setEnabled:NO]; 
    [txtapproved setEnabled:NO];
    //NSLog(@"the doc dictionary %@", _docdict);
    txtpending.text = [[NSString alloc] initWithFormat:@"%d  ", _noofRecs];
    lblheadingdesc1.text = [_docdict valueForKey:@"APPTAB1_F1"];
    lblheadingdesc2.text = [_docdict valueForKey:@"APPTAB1_F2"];
    lblheadingdesc3.text = [_docdict valueForKey:@"APPTAB1_F3"];
    lblheadingdesc4.text = [_docdict valueForKey:@"APPTAB1_F4"];
    lblheadingdesc5.text = [_docdict valueForKey:@"APPTAB1_F5"];
    lblsubheadingdesc1.text = [_docdict valueForKey:@"APPTAB2_F1"];
    lblsubheadingdesc2.text = [_docdict valueForKey:@"APPTAB2_F2"];
    lblsubheadingdesc3.text = [_docdict valueForKey:@"APPTAB2_F3"];
    lblsubheadingdesc4.text = [_docdict valueForKey:@"APPTAB2_F4"];
    lblsubheadingdesc5.text = [_docdict valueForKey:@"APPTAB2_F5"];
    /*approvalNotifyName = [[NSString alloc] initWithFormat:@"%@%@", @"docAppPopulate", [nsdf stringFromDate:[NSDate date]]];
    approveDeapproveNotifyName = [[NSString alloc] initWithFormat:@"%@%@", @"appDeappNotify", [nsdf stringFromDate:[NSDate date]]];
    docDetGenNotifyName = [[NSString alloc] initWithFormat:@"%@%@", @"docDetGenNotify", [nsdf stringFromDate:[NSDate date]]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(docApproveNotify:)  name:approvalNotifyName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(approveDeapproveNotify:)  name:approveDeapproveNotifyName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(docDetailGenerateNotify:)  name:docDetGenNotifyName object:nil];*/
    METHODCALLBACK appPopulateMethod = ^ (NSDictionary* p_dictInfo)
    {
        [self docApproveNotify:p_dictInfo];
    };
    METHODCALLBACK appDeappMethod = ^ (NSDictionary* p_dictInfo)
    {
        [self approveDeapproveNotify:p_dictInfo];
    };
    METHODCALLBACK docGenNotifyMethod = ^ (NSDictionary* p_dictInfo)
    {
        [self docDetailGenerateNotify:p_dictInfo];
    };
    damd = [[docApprovalMasterData alloc] initWithDivCode:_divisioncode andDocCode:[_docdict valueForKey:@"DCODE"]  andUserStatus:[_docdict valueForKey:@"DOCLVL"] andPopulatMethod:appPopulateMethod andAppDeAppMethod:appDeappMethod andDocDescription:[_docdict valueForKey:@"DOCDESC"] andDocDetGenMethod:docGenNotifyMethod andMainDocDict:_docdict];
    
    /*damd = [[docApprovalMasterData alloc] initWithDivCode:_divisioncode andDocCode:[_docdict valueForKey:@"DCODE"] andUserStatus:[_docdict valueForKey:@"DOCLVL"] andPopulateNotifyName:approvalNotifyName andAppDeAppNotifyName:approveDeapproveNotifyName andDocDescription:[_docdict valueForKey:@"DOCDESC"] andDocDetGenNotify:docDetGenNotifyName andMainDocDict:_docdict];*/
    [damd setinterfaceOrientation:intOrientation];
    [self changeInterfaceOrientation:intOrientation];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void) docApproveNotify:(NSDictionary *)notifyInfo
{
    [actview stopAnimating];
    NSMutableArray *recdData =[[NSMutableArray alloc] initWithArray:[notifyInfo valueForKey:@"data"]];
    //NSLog(@"received data %@",recdData);
    [damd setTableViewData:recdData];
    [damd setinterfaceOrientation:intOrientation];
    [tvmasterdata reloadData];
}

- (void) docDetailGenerateNotify:(NSDictionary *)detailGenInfo
{
    //NSDictionary *recdData = [detailGenInfo userInfo];
    NSDictionary *recdInputs = [detailGenInfo valueForKey:@"inputs"];
    //NSLog(@"received data %@",recdData);
    /*NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:_divcode, @"p_divcode",_doccode,@"p_documentcode",docNo, @"p_documentno" ,_docdesc, @"p_docdesc",schemaDict,@"p_docdict",  nil];
    [[dssWSCallsProxy alloc] initWithReportType:@"APPROVALDOCDETAIL" andInputParams:inputDict andNotificatioName:_docDetGenNotifyname andReturnInputs:YES];*/
    //if (dadd) 
        //[dadd release];
    
    
    dadd = [[docApprovalDetail alloc] initWithDivCode:[recdInputs valueForKey:@"p_divcode"] andDocCode:[recdInputs valueForKey:@"p_documentcode"] andDocNo:[recdInputs valueForKey:@"p_documentno"] andDocDesc:[recdInputs valueForKey:@"p_docdesc"] andMainDocDict:[recdInputs valueForKey:@"p_docdict"]];
    [dadd setinterfaceOrientation:intOrientation];
     //[docGenInfo setValue:dad forKey:@"docDetailObject"];
     //[dad setinterfaceOrientation:intOrientation];
     //NSLog(@"doc generate notify name %@", _docDetGenNotifyname);
     //[[NSNotificatxionCenter defaultCenter] postNotifixcationName:_docDetGenNotifyname object:self userInfo:docGenInfo];
    [dadd setTableViewData:[detailGenInfo valueForKey:@"data"]];

    //[actview stopAnimating];
    //[tvmasterdata reloadData];
    //NSDictionary *detGenInfo = [detailGenInfo userInfo];
    //dadd = (docApprovalDetail*) [detGenInfo valueForKey:@"docDetailObject"];
    tvdetaildata.delegate = dadd;
    tvdetaildata.dataSource = dadd;
    [dadd setinterfaceOrientation:intOrientation ];
    //[dadd setinterfaceOrientation:self.interfaceOrientation andHeadingTitle:_docdict];
    [tvdetaildata reloadData];
}

- (void) approveDeapproveNotify:(NSDictionary*) appDeappNotifyInfo
{
    //NSDictionary *appDeappinfo = [appDeappNotifyInfo userInfo];
    int approvedFlag = [[appDeappNotifyInfo valueForKey:@"Approved"] intValue];
    if (approvedFlag==0) _noofRecsApproved--; else _noofRecsApproved++;
    txtapproved.text = [[NSString alloc] initWithFormat:@"%d  ", _noofRecsApproved];    
}

- (IBAction) approveButtonClicked:(id) sender
{
    [actview startAnimating];
    METHODCALLBACK l_approvalReturn = ^ (NSDictionary* p_dictInfo)
    {
        [self reloadMasterandDetailViews:p_dictInfo];
    };
    [damd updateAllApprovals:l_approvalReturn];
}

- (void) reloadMasterandDetailViews:(NSDictionary*) p_resultDict
{
    [tvmasterdata reloadData];
    //[tvdetaildata removeFromSuperview];
    txtapproved.text = [[NSString alloc] initWithFormat:@"%d  ", 0];
    [actview stopAnimating];
}
    

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

- (void) changeInterfaceOrientation:(UIInterfaceOrientation) p_intOrientation
{
    intOrientation = p_intOrientation;
    [dadd setinterfaceOrientation:p_intOrientation];
    [damd setinterfaceOrientation:intOrientation];
    int xPosition, yPosition, xWidth;
    int xSubPosition, xSubWidth, yPositionSubHeading;
    CGRect nbarFrame = [nbar bounds];
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        [lblTotalpending setFrame:CGRectMake(14, 177, 135, 21)];
        [lblTotalpending setText:@"Total Pending"];
        [txtpending setFrame:CGRectMake(157, 177, 79, 31)];
        [lblnoofApproved setFrame:CGRectMake(267, 177, 135, 21)];
        [txtapproved setFrame:CGRectMake(410, 177, 79, 31)];
        [btnapprove setFrame:CGRectMake(576, 174, 162, 37)];
        [btnapprove setTitle:@"Approve > > >" forState:UIControlStateNormal];
        yPosition=228;
        yPositionSubHeading = 747;
        
        [tvmasterdata removeFromSuperview];
        //[tvmasterdata release];
        tvmasterdata = [[UITableView alloc] initWithFrame:CGRectMake(14, 257, 739, 456)];
        //[tvdetaildata setFrame:CGRectMake(14, 785, 739, 178)];
        [tvdetaildata removeFromSuperview];
        //[tvdetaildata release];
        //[tvdetaildata setFrame:CGRectMake(14, 558, 739, 150)];
        tvdetaildata = [[UITableView alloc] initWithFrame:CGRectMake(14, 785, 739, 178)];
        nbarFrame.size.width = 768;
    
    }
    else
    {
        [lblTotalpending setFrame:CGRectMake(647, 74, 120, 21)];
        [lblTotalpending setText:@"Pending"];
        [txtpending setFrame:CGRectMake(760, 74, 50, 31)];
        [lblnoofApproved setFrame:CGRectMake(647, 118, 120, 21)];
        [txtapproved setFrame:CGRectMake(760, 118, 50, 31)];
        [btnapprove setFrame:CGRectMake(821, 118, 162, 31)];
        [btnapprove setTitle:@"Approve" forState:UIControlStateNormal];
        yPosition=167;
        yPositionSubHeading = 531;

        [tvmasterdata removeFromSuperview];
        //[tvmasterdata release];
        tvmasterdata = [[UITableView alloc] initWithFrame:CGRectMake(14, 208, 975, 300)];
        [tvdetaildata removeFromSuperview];
        //[tvdetaildata release];
        //[tvdetaildata setFrame:CGRectMake(14, 558, 739, 150)];
        tvdetaildata = [[UITableView alloc] initWithFrame:CGRectMake(14, 558, 975, 150)];
        nbarFrame.size.width = 1028;
    }
    xPosition = 14;
    xSubPosition = 14;
    xWidth = [self getXPosition:1];
    xSubWidth = [self getXPositionSub:1];
    [lblheadingdesc1 setFrame:CGRectMake(xPosition, yPosition,xWidth , 21)];
    [lblsubheadingdesc1 setFrame:CGRectMake(xSubPosition, yPositionSubHeading, xSubWidth, 21)];
    xPosition += xWidth;
    xWidth = [self getXPosition:2];
    xSubPosition += xSubWidth;
    xSubWidth = [self getXPositionSub:2];
    [lblheadingdesc2 setFrame:CGRectMake(xPosition , yPosition, xWidth, 21)];
    [lblsubheadingdesc2 setFrame:CGRectMake(xSubPosition, yPositionSubHeading, xSubWidth, 21)];
    xPosition += xWidth;
    xWidth = [self getXPosition:3];
    xSubPosition += xSubWidth;
    xSubWidth = [self getXPositionSub:3];
    [lblheadingdesc3 setFrame:CGRectMake(xPosition, yPosition, xWidth, 21)];
    [lblsubheadingdesc3 setFrame:CGRectMake(xSubPosition, yPositionSubHeading, xSubWidth, 21)];
    xPosition += xWidth;
    xWidth = [self getXPosition:4];
    xSubPosition += xSubWidth;
    xSubWidth = [self getXPositionSub:4];
    [lblheadingdesc4 setFrame:CGRectMake(xPosition, yPosition, xWidth, 21)];
    [lblsubheadingdesc4 setFrame:CGRectMake(xSubPosition, yPositionSubHeading, xSubWidth, 21)];
    xPosition += xWidth;
    xWidth = [self getXPosition:5];
    xSubPosition += xSubWidth;
    xSubWidth = [self getXPositionSub:5];
    [lblheadingdesc5 setFrame:CGRectMake(xPosition, yPosition, xWidth, 21)];
    [lblsubheadingdesc5 setFrame:CGRectMake(xSubPosition, yPositionSubHeading, xSubWidth, 21)];

    [nbar setFrame:nbarFrame];
    
    
    [tvmasterdata setBackgroundView:nil];
    [tvmasterdata setBackgroundView:[[UIView alloc] init] ];
    [tvmasterdata setBackgroundColor:UIColor.clearColor];
    [tvmasterdata setSectionHeaderHeight:1.0f];
    [tvmasterdata setDelegate:damd];
    [tvmasterdata setDataSource:damd];

    [tvdetaildata setBackgroundView:nil];
    [tvdetaildata setBackgroundView:[[UIView alloc] init] ];
    [tvdetaildata setBackgroundColor:UIColor.clearColor];
    [tvdetaildata setSectionHeaderHeight:1.0f];
    [tvdetaildata setDelegate:dadd];
    [tvdetaildata setDataSource:dadd];
    
    [self addSubview:tvmasterdata];
    [self addSubview:tvdetaildata];
    [tvmasterdata reloadData];
    [tvdetaildata reloadData];
}

- (int) getXPosition :(int) lblNo
{
    NSString *keyName = [[NSString alloc] initWithFormat:@"F%d%@W",lblNo, UIInterfaceOrientationIsPortrait(intOrientation)? @"P":@"L" ];
    int xval = [[_docdict valueForKey:keyName] intValue];
    return xval;
}

- (int) getXPositionSub :(int) subLblNo
{
    NSString *keyName = [[NSString alloc] initWithFormat:@"F%dS%@W",subLblNo, UIInterfaceOrientationIsPortrait(intOrientation)? @"P":@"L" ];
    int xval = [[_docdict valueForKey:keyName] intValue];
    return xval;
}

@end
