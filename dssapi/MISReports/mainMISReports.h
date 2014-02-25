//
//  mainMISReports.h
//  dssapi
//
//  Created by Raja T S Sekhar on 3/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misBaseReport.h"
#import "busInvColnReport.h"
#import "misBusInvDaily.h"
#import "misSalesManMonthly.h"
#import "dssWSCallsProxy.h"
#import "misSalesAnalysis.h"
#import "misCategorySales.h"
#import "misSalesCollection.h"
#import "misFGTransferred.h"
#import "misPurchaseSales.h"
#import "misDebtorAgeing.h"
#import "misCreditorAgeing.h"
#import "misPurchaseSalesImpExp.h"
#import "custSearch.h"
#import "genPrintView.h"
#import "misSalesMiningSelect.h"
#import "misPurchMiningSelect.h"
#import "yearSelect.h"

@interface mainMISReports : UIViewController 
{
    BOOL initialized; 
    NSDictionary *serviceFDData, *salesMiningStoredData, *purchMiningStoredData;
    NSString *_loggeduser;
    NSString *_currentdate;
    IBOutlet UIView *btnContainer;
    IBOutlet UILabel *btnReportDisp;
    IBOutlet UIActivityIndicatorView *actIndicator;
    misBaseReport *misDispRpt;
    UIInterfaceOrientation currOrientation;
    custSearch *smCustSearch;
    yearSelect *yearSearch;
    genPrintView *stmtPreview;
    misSalesMiningSelect *salesMiningSelect;
    misPurchMiningSelect *purchMiningSelect;
    METHODCALLBACK _salesMiningReturn;
    METHODCALLBACK _purchMiningReturn;
    METHODCALLBACK _printScreenReturn;
    METHODCALLBACK _pendingDocsInvoked;
}

- (void) initialize;
- (void) misFDDataGenerated : (NSDictionary*) fdData;
- (void) populateFDData:(NSDictionary*) fdDispDict;
- (IBAction) buttonPressed:(id) sender;
- (void) setViewResizedForOrientation:(UIInterfaceOrientation) p_intOrientation;
- (void) generateAccountStatement;
- (void) generateSalesMiningRptType:(NSString*) p_reportType andTagName:(NSString*) p_tagname andTagValue:(NSString*) p_tagValue andYearval:(NSString*) p_yearCode;
- (void) generateProductionStatement;
- (void) searchCustomerReturn:(NSDictionary *)custInfo;
- (void) salesMiningReturn :(NSDictionary*) smReturnInfo;
- (void) purchMiningReturn :(NSDictionary*) purchInfo;
- (void) printingScreenBack:(NSDictionary*) printInfo;
- (void) yearSearchReturn:(NSDictionary*) yearInfo;
- (void) pendingDocksMethod:(METHODCALLBACK) p_pendingDocMethod;
                             
@end
