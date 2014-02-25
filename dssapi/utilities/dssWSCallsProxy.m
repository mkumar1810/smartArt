//
//  dssWSCallsProxy.m
//  dssapi
//
//  Created by Imac DOM on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "dssWSCallsProxy.h"

@implementation dssWSCallsProxy

- (void) initWithReportType:(NSString*) reportType andInputParams:(NSDictionary*) prmDict andReturnMethod:(METHODCALLBACK) p_returnMethod andReturnInputs:(BOOL) p_retInputs
{
    /*self = [super init];
    if (self) {*/
        _reportType = [[NSString alloc] initWithFormat:@"%@", reportType];
        _postProxyReturn = p_returnMethod;
        if (prmDict) 
            inputParms = [[NSDictionary alloc] initWithDictionary:prmDict];
        dictData = [[NSMutableArray alloc] init];
        _returnInputParams = p_retInputs;
        [self generateData];
    /*}
    return self;    */
}

- (void) initWithReportType:(NSString*) reportType andInputParams:(NSDictionary*) prmDict andReturnMethod:(METHODCALLBACK) p_returnMethod
{
    /*self = [super init];
    if (self) {*/
        _reportType = [[NSString alloc] initWithFormat:@"%@", reportType];
        _postProxyReturn = p_returnMethod;
        if (prmDict) 
            inputParms = [[NSDictionary alloc] initWithDictionary:prmDict];
        dictData = [[NSMutableArray alloc] init];
        _returnInputParams = NO;
        [self generateData];
    /*}
    return self;    */
}

/*- (id) initWithReportType:(NSString*) reportType andInputParams:(NSDictionary*) prmDict andNotificatioName:(NSString*) notificationName
{
    self = [super init];
    if (self) {
        _reportType = [[NSString alloc] initWithFormat:@"%@", reportType];
        _notificationName = [[NSString alloc] initWithFormat:@"%@", notificationName];
        if (prmDict) 
            inputParms = [[NSDictionary alloc] initWithDictionary:prmDict];
        dictData = [[NSMutableArray alloc] init];
        _returnInputParams = NO;
        [self generateData];
    }
    return self;    
}

- (id) initWithReportType:(NSString*) reportType andInputParams:(NSDictionary*) prmDict andNotificatioName:(NSString*) notificationName andReturnInputs:(BOOL) p_retInputs
{
    self = [super init];
    if (self) {
        _reportType = [[NSString alloc] initWithFormat:@"%@", reportType];
        _notificationName = [[NSString alloc] initWithFormat:@"%@", notificationName];
        if (prmDict) 
            inputParms = [[NSDictionary alloc] initWithDictionary:prmDict];
        dictData = [[NSMutableArray alloc] init];
        _returnInputParams = p_retInputs;
        [self generateData];
    }
    return self;    
}*/

