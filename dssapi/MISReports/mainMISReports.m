//
//  mainMISReports.m
//  dssapi
//
//  Created by Raja T S Sekhar on 3/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "mainMISReports.h"


@implementation mainMISReports

- (void) pendingDocksMethod:(METHODCALLBACK) p_pendingDocMethod
{
    _pendingDocsInvoked = p_pendingDocMethod;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) buttonPressed:(id) sender
{
    UIButton *btn = (UIButton*) sender;
    if (btn.tag==100) 
    {
        //[[NSNotixficationCenter defaultCenter] postNotxificationName:@"pendingDocsInvoked" object:self userInfo:nil];
        //self.parentViewController.tabBarController.tabBar.selectedItem = (UITabBarItem*) [self.parentViewController.tabBarController.tabBar.items objectAtIndex:1];
        _pendingDocsInvoked(nil);
        return;
    }
    //need to check this place
    if (misDispRpt) 
    {
        //[misDispRpt release];
        misDispRpt = nil;
    }
    switch (btn.tag) {
        case 101:
            misDispRpt = [[busInvColnReport alloc] initReportForDate:_currentdate andDayOffset:0 andFrame:[self.view frame] forOrientation:currOrientation];
            break;
        case 102:
            misDispRpt = [[misBusInvDaily alloc] initReportForDayOffset:0 andFrame:[self.view frame] forOrientation:currOrientation];
            break;
        case 103:
            misDispRpt = [[misSalesManMonthly alloc] initReportForDayOffset:0 andFrame:[self.view frame] forOrientation:currOrientation];
            break;
        case 104:
            misDispRpt = [[misSalesAnalysis alloc] initReportForDate:_currentdate andDayOffset:0 andFrame:self.view.frame forOrientation:currOrientation];
            break;
        case 105:
            misDispRpt = [[misCategorySales alloc] initReportForDate:_currentdate andDayOffset:0 andFrame:self.view.frame forOrientation:currOrientation];
            break;
        case 106:
            misDispRpt = [[misSalesCollection alloc] initReportForDate:_currentdate andDayOffset:0 andFrame:self.view.frame forOrientation:currOrientation];
            break;
        case 107:
            misDispRpt = [[misFGTransferred alloc] initReportForDate:_currentdate andDayOffset:0 andFrame:self.view.frame forOrientation:currOrientation];
            break;
        case 108:
            misDispRpt = [[misPurchaseSales alloc] initReportForYearOffset:0 andFrame:self.view.frame forOrientation:currOrientation];
            break;
        case 109:
            misDispRpt = [[misDebtorAgeing alloc] initDebtorAgeingReportWithFrame:self.view.frame forOrientation:currOrientation];
            break;
        case 110:
            misDispRpt = [[misCreditorAgeing alloc] initCreditorAgeingReportWithFrame:self.view.frame forOrientation:currOrientation];
            break;
        case 111:
            [self generateAccountStatement];
            break;
        case 112:
            misDispRpt = [[misPurchaseSalesImpExp alloc] initReportForYearOffset:0 andFrame:self.view.frame forOrientation:currOrientation];
            break;
        case 113:
            salesMiningSelect = [[misSalesMiningSelect alloc] initWithFrame:self.view.frame forOrientation:currOrientation andInitialDict:nil withReturnMethod:_salesMiningReturn];
            [self.view addSubview:salesMiningSelect];
            break;
        case 114:
            purchMiningSelect = [[misPurchMiningSelect alloc] initWithFrame:self.view.frame forOrientation:currOrientation andInitialDict:nil andReturnMethod:_purchMiningReturn];
            [self.view addSubview:purchMiningSelect];
            break;
        case 115:
            [self generateProductionStatement];
            break;
        default:
            break;
    }
    if (!misDispRpt) return;
    [misDispRpt setForOrientation:currOrientation];
    [self.view addSubview:misDispRpt];
}

- (void) initialize
{
    if (initialized==NO) 
    {
        _loggeduser = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggeduser"]; 
        actIndicator.transform = CGAffineTransformMakeScale(5.00, 5.00);        
        [actIndicator startAnimating];
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:_loggeduser, @"p_usercode",@"0",@"p_module", nil];
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self misFDDataGenerated:p_dictInfo];
        };
        [[dssWSCallsProxy alloc] initWithReportType:@"MISFRONTDISPLAY" andInputParams:inputDict andReturnMethod:l_proxyReturn andReturnInputs:NO];
        __block id myself = self;
        _salesMiningReturn = ^(NSDictionary* p_dictInfo)
        {
            [myself salesMiningReturn:p_dictInfo];
        };
        _purchMiningReturn = ^(NSDictionary* p_dictInfo)
        {
            [myself purchMiningReturn:p_dictInfo];
        };
        _printScreenReturn = ^(NSDictionary* p_dictInfo)
        {
            [myself printingScreenBack:p_dictInfo];
        };
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"d-MMM-yyyy"];
        btnReportDisp.text =[[NSString alloc] initWithFormat:@"Reports As On %@ Pending Approval : ",   [nsdf stringFromDate:[NSDate date]]];
        _currentdate = [[NSString alloc] initWithFormat:@"%@",  [nsdf stringFromDate:[NSDate date]]];
        initialized=YES;
    }
}

