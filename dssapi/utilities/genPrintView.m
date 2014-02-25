//
//  genPrintView.m
//  salesapi
//
//  Created by Imac on 5/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "genPrintView.h"


@implementation genPrintView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    CGRect frame;
    intOrientation = p_forOrientation;
    
    if (UIInterfaceOrientationIsPortrait(p_forOrientation)) 
    {
        frame = CGRectMake(initialFrame.origin.x, initialFrame.origin.y, 768, 1004);
        [wv setFrame:CGRectMake(10, 54, 748, 900)];
        [actIndicator setFrame:CGRectMake(366, 483, 37, 37)];
        //[actIndicator setFrame:CGRectMake(366, 483,100, 100)];
    }
    else
    {
        frame = CGRectMake(initialFrame.origin.x, initialFrame.origin.y, 1028, 768);
        [wv setFrame:CGRectMake(10, 54, 984, 664)];
        [actIndicator setFrame:CGRectMake( 483,366, 37, 37)];
        actIndicator.transform = CGAffineTransformMakeScale(5.00, 5.00);        
    }
    NSLog(@"initail frame x %f and y %f", initialFrame.origin.x, initialFrame.origin.y);
    [[self viewWithTag:10001] setFrame:frame];
}

- (id) initWithCollectionId:(NSString*) p_colnid andOrientation:(UIInterfaceOrientation) p_intOrientation andFrame:(CGRect) dispFrame andReporttype:(NSString*) p_reporttype andIdFldName:(NSString*) p_idfldname andReturnMethod:(METHODCALLBACK)p_returnMethod
{
    self = [super initWithFrame:dispFrame];
    if (self) {
        initialFrame = dispFrame;
        [self addNIBView:@"genPrintView" forFrame:dispFrame];
        _colnId = [[NSString alloc] initWithFormat:@"%@",p_colnid];
        _reportType = [[NSString alloc] initWithFormat:@"%@",p_reporttype];
        _idFldName = [[NSString alloc] initWithFormat:@"%@", p_idfldname];
        //_notificationName = [[NSString alloc] initWithFormat:@"%@", p_notificationname];
        _returnMethod = p_returnMethod;
        if ([_reportType isEqualToString:@"sopreview"]) [navTitle setTitle:@"Sales order preview"];
        intOrientation = p_intOrientation;
        actIndicator.hidden = NO;
        actIndicator.hidesWhenStopped = YES;
        actIndicator.transform = CGAffineTransformMakeScale(5.00, 5.00);        
        [actIndicator startAnimating];
        [self generatePrintView];
    }
    return  self;
}
- (id) initWithDictionary:(NSDictionary*) p_inputParams andOrientation:(UIInterfaceOrientation) p_intOrientation andFrame:(CGRect) dispFrame andReporttype:(NSString*) p_reporttype  andReturnMethod:(METHODCALLBACK)p_returnMethod
{
    self = [super initWithFrame:dispFrame];
    if (self) {
        initialFrame = dispFrame;
        [self addNIBView:@"genPrintView" forFrame:dispFrame];
        _reportType = [[NSString alloc] initWithFormat:@"%@",p_reporttype];
        //_notificationName = [[NSString alloc] initWithFormat:@"%@", p_notificationname];
        _returnMethod = p_returnMethod;
        if (p_inputParams) 
            inputParms = [[NSDictionary alloc] initWithDictionary:p_inputParams];
        if ([_reportType isEqualToString:@"Accountpreview"]) [navTitle setTitle:@"Customer statement"];
        if ([_reportType isEqualToString:@"CustomerDatabase"]) [navTitle setTitle:@"Customer statement"];
        if ([_reportType isEqualToString:@"MonthlySalesMining"]) [navTitle setTitle:@"Monthly Sales statement"];
        if ([_reportType isEqualToString:@"MonthlySalesCustomerwiseMining"]) [navTitle setTitle:@"Monthly Sales customerwise"];
        if ([_reportType isEqualToString:@"MonthlySalesCategorywiseMining"]) [navTitle setTitle:@"Monthly Sales categorywise"];
        if ([_reportType isEqualToString:@"MonthlySalesProdwiseMining"]==YES) [navTitle setTitle:@"Monthly Sales productwise"];
        if ([_reportType isEqualToString:@"MonthlySalesSalesmanwiseMining"]==YES) [navTitle setTitle:@"Monthly Sales Salesmanwise"];
        if ([_reportType isEqualToString:@"ExportorLocalSales"]==YES) [navTitle setTitle:@"Export or Local sales"];
        if ([_reportType isEqualToString:@"SalesmanwiseSales"]==YES) [navTitle setTitle:@"Salesmanwise Sales"];
        if ([_reportType isEqualToString:@"ItemwiseSales"]==YES)  [navTitle setTitle:@"Itemwise Sales"];
        if ([_reportType isEqualToString:@"YearlySalesmanwiseSales"]==YES)  [navTitle setTitle:@"Yearly salesmanwise Sales"];
        if ([_reportType isEqualToString:@"YearlyExportVsLocalSales"]==YES) [navTitle setTitle:@"Yearly Export Vs Local sales"];
        if ([_reportType isEqualToString:@"MonthlyPurchasesMining"]==YES) [navTitle setTitle:@"Monthly Purchases Summary"];
        if ([_reportType isEqualToString:@"PurchasesSupplierMining"]==YES) [navTitle setTitle:@"Purchases Supplierwise Summary"];
        if ([_reportType isEqualToString:@"PurchasesCatQtyMining"]==YES) [navTitle setTitle:@"Purchases Categorywise (Qty)"];
        if ([_reportType isEqualToString:@"PurchasesCatValMining"]==YES) [navTitle setTitle:@"Purchases Categorywise (Val)"];
        if ([_reportType isEqualToString:@"PurchasesCatAvgMining"]==YES) [navTitle setTitle:@"Purchases Categorywise (Avg)"];
        if ([_reportType isEqualToString:@"MonthlyProductionDSS"]==YES) [navTitle setTitle:@"Monthly Production"];
        actIndicator.transform = CGAffineTransformMakeScale(5.00, 5.00);        
        intOrientation = p_intOrientation;
        actIndicator.hidden = NO;
        actIndicator.hidesWhenStopped = YES;
        [actIndicator startAnimating];
        [self generatePrintView];
    }
    return  self;
}