- (void) generateData
{
    NSString *soapMessage,*msgLength,*soapAction;
    NSURL *url;
    NSMutableURLRequest *theRequest;
    NSURLConnection *theConnection;
    
    if ([_reportType isEqualToString:@"APPROVEDOCUMENT"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<approveMasterDocument xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_divcode>%@</p_divcode>\n"
                       "<p_compcode>%@</p_compcode>\n"
                       "<p_doccode>%@</p_doccode>\n"
                       "<p_usercode>%@</p_usercode>\n"
                       "<p_yearcode>%@</p_yearcode>\n"
                       "<p_apptab1>%@</p_apptab1>\n"
                       "<p_intdocno>%@</p_intdocno>\n"
                       "<p_tab1intdoc>%@</p_tab1intdoc>\n"
                       "<p_doclvl>%@</p_doclvl>\n"
                       "<p_other>%@</p_other>\n"
                       "<p_userdoclvl>%@</p_userdoclvl>\n"
                       "</approveMasterDocument>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_divcode"],[inputParms valueForKey:@"p_compcode"],[inputParms valueForKey:@"p_doccode"],[inputParms valueForKey:@"p_usercode"],[inputParms valueForKey:@"p_yearcode"],[inputParms valueForKey:@"p_apptab1"],[inputParms valueForKey:@"p_intdocno"],[inputParms valueForKey:@"p_tab1intdoc"],[inputParms valueForKey:@"p_doclvl"],[inputParms valueForKey:@"p_other"],[inputParms valueForKey:@"p_userdoclevl"]];
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, APPROVEDOCUMENT_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/approveMasterDocument"];
    }

    if ([_reportType isEqualToString:@"SUPPLIERSLIST"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getSupplierList xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_searchtext>%@</p_searchtext>\n"
                       "</getSupplierList>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_searchtext"]];
                       
        NSLog(@"supplier list soap message %@", soapMessage);
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, SUPPLIERLIST_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getSupplierList"];
    }

    if ([_reportType isEqualToString:@"MISPURCHASEMINING"]==YES) 
    {
        
        NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
        [returnInfo setValue:nil forKey:@"data"];
        if (_returnInputParams) 
            [returnInfo setValue:inputParms forKey:@"inputs"];
        //[[NSNotificxationCenter defaultCenter] postNotxificationName:_notificationName object:self userInfo:returnInfo];
        _postProxyReturn(returnInfo);
        return;
    }

    
    if ([_reportType isEqualToString:@"MISSALESMINING"]==YES | [_reportType isEqualToString:@"YEARLIST"]==YES) 
    {
        
        NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
        [returnInfo setValue:nil forKey:@"data"];
        if (_returnInputParams) 
            [returnInfo setValue:inputParms forKey:@"inputs"];
        //[[NSNotifxicationCenter defaultCenter] postNotxificationName:_notificationName object:self userInfo:returnInfo];
        _postProxyReturn(returnInfo);
        return;
    }
    
    if ([_reportType isEqualToString:@"SALESMANLIST"]) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getSalesmanNamesList xmlns=\"http://aahg.ws.org/\" />\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>"];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, SALESMANLIST_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getSalesmanNamesList"];
        
    }
    

    if ([_reportType isEqualToString:@"CATEGORYLIST"]==YES) 
    {
        
        soapMessage = [NSString stringWithString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getCategoryNameList xmlns=\"http://aahg.ws.org/\" />\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>"];
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, CATEGORYLIST_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getCategoryNameList"];
    }

    if ([_reportType isEqualToString:@"CUSTOMERSLIST"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getCustomerList xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_searchtext>%@</p_searchtext>\n"
                       "<p_noofrecs>%@</p_noofrecs>\n"
                       "<p_lastcode>%@</p_lastcode>\n"
                       "</getCustomerList>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_searchtext"],[inputParms valueForKey:@"p_noofrecs"],[inputParms valueForKey:@"p_lastcode"]];
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, CUSTOMERLIST_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getCustomerList"];
    }

    if ([_reportType isEqualToString:@"MISPURCHSALESIMPEXP"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISPurchaseSalesImpExp xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_offset>%@</p_offset>\n"
                       "</getMISPurchaseSalesImpExp>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_offset"]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISPURCHSALESIMPEXP_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISPurchaseSalesImpExp"];
    }    
    

    if ([_reportType isEqualToString:@"MISCREDITORAGEING"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISCreditorAgeing xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "</getMISCreditorAgeing>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_reporttype"]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISCREDITORAGEING_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISCreditorAgeing"];
    }    
    
    if ([_reportType isEqualToString:@"MISDEBTORAGEING"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISDebtorAgeing xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "</getMISDebtorAgeing>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_reporttype"]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISDEBTORAGEING_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISDebtorAgeing"];
    }    
    
    if ([_reportType isEqualToString:@"MISPURCHSALES"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISPurchaseVsSales xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_offset>%@</p_offset>\n"
                       "</getMISPurchaseVsSales>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_dayoffset"]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISPURCHSALES_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISPurchaseVsSales"];
    }    
    
    if ([_reportType isEqualToString:@"MISFGTRANSFER"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISFGTransferredToStore xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_offset>%@</p_offset>\n"
                       "</getMISFGTransferredToStore>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_dayoffset"]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISFGTRANSFER_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISFGTransferredToStore"];
    }    

    if ([_reportType isEqualToString:@"MISSALESCOLLECTION"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISSalesCollection xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_offset>%@</p_offset>\n"
                       "</getMISSalesCollection>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_dayoffset"]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISSALESCOLLECTION_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISSalesCollection"];
    }    

    if ([_reportType isEqualToString:@"MISCATEGORYWISESALES"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISCategorywiseSales xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_offset>%@</p_offset>\n"
                       "</getMISCategorywiseSales>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_dayoffset"]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISCATEGORYWISESALES_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISCategorywiseSales"];
    }    
    
    if ([_reportType isEqualToString:@"MISSALESANALYSIS"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISSalesAnalysis xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_dayoffset>%@</p_dayoffset>\n"
                       "</getMISSalesAnalysis>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>",[inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_dayoffset"]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISSALESANALYSIS_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISSalesAnalysis"];
    }    
    if ([_reportType isEqualToString:@"MISBUSSINVSMDAILY"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISBusInvSalesManMonthly xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_monthoffset>%@</p_monthoffset>\n"
                       "</getMISBusInvSalesManMonthly>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_monthoffset"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISBUSSINVSMDAILY_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISBusInvSalesManMonthly"];
    }

    if ([_reportType isEqualToString:@"MISBUSSINVDAILY"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISBusInvDailyStmt xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_monthoffset>%@</p_monthoffset>\n"
                       "</getMISBusInvDailyStmt>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_monthoffset"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISBUSSINVDAILY_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISBusInvDailyStmt"];
    }

    if ([_reportType isEqualToString:@"MISBUSSINVCOLN"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISBusInvColn xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_reporttype>%@</p_reporttype>\n"
                       "<p_fordate>%@</p_fordate>\n"
                       "<p_dayoffset>%@</p_dayoffset>\n"
                       "</getMISBusInvColn>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_reporttype"],[inputParms valueForKey:@"p_fordate"],[inputParms valueForKey:@"p_dayoffset"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISBUSSINVCOLN_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISBusInvColn"];
    }

    
    if ([_reportType isEqualToString:@"MISFRONTDISPLAY"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getMISFrontDisplay xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_usercode>%@</p_usercode>\n"
                       "<p_module>%@</p_module>\n"
                       "</getMISFrontDisplay>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_usercode"],[inputParms valueForKey:@"p_module"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, MISFRONTDISP_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getMISFrontDisplay"];
    }
    

    if ([_reportType isEqualToString:@"APPROVALDOCDETAIL"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getApprovalDocumentDetail xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_divcode>%@</p_divcode>\n"
                       "<p_documentcode>%@</p_documentcode>\n"
                       "<p_documentno>%@</p_documentno>\n"
                       "</getApprovalDocumentDetail>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_divcode"],[inputParms valueForKey:@"p_documentcode"], [inputParms valueForKey:@"p_documentno"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, APPLDETAIL_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getApprovalDocumentDetail"];
    }

    if ([_reportType isEqualToString:@"APPROVALMASTER"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getApprovalsMasterDetail xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_divcode>%@</p_divcode>\n"
                       "<p_userstatus>%@</p_userstatus>\n"
                       "<p_documentcode>%@</p_documentcode>\n"
                       "</getApprovalsMasterDetail>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_divcode"],[inputParms valueForKey:@"p_userstatus"], [inputParms valueForKey:@"p_documentcode"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, APPLMASTER_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getApprovalsMasterDetail"];
    }
    
    if ([_reportType isEqualToString:@"APPROVALHEADER"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getApprovalsHeaderDetail xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_divcode>%@</p_divcode>\n"
                       "<p_usercode>%@</p_usercode>\n"
                       "<p_module>%@</p_module>\n"
                       "</getApprovalsHeaderDetail>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_divcode"],[inputParms valueForKey:@"p_usercode"], [inputParms valueForKey:@"p_module"] ];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, APPLHEADER_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getApprovalsHeaderDetail"];
    }
    if ([_reportType isEqualToString:@"BAR"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getDBDPurchaseSalesForQuarterMonthly xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_fordate>%@</p_fordate>\n"
                       "<p_monthoffset>%@</p_monthoffset>\n"
                       "</getDBDPurchaseSalesForQuarterMonthly>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_fordate"],[inputParms valueForKey:@"p_monthoffset"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, BARPURCHSALES_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getDBDPurchaseSalesForQuarterMonthly"];
    }

    
    if ([_reportType isEqualToString:@"PIE"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getDBDSalesInvoiceMTD xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_fordate>%@</p_fordate>\n"
                       "<p_monthoffset>%@</p_monthoffset>\n"
                       "</getDBDSalesInvoiceMTD>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_fordate"],[inputParms valueForKey:@"p_monthoffset"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, PIESALESINV_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getDBDSalesInvoiceMTD"];
    }
    
    if ([_reportType isEqualToString:@"BARSC"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getDBDPurchaseSalesForQuarterMonthly xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_fordate>%@</p_fordate>\n"
                       "<p_monthoffset>%@</p_monthoffset>\n"
                       "</getDBDPurchaseSalesForQuarterMonthly>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_fordate"],[inputParms valueForKey:@"p_monthoffset"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, BARSALESCOLN_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getDBDPurchaseSalesForQuarterMonthly"];
    }
    
    if ([_reportType isEqualToString:@"LC"]==YES) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<getDBBusInvColn xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_startdate>%@</p_startdate>\n"
                       "<p_enddate>%@</p_enddate>\n"
                       "</getDBBusInvColn>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_startdate"],[inputParms valueForKey:@"p_enddate"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, LCBUSINVCOLN_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/getDBBusInvColn"];
    }
    
    if ([_reportType isEqualToString:@"USERLOGIN"]) 
    {
        soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       "<soap:Body>\n"
                       "<userLogin xmlns=\"http://aahg.ws.org/\">\n"
                       "<p_eMail>%@</p_eMail>\n"
                       "<p_passWord>%@</p_passWord>\n"
                       "</userLogin>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>", [inputParms valueForKey:@"p_eMail"],[inputParms valueForKey:@"p_passWord"]];     
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",MAIN_URL, WS_ENV, LOGIN_URL]];
        
        soapAction = [NSString stringWithFormat:@"%@",@"http://aahg.ws.org/userLogin"];
    }
    
    
    theRequest = [NSMutableURLRequest requestWithURL:url];
    msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(theConnection)
        webData = [[NSMutableData data] init];
    else 
        NSLog(@"theConnection is NULL");
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self processAndReturnXMLMessage];
    //[connection release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *errmsg = [error description];
    [self showAlertMessage:errmsg];
    //[connection release];
    //[webData release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict   
{
    [parseElement setString:elementName];
    if ([elementName isEqualToString:@"Table"]) {
        resultDataStruct = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([parseElement isEqualToString:@""]==NO) 
        [resultDataStruct setValue:string forKey:parseElement];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [parseElement setString:@""];
    if ([elementName isEqualToString:@"Table"]) 
    {
        if (resultDataStruct) {
            [dictData addObject:resultDataStruct];
            //[resultDataStruct release];
        }
    }
}

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

- (void) processAndReturnXMLMessage
{
    parseElement = [[NSMutableString alloc] initWithString:@""];	
	NSString *theXML = [self htmlEntityDecode:[[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding]];
    //NSLog(@"the data received %@",theXML);
    if (theXML) {
        if ([theXML isEqualToString:@""]==YES) 
        {
            [self showAlertMessage:@"Web service failure"];
            //[webData release];
            return;
        }
    }
    else
    {
        [self showAlertMessage:@"Web service failure"];
        //[webData release];
        return;
    }
    /*xmlParser = [[NSXMLParser alloc] initWithData:webData];*/
    @try 
    {
        xmlParser = [[NSXMLParser alloc] initWithData:[theXML dataUsingEncoding:NSUTF8StringEncoding]];
        [xmlParser setDelegate:self];
        [xmlParser setShouldResolveExternalEntities:YES];
        [xmlParser parse];
        //[xmlParser release];
    }
    @catch (NSException *exception) {
        [self showAlertMessage:[exception description]];
        //[webData release];
        return;
    }
    
    NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
    [returnInfo setValue:dictData forKey:@"data"];
    if (_returnInputParams) 
        [returnInfo setValue:inputParms forKey:@"inputs"];
    //NSLog(@"the report type %@ input params are %@", _reportType, inputParms);
    //if (_postProxyReturn) 
        _postProxyReturn(returnInfo);
    /*else
        [[NSNotifxicationCenter defaultCenter] postNotifxicationName:_notificationName object:self userInfo:returnInfo];*/
    //[webData release];
}

-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return string;
}

-(NSString *)htmlEntitycode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    string = [string stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    return string;
}

@end
