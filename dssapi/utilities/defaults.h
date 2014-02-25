//
//  defaults.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WS_ENV @"AAHGWS"
#define MAIN_URL @"http://194.170.6.30/"
//#define MAIN_URL @"http://192.168.1.8/"

#define LOGIN_PATH @"userSecurity.asmx?op=userLogin"
#define NO_OF_DAYS_FOR_LINECHART 120
#define M_PI        3.14159265358979323846264338327950288   /* pi */
#define M_PI_BY_2      1.57079632679489661923132169163975144   /* pi/2 */
#define M_PI_BY_4      0.785398163397448309615660845819875721  /* pi/4 */
#define LOGIN_URL @"/usersecurity.asmx?op=userLogin"
#define BARSALESCOLN_URL @"/usersecurity.asmx?op=getDBDPurchaseSalesForQuarterMonthly"
#define PIESALESINV_URL @"/usersecurity.asmx?op=getDBDSalesInvoiceMTD"
#define BARPURCHSALES_URL @"/usersecurity.asmx?op=getDBDPurchaseSalesForQuarterMonthly"
#define LCBUSINVCOLN_URL @"/usersecurity.asmx?op=getDBBusInvColn"
#define APPLHEADER_URL @"/usersecurity.asmx?op=getApprovalsHeaderDetail"
#define APPLMASTER_URL @"/usersecurity.asmx?op=getApprovalsMasterDetail"
#define APPLDETAIL_URL @"/usersecurity.asmx?op=getApprovalDocumentDetail"
#define MISFRONTDISP_URL @"/usersecurity.asmx?op=getMISFrontDisplay"
#define MISBUSSINVCOLN_URL @"/usersecurity.asmx?op=getMISBusInvColn"
#define MISBUSSINVDAILY_URL @"/usersecurity.asmx?op=getMISBusInvDailyStmt"
#define MISBUSSINVSMDAILY_URL @"/usersecurity.asmx?op=getMISBusInvSalesManMonthly"
#define MISSALESANALYSIS_URL @"/usersecurity.asmx?op=getMISSalesAnalysis"
#define MISCATEGORYWISESALES_URL @"/usersecurity.asmx?op=getMISCategorywiseSales"
#define MISSALESCOLLECTION_URL @"/usersecurity.asmx?op=getMISSalesCollection"
#define MISFGTRANSFER_URL @"/usersecurity.asmx?op=getMISFGTransferredToStore"
#define MISPURCHSALES_URL @"/usersecurity.asmx?op=getMISPurchaseVsSales"
#define MISDEBTORAGEING_URL @"/usersecurity.asmx?op=getMISDebtorAgeing"
#define MISCREDITORAGEING_URL @"/usersecurity.asmx?op=getMISCreditorAgeing"
#define MISPURCHSALESIMPEXP_URL @"/usersecurity.asmx?op=getMISPurchaseSalesImpExp"
#define CUSTOMERLIST_URL @"/collectionEntry.asmx?op=getCustomerList"
#define CATEGORYLIST_URL @"/collectionEntry.asmx?op=getCategoryNameList"
#define SALESMANLIST_URL @"/collectionEntry.asmx?op=getSalesmanNamesList"
#define SUPPLIERLIST_URL @"/collectionEntry.asmx?op=getSupplierList"
#define APPROVEDOCUMENT_URL @"/usersecurity.asmx?op=approveMasterDocument"

typedef void (^METHODCALLBACK) (NSDictionary*);

@interface defaults : NSObject {
    
}

@end