- (void) addNIBView:(NSString*) nibName  forFrame:(CGRect) forframe
{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:nibName
                                                      owner:self
                                                    options:nil];
    UIView *newview = [nibViews objectAtIndex:0];
    [newview setFrame:forframe];
    newview.tag = 10001;
    [self addSubview:newview];        // Initialization code
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    //[super dealloc];
}

- (void) generatePrintView
{
    BOOL isRESTReport = NO;
    NSMutableString *pvURL=[[NSMutableString alloc]initWithFormat:@"%@%@%@reporttype=%@&%@=%@",MAIN_URL,WS_ENV,  @"/colnreceipt.aspx?",_reportType, _idFldName, _colnId];
    if ([_reportType isEqualToString:@"Accountpreview"]==YES) 
        pvURL=[[NSMutableString alloc]initWithFormat:@"%@%@%@reporttype=%@&sledcode=%@&salesmancode=%@",MAIN_URL,WS_ENV,  @"/colnreceipt.aspx?",_reportType, [inputParms valueForKey:@"sledcode"],[inputParms valueForKey:@"salesmancode"]];

    if ([_reportType isEqualToString:@"CustomerDatabase"]==YES) 
    {
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"yy"];
        NSString *startDate =[[NSString alloc] initWithFormat:@"01-Jan-%@",[nsdf stringFromDate:[NSDate date]]];
        [nsdf setDateFormat:@"dd-MMM-yy"];
        NSString *endDate =[[NSString alloc] initWithFormat:@"%@",[nsdf stringFromDate:[NSDate date]]];
        [nsdf setDateFormat:@"yyyy"];
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\St_Customer_Database&userid=VG/VG@aasmis&paramform=NO&reportid=MATERIALREQUISITION&amtformat='FM999,999,990.00'&comp_code='API'&div_Code='API'&YearCode=%@&DocKey=SEQ&FromDate='%@'&todate='%@'&p_sledcode=%@&P_P1=&P_P2=&P_P3=&P_P4=&P_P5=&P_P6=&P_P7=",[nsdf stringFromDate:[NSDate date]], startDate, endDate,[inputParms valueForKey:@"sledcode"]];
        isRESTReport=YES;
    }
   
    if ([_reportType isEqualToString:@"MonthlySalesMining"]==YES) 
    {
        NSLog(@"the input dict values %@", inputParms);
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamining_Monthlysales.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];	
        isRESTReport=YES;
    }
    
    
    
    if ([_reportType isEqualToString:@"MonthlySalesCustomerwiseMining"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamine_Custwise.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=%@&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"],[inputParms valueForKey:@"customercode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];	
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"MonthlySalesCategorywiseMining"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\St_Datamine_Categorywise.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category='%@'&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"],[inputParms valueForKey:@"categorycode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];	
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"MonthlySalesProdwiseMining"]==YES) 
    {
        //return;
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamine_Productwise.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];	
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"MonthlySalesSalesmanwiseMining"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\St_Datamine_Smanwise.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE='%@'&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"], [inputParms valueForKey:@"salesmancode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"ExportorLocalSales"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\St_Datamine_Exporlocyearly.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }

    if ([_reportType isEqualToString:@"SalesmanwiseSales"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\St_Datamine_Smanyearly.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }
  
    if ([_reportType isEqualToString:@"ItemwiseSales"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamine_Itemwise.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }

    if ([_reportType isEqualToString:@"YearlySalesmanwiseSales"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamine_Yearlysmanwise.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"YearlyExportVsLocalSales"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamine_Yearlyexporloc.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&P_SALESMANCODE=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"MonthlyPurchasesMining"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamining_Monthlypurchases.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER=0&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"PurchasesSupplierMining"]==YES)
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamine_Supplierwise.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER='%@'&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category=0&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"],[inputParms valueForKey:@"suppliercode"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"PurchasesCatQtyMining"]==YES)
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\St_Datamine_Purchasesqty.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER='0'&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category='%@'&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"],[inputParms valueForKey:@"categorycode"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }
    
    if ([_reportType isEqualToString:@"PurchasesCatValMining"]==YES)
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\St_Datamine_Purchasesvalue.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER='0'&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category='%@'&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"],[inputParms valueForKey:@"categorycode"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }

    if ([_reportType isEqualToString:@"PurchasesCatAvgMining"]==YES)
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Sales\\Reports\\ST_Datamine_Purchasesavgrate.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990'&sessionid=1111&arraysize=50&username='%@'&p_CUSTOMER='0'&p_ITEMCODE=0&p_unit=0&p_group=0&p_subgroup=0&p_category='%@'&mdiv=0&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"],[inputParms valueForKey:@"categorycode"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport = YES;
    }
    
    if ([_reportType isEqualToString:@"MonthlyProductionDSS"]==YES) 
    {
        pvURL = [NSMutableString stringWithFormat:@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Production\\Reports\\Pr_Monthly_Production.rdf&userid=VG/VG@aasmis&paramform=no&MAXIMIZE=YES&comp_code='API'&div_code='API'&yearcode=%@&fromdate='%@'&todate='%@'&amtformat='FM999,999,990.00'&sessionid=1111&arraysize=50&username='%@'&P_INTPDJOBNO=0&P_DOCNO=0&p_costcode=0&p_itemcode=0&p_sledcode=0&p_orderno=&fromdate='%@'&todate='%@'",[inputParms valueForKey:@"yearcode"],[inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"], [inputParms valueForKey:@"username"], [inputParms valueForKey:@"fromdate"], [inputParms valueForKey:@"todate"]];
        isRESTReport=YES;
    }

    if (isRESTReport==YES) 
    {
        pvURL = (NSMutableString*)[pvURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        webData = [[NSMutableData alloc] init];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:pvURL]];
        //[[NSURLConnection alloc] initWithRequest:request delegate:self];
        [NSURLConnection connectionWithRequest:request delegate:self];
        return;
    }
    
    //NSLog(@"the user URL is %@",pvURL);
    
    //pvURL = [NSString stringWithFormat:@"%@",@"http://194.170.6.30:81/reports/rwservlet?destype=cache&desformat=pdf&report=D:\\AASMIS\\Fin\\Reports\\Acr_DrCrstatemnt_Detailslpowise.rdf&userid=VG/VG@aasmis&paramform=NO&comp_code='API'&div_code='API'&YearCode=2012&todate='02/05/2012'&p_p1=0&p_p2=30&p_p3=31&p_p4=60&p_p5=61&p_p6=90&p_p7=91&sledtype='DR'&amtformat='FM999,999,990.00'&sessionid=1111&username='SYSTEM ADMINISTRATOR'&status=2&P_accountcode='11-02-01-100'&p_sledcode='A0185'&mdiv='API'&P_SALESMANCODE=0"];
    //NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:pvURL]];
    /*pvURL = (NSMutableString*)[pvURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
     NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:pvURL]];
     NSLog(@"url string %@",pvURL);
     [[NSURLConnection alloc] initWithRequest:request delegate:self];
     webData = [[NSMutableData alloc] init];*/
    //NSLog(@"preview URL %@",pvURL);
    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:pvURL]];
    [wv loadRequest:req];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
    //[webData release];
    //[connection release];
    [actIndicator stopAnimating];
    actIndicator.hidden=TRUE;
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    /*NSMutableString *jsonString=[[NSMutableString alloc]initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"The received conrtent is is %@",jsonString);*/
    [wv loadData:webData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
    //[actIndicator stopAnimating];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //actIndicator.hidden = NO;
    //[actIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [actIndicator stopAnimating];
    //NSLog(@"report generation completed");
    actIndicator.hidden=YES;
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //NSLog(@"loading failed with error %@", error);
}

