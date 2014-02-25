//
//  misSalesMiningSelect.h
//  dssapi
//
//  Created by Imac DOM on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "baseSearchForm.h"
#import "custSearch.h"
#import "categorySearch.h"
#import "salesmanSelect.h"

@interface misSalesMiningSelect :  baseSearchForm <UITableViewDataSource, UITableViewDelegate>
{
    int refreshTag;
    NSString /**_notificationName,*/ *_custCode, *_custVal, *_categoryCode, *_categoryVal, *_smCode, *_smVal;
    int _scMonthSalesCustOption, _scMonthSalesCategoryOption, _scMonthSalesSMOption,_prodYear, _smSalesYear, _itemSalesYear, _yearlySMSalesYear, _yearExpImpYear;
    UITextField *txtCustomer, *txtCategory, *txtSalesman, *txtProdWiseYear, *txtsmSalesYear, *txtItemSalesYear, *txtYearlySMSalesYear, *txtYearExpImpYear;
    UISegmentedControl *scAllIndCustomer, *scAllIndCategory, *scAllIndSalesman; 
    custSearch *searchCust;
    categorySearch *searchCategory;
    salesmanSelect *searchSalesman;
    METHODCALLBACK _returnMethod;
}

- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andInitialDict:(NSDictionary*) p_initData withReturnMethod:(METHODCALLBACK) p_returnMethod;
- (void) addGenericCellWithTitle:(UITableViewCell*) p_cell andTitle:(NSString*) p_title;
- (void) addMonthlySalesCustomerwise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo;
- (void) addMonthlySalesCategorywise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo;
- (void) addMonthlySalesSMWise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo;
- (void) storeValues;
- (void) showAlertMessage:(NSString *) dispMessage;
- (NSDictionary*) getValidatedParamDictforOption:(int) p_selOption andselCode:(NSString*) p_selCode andReportNo:(int) p_reportNo forTagName:(NSString*) p_tagCodeName andAlertMsg:(NSString*) p_alertMsg;
- (NSDictionary*) returnSalesMiningStoredData;
- (void) unflockStoredDataFromDict:(NSDictionary*) p_storedDict;
- (UITextField*) addGenericYearPartIntoCell:(UITableViewCell*) p_cell forSection:(int) p_section;
- (IBAction) addSubtractYear:(id) sender;
- (void) salesMiningDataGenerated:(NSDictionary *)generatedInfo;
- (void) searchCustomerReturn:(NSDictionary *)custInfo;
- (void) searchCategoryReturn:(NSDictionary *)categoryInfo;
- (void) searchSalesmanReturn:(NSDictionary *)salesmanInfo;
@end