- (void) misFDDataGenerated : (NSDictionary*) fdData
{

    NSArray *retArray = [[fdData valueForKey:@"data"] copy];
    for (NSDictionary *tmpDict in retArray) 
    {
        [self populateFDData:tmpDict];
    }
}


- (void) populateFDData:(NSDictionary*) fdDispDict
{
    NSString *dispstring;
    int offset=0;
    CGRect myframe;
    int orderNo = [[fdDispDict valueForKey:@"ORDERNO"] intValue] + 100;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:0];
    frm.negativePrefix = @"-";
    frm.negativeSuffix = @"";
    UIButton *btnDisplay;
    UILabel *dispLabel;
    if (orderNo==100)
    {
        btnDisplay = (UIButton*) [self.view viewWithTag:orderNo];
        offset = 3;
    }
    else
        btnDisplay = (UIButton*) [btnContainer viewWithTag:orderNo];
    myframe =  CGRectMake(offset, offset, btnDisplay.bounds.size.width-offset, btnDisplay.bounds.size.height-offset);
    dispLabel = [[UILabel alloc] initWithFrame:myframe];
    dispLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0f];
    dispLabel.numberOfLines = 0;
    dispLabel.lineBreakMode = UILineBreakModeWordWrap;
    dispLabel.tag = 999;
    switch (orderNo) {
        case 100:
            dispstring = [[NSString alloc] initWithFormat:@"%@", [fdDispDict valueForKey:@"FIELD1"]];
            break;
        case 101:
            dispstring = [[NSString alloc] initWithFormat:@"%@\n%@ / %@ / %@",[fdDispDict valueForKey:@"TITLE"],[frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD1"] integerValue]]],[frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD2"] integerValue]]],[frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD3"] integerValue]]]];
            break;
        case 102:
            dispstring = [[NSString alloc] initWithFormat:@"%@\n%@ / %@ ",[fdDispDict valueForKey:@"TITLE"], [frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD1"] integerValue]]],[frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD2"] integerValue]]]];
            break;
        case 103:
            dispstring = [[NSString alloc] initWithFormat:@"%@\n%@ / %@ ",[fdDispDict valueForKey:@"TITLE"], [frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD1"] integerValue]]],[frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD2"] integerValue]]]];
            break;
        case 104:
            dispstring = [[NSString alloc] initWithFormat:@"%@\n%@",[fdDispDict valueForKey:@"TITLE"], [frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD1"] integerValue]]]];
            break;
        case 105:
            dispstring = [[NSString alloc] initWithFormat:@"%@\n%@",[fdDispDict valueForKey:@"TITLE"], [frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD1"] integerValue]]]];
            break;
        case 106:
            dispstring = [[NSString alloc] initWithFormat:@"%@\n%@",[fdDispDict valueForKey:@"TITLE"], [frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD1"] integerValue]]]];
            break;
        case 107:
            dispstring = [[NSString alloc] initWithFormat:@"%@\n%@",[fdDispDict valueForKey:@"TITLE"], [frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD1"] integerValue]]]];
            break;
        case 108:
            dispstring = [[NSString alloc] initWithFormat:@"%@\n%@    %@ ",[fdDispDict valueForKey:@"TITLE"], [frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD1"] integerValue]]],[frm stringFromNumber:[NSNumber numberWithInteger:[[fdDispDict valueForKey:@"FIELD2"] integerValue]]]];
            break;
        default:
            dispstring = [[NSString alloc] initWithFormat:@"%@",[fdDispDict valueForKey:@"TITLE"]];
            break;
    }
    dispLabel.text = dispstring;
    dispLabel.textAlignment =UITextAlignmentCenter;
    if (orderNo!=100)
        dispLabel.backgroundColor = btnDisplay.backgroundColor;
    if (orderNo>111)
    {
        dispLabel.textColor = [UIColor whiteColor];
        [actIndicator stopAnimating];
    }
    [btnDisplay addSubview:dispLabel];
    //[btnDisplay actionsForTarget:self forControlEvent:UIControlEventTouchDown];
    //[dispLabel release];
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
    [self initialize];
    [super viewDidLoad];
    currOrientation = self.parentViewController.tabBarController.interfaceOrientation;
    /*if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) 
        currOrientation = UIInterfaceOrientationPortrait ;
    else
        currOrientation = UIInterfaceOrientationLandscapeLeft;*/
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    currOrientation = toInterfaceOrientation;
    [self setViewResizedForOrientation:toInterfaceOrientation];
}

- (void) setViewResizedForOrientation:(UIInterfaceOrientation) p_intOrientation
{

    CGRect viewFrame = [btnContainer frame];
    int xPosition, xWidth, yPosition, yHeight;
    if (UIInterfaceOrientationIsPortrait(p_intOrientation)) 
    {
        viewFrame.size.width = 692;
        xWidth = 136;
    }
    else
    {
        viewFrame.size.width = 927;
        xWidth = 183;
    }
    yHeight = 63;
    [btnContainer setFrame:viewFrame];
    int dividedvalue, remindervalue; 
    for (int _counter=1; _counter<=15; _counter++) 
    {
        dividedvalue = (_counter-1) /  5;
        remindervalue = (_counter-1) - dividedvalue * 5;
        xPosition = 2*(remindervalue+1) + remindervalue * xWidth;
        yPosition = 2*(dividedvalue+1) + dividedvalue*yHeight;
        UIButton *btnDisplay = (UIButton*) [btnContainer viewWithTag:(100+_counter)];     
        [btnDisplay setFrame:CGRectMake(xPosition, yPosition, xWidth, yHeight)];
        UILabel *dispLabel = (UILabel*) [btnDisplay viewWithTag:999];
        [dispLabel setFrame:CGRectMake(0, 0, xWidth, yHeight)];
    }
    if (misDispRpt) 
        [misDispRpt setForOrientation:p_intOrientation];
    
    if (smCustSearch) 
        [smCustSearch setForOrientation:p_intOrientation];
    
    if (stmtPreview) 
        [stmtPreview setForOrientation:p_intOrientation];
    
    if (salesMiningSelect) 
        [salesMiningSelect setForOrientation:p_intOrientation];
    
    if (purchMiningSelect) 
        [purchMiningSelect setForOrientation:p_intOrientation];
    
    if (yearSearch) 
        [yearSearch setForOrientation:p_intOrientation];
}

- (void) generateAccountStatement
{
    CGRect myFrame = self.view.frame;
    myFrame.origin.y = 0;
    myFrame.origin.x = 0;
    //smCustSearch = [[custSearch alloc] initWithFrame:myFrame forOrientation:currOrientation  andNotification:@"searchCustReturn_For_DSS" forSalesMan:[standardUserDefaults valueForKey:@"loggeduser"]  withNewDataNotification:@"custListGenerated_DSS"];
    METHODCALLBACK l_custSearchReturn = ^(NSDictionary* p_dictInfo)
    {
        [self searchCustomerReturn:p_dictInfo];
    };
    smCustSearch = [[custSearch alloc] initWithFrame:myFrame forOrientation:currOrientation andReturnMethod:l_custSearchReturn];
    [self.view addSubview:smCustSearch];
}

- (void) generateProductionStatement
{
    CGRect myFrame = self.view.frame;
    myFrame.origin.x = 0;
    myFrame.origin.y = 0;
    METHODCALLBACK l_yearSelectReturn = ^(NSDictionary* p_dictInfo)
    {
        [self yearSearchReturn:p_dictInfo];
    };
    yearSearch = [[yearSelect alloc] initWithFrame:myFrame forOrientation:currOrientation andReturnMethod:l_yearSelectReturn];
    [self.view addSubview:yearSearch];
}

- (void) yearSearchReturn:(NSDictionary*) yearInfo
{
    NSString *recdData = [yearInfo valueForKey:@"data"];
    [yearSearch removeFromSuperview];
    //[yearSearch release];
    yearSearch = nil;
    if (recdData) 
        [self generateSalesMiningRptType:@"MonthlyProductionDSS" andTagName:nil andTagValue:nil andYearval: recdData];
    [self setViewResizedForOrientation:currOrientation];
}

- (void) searchCustomerReturn:(NSDictionary *)custInfo
{
    NSDictionary *recdData = [custInfo valueForKey:@"data"];
    [smCustSearch removeFromSuperview];
   // [smCustSearch release];
    smCustSearch = nil;
    if (recdData) 
    {
        //NSLog(@"received cust info %@",recdData);
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[recdData valueForKey:@"CD"]  ,@"sledcode", nil];
        stmtPreview = [[genPrintView alloc] initWithDictionary:inputDict andOrientation:currOrientation andFrame:self.view.frame andReporttype:@"CustomerDatabase" andReturnMethod:_printScreenReturn];
        [stmtPreview setForOrientation:currOrientation];
        [self.view addSubview:stmtPreview];    
    }
    [self setViewResizedForOrientation:currOrientation];
}

- (void) printingScreenBack:(NSDictionary*) printInfo
{
    NSDictionary *recdData = [printInfo valueForKey:@"data"];
    [stmtPreview removeFromSuperview];
    /*if (stmtPreview) 
        [stmtPreview release];*/
    stmtPreview = nil;
    if (recdData) 
    {
        NSString *rptType = [[NSString alloc] initWithFormat:@"%@", [printInfo  valueForKey:@"reporttype"]];
        if ([[rptType substringToIndex:12] isEqualToString:@"MonthlySales"]==YES | [rptType isEqualToString:@"ExportorLocalSales"]==YES | [rptType isEqualToString:@"SalesmanwiseSales"]==YES | [rptType isEqualToString:@"ItemwiseSales"]==YES | [rptType isEqualToString:@"YearlySalesmanwiseSales"]==YES | [rptType isEqualToString:@"YearlyExportVsLocalSales"]==YES)
        {
            salesMiningSelect = [[misSalesMiningSelect alloc] initWithFrame:self.view.frame forOrientation:currOrientation andInitialDict:salesMiningStoredData withReturnMethod:_salesMiningReturn];
            [self.view addSubview:salesMiningSelect];
        }
        if ([rptType isEqualToString:@"MonthlyPurchasesMining"]==YES | [rptType isEqualToString:@"PurchasesSupplierMining"]==YES | [rptType isEqualToString:@"PurchasesCatQtyMining"]==YES | [rptType isEqualToString:@"PurchasesCatValMining"]==YES | [rptType isEqualToString:@"PurchasesCatAvgMining"]==YES) 
        {
            purchMiningSelect = [[misPurchMiningSelect alloc] initWithFrame:self.view.frame forOrientation:currOrientation andInitialDict:purchMiningStoredData andReturnMethod:_purchMiningReturn];
            [self.view addSubview:purchMiningSelect];
        }
    }
    [self setViewResizedForOrientation:currOrientation];
}

- (void) salesMiningReturn :(NSDictionary*) smReturnInfo
{
    NSDictionary *recdData = [smReturnInfo valueForKey:@"data"];
    int l_reportno = [[recdData valueForKey:@"reportno"] intValue];
    if (l_reportno>0) 
    {
        /*if (salesMiningStoredData) 
            [salesMiningStoredData release];*/
        salesMiningStoredData = [[NSDictionary alloc] initWithDictionary:[salesMiningSelect returnSalesMiningStoredData]];
    }
    [salesMiningSelect removeFromSuperview];
    /*if (salesMiningSelect) 
        [salesMiningSelect release];*/
    salesMiningSelect = nil;
    switch (l_reportno) {
        case 1:
            //[self genMonthlySalesStmt];
            [self generateSalesMiningRptType:@"MonthlySalesMining" andTagName:nil andTagValue:nil andYearval:nil];
            break;
        case 2:
            [self generateSalesMiningRptType:@"MonthlySalesCustomerwiseMining" andTagName:@"customercode" andTagValue:[recdData valueForKey:@"customercode"] andYearval: nil];

            //[self genMonthlySalesStmtCustomerwise:[recdData valueForKey:@"customercode"]];
            break;
        case 3:
            [self generateSalesMiningRptType:@"MonthlySalesCategorywiseMining" andTagName:@"categorycode" andTagValue:[recdData valueForKey:@"categorycode"] andYearval: nil];
            //[self genMonthlySalesStmtCategorywise:[recdData valueForKey:@"categorycode"]];
            break;
        case 4:
            //[self genMonthlySalesStmtProdwise];
            [self generateSalesMiningRptType:@"MonthlySalesProdwiseMining" andTagName:nil andTagValue:nil andYearval: [recdData valueForKey:@"yearcode"]];
            break;
        case 5:
            //[self genMonthlySalesStmtSalesmanwise:[recdData valueForKey:@"salesmancode"]];
            [self generateSalesMiningRptType:@"MonthlySalesSalesmanwiseMining" andTagName:@"salesmancode" andTagValue:[recdData valueForKey:@"salesmancode"] andYearval: nil];
            break;
        case 6:
            //[self genExportorLocalSales];
            [self generateSalesMiningRptType:@"ExportorLocalSales" andTagName:nil andTagValue:nil andYearval: nil];
            break;
        case 7:
            //[self genSalesmanwiseSales];
            [self generateSalesMiningRptType:@"SalesmanwiseSales" andTagName:nil andTagValue:nil andYearval: [recdData valueForKey:@"yearcode"]];
            break;
        case 8:
            [self generateSalesMiningRptType:@"ItemwiseSales" andTagName:nil andTagValue:nil andYearval: [recdData valueForKey:@"yearcode"]];
            break;
        case 9:
            [self generateSalesMiningRptType:@"YearlySalesmanwiseSales" andTagName:nil andTagValue:nil andYearval: [recdData valueForKey:@"yearcode"]];
            break;
        case 10:
            [self generateSalesMiningRptType:@"YearlyExportVsLocalSales" andTagName:nil andTagValue:nil andYearval: [recdData valueForKey:@"yearcode"]];
            break;
        default:
            break;
    }
    [self setViewResizedForOrientation:currOrientation];
}

- (void) generateSalesMiningRptType:(NSString*) p_reportType andTagName:(NSString*) p_tagname andTagValue:(NSString*) p_tagValue andYearval:(NSString*) p_yearCode
{
    NSMutableDictionary *inputDict ;
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateFormat:@"yy"];
    NSString *startDate =[[NSString alloc] initWithFormat:@"01-Jan-%@",[nsdf stringFromDate:[NSDate date]]];
    [nsdf setDateFormat:@"dd-MMM-yy"];
    NSString *endDate =[[NSString alloc] initWithFormat:@"%@",[nsdf stringFromDate:[NSDate date]]];
    [nsdf setDateFormat:@"yyyy"];
    inputDict= [[NSMutableDictionary alloc] initWithObjectsAndKeys:startDate,@"fromdate", endDate, @"todate",[[NSUserDefaults standardUserDefaults] objectForKey:@"loggeduser"], @"username",nil];
    if (p_tagname) 
        [inputDict setValue:p_tagValue forKey:p_tagname];

    if (p_yearCode)
        [inputDict setValue:p_yearCode forKey:@"yearcode"];
    else
        [inputDict setValue:[nsdf stringFromDate:[NSDate date]] forKey:@"yearcode"];
        
    //NSLog(@"the dictionary values are %@", inputDict);
    stmtPreview = [[genPrintView alloc] initWithDictionary:inputDict andOrientation:currOrientation andFrame:self.view.frame andReporttype:p_reportType andReturnMethod:_printScreenReturn];
    [self.view addSubview:stmtPreview];   
}

- (void) purchMiningReturn :(NSDictionary*) purchInfo
{
    NSDictionary *recdData = [purchInfo valueForKey:@"data"];
    int l_reportno = [[recdData valueForKey:@"reportno"] intValue];
    if (l_reportno>0) 
    {
        /*if (purchMiningStoredData) 
            [purchMiningStoredData release];*/
        purchMiningStoredData = [[NSDictionary alloc] initWithDictionary:[purchMiningSelect returnPurchaseMiningStoredData]];
    }
    [purchMiningSelect removeFromSuperview];
    /*if (purchMiningSelect) 
        [purchMiningSelect release];*/
    purchMiningSelect = nil;
    switch (l_reportno) {
        case 1:
            [self generateSalesMiningRptType:@"MonthlyPurchasesMining" andTagName:nil andTagValue:nil andYearval:nil];
            break;
        case 2:
            [self generateSalesMiningRptType:@"PurchasesSupplierMining" andTagName:@"suppliercode" andTagValue:[recdData valueForKey:@"suppliercode"] andYearval:nil];
            break;
        case 3:
            [self generateSalesMiningRptType:@"PurchasesCatQtyMining" andTagName:@"categorycode" andTagValue:[recdData valueForKey:@"categorycode"] andYearval:nil];
            break;
        case 4:
            [self generateSalesMiningRptType:@"PurchasesCatValMining" andTagName:@"categorycode" andTagValue:[recdData valueForKey:@"categorycode"] andYearval:nil];
            break;
        case 5:
            [self generateSalesMiningRptType:@"PurchasesCatAvgMining" andTagName:@"categorycode" andTagValue:[recdData valueForKey:@"categorycode"] andYearval:nil];
            break;
        default:
            break;
    }
    [self setViewResizedForOrientation:currOrientation];
}


@end