- (IBAction) goBack:(id) sender
{
    NSDictionary *returnInfo = [[NSDictionary alloc] initWithObjectsAndKeys:inputParms , @"data", _reportType, @"reporttype", nil];
    //[[NSNotificxationCenter defaultCenter] postNotifxicationName:_notificationName object:self userInfo:returnInfo];
    _returnMethod(returnInfo);
}

- (IBAction) printContents:(id) sender
{  UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    if(!controller){
        NSLog(@"Couldn't get shared UIPrintInteractionController!");
        return;
    }
    
    UIPrintInteractionCompletionHandler completionHandler = 
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(!completed && error){
            NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);	
        }
    };
    
    
    // Obtain a printInfo so that we can set our printing defaults.
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    // This application produces General content that contains color.
    printInfo.outputType = UIPrintInfoOutputGeneral;
    
    // We'll use the URL as the job name
    printInfo.jobName = @"Collection Receipt Printing";
    if ([_reportType isEqualToString:@"Accountpreview"]==YES)
    {
        printInfo.jobName = @"Customer Statement";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    
    if ([_reportType isEqualToString:@"MonthlySalesMining"]==YES) 
    {
        printInfo.jobName = @"Monthly Sales Statement";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    
    if ([_reportType isEqualToString:@"MonthlySalesCustomerwiseMining"]==YES) 
    {
        printInfo.jobName = @"Monthly Sales (customerwise)";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    
    if ([_reportType isEqualToString:@"MonthlySalesCategorywiseMining"]==YES) 
    {
        printInfo.jobName = @"Monthly Sales (categorywise)";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    if ([_reportType isEqualToString:@"MonthlySalesProdwiseMining"]==YES) 
    {
        printInfo.jobName = @"Monthly Sales (Productwise)";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
        
    }
    
    if ([_reportType isEqualToString:@"MonthlySalesSalesmanwiseMining"]==YES) 
    {
        printInfo.jobName = @"Monthly Sales (Salesmanwise)";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    
    if ([_reportType isEqualToString:@"ExportorLocalSales"]==YES) 
        printInfo.jobName = @"Export or Local sales";
    
    if ([_reportType isEqualToString:@"SalesmanwiseSales"]==YES)
    {
        printInfo.jobName = @"Monthly Sales salesmanwise";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
        
    }
    
    if ([_reportType isEqualToString:@"ItemwiseSales"]==YES) 
    {
        printInfo.jobName = @"Itemwise Sales";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    
    if ([_reportType isEqualToString:@"YearlySalesmanwiseSales"]==YES) 
        printInfo.jobName = @"Yearly salesmanwise Sales";
    
    if ([_reportType isEqualToString:@"YearlyExportVsLocalSales"]==YES) 
        printInfo.jobName = @"Yearly Export Vs Local Sales";
    
    if ([_reportType isEqualToString:@"MonthlyPurchasesMining"]==YES) 
    {
        printInfo.jobName = @"Monthly Purchases Summary";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    
    if ([_reportType isEqualToString:@"PurchasesSupplierMining"]==YES) 
    {
        printInfo.jobName = @"Purchases Supplierwise Summary";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }

    if ([_reportType isEqualToString:@"PurchasesCatQtyMining"]==YES)
    {
        printInfo.jobName = @"Purchases Categorywise(Qty)";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }

    if ([_reportType isEqualToString:@"PurchasesCatValMining"]==YES)
    {
        printInfo.jobName = @"Purchases Categorywise(Val)";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }

    if ([_reportType isEqualToString:@"PurchasesCatAvgMining"]==YES)
    {
        printInfo.jobName = @"Purchases Categorywise(Avg)";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    
    if ([_reportType isEqualToString:@"MonthlyProductionDSS"]==YES) 
    {
        printInfo.jobName = @"Monthly Production (Yearly)";
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    }
    
    // Set duplex so that it is available if the printer supports it. We
    // are performing portrait printing so we want to duplex along the long edge.
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    
    // Use this printInfo for this print job.
    controller.printInfo = printInfo;
    
    
    // Be sure the page range controls are present for documents of > 1 page.
    controller.showsPageRange = YES;
    
    // This code uses a custom UIPrintPageRenderer so that it can draw a header and footer.
    genPrintRenderer *colnPrint = [[genPrintRenderer alloc] init];
    // The MyPrintPageRenderer class provides a jobtitle that it will label each page with.
    colnPrint.jobTitle = printInfo.jobName;
    // To draw the content of each page, a UIViewPrintFormatter is used.
    UIViewPrintFormatter *viewFormatter = [wv viewPrintFormatter];
    viewFormatter.startPage =0;
    
    
#if SIMPLE_LAYOUT
    /*
     For the simple layout we simply set the header and footer height to the height of the
     text box containing the text content, plus some padding.
     
     To do a layout that takes into account the paper size, we need to do that 
     at a point where we know that size. The numberOfPages method of the UIPrintPageRenderer 
     gets the paper size and can perform any calculations related to deciding header and
     footer size based on the paper size. We'll do that when we aren't doing the simple 
     layout.
     */
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:HEADER_FOOTER_TEXT_HEIGHT]; 
    CGSize titleSize = [colnPrint.jobTitle sizeWithFont:font];
    colnPrint.headerHeight = colnPrint.footerHeight = titleSize.height + HEADER_FOOTER_MARGIN_PADDING;
#endif
    [colnPrint addPrintFormatter:viewFormatter startingAtPageAtIndex:0];
    // Set our custom renderer as the printPageRenderer for the print job.
    controller.printPageRenderer = colnPrint;
    //[colnPrint release];
    
    // The method we use presenting the printing UI depends on the type of 
    // UI idiom that is currently executing. Once we invoke one of these methods
    // to present the printing UI, our application's direct involvement in printing
    // is complete. Our custom printPageRenderer will have its methods invoked at the
    // appropriate time by UIKit.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        [controller presentFromBarButtonItem:printButton animated:YES completionHandler:completionHandler];  // iPad
    else
        [controller presentAnimated:YES completionHandler:completionHandler];  // iPhone
}

@end
