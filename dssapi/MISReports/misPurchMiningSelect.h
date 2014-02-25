//
//  misPurchMiningSelect.h
//  dssapi
//
//  Created by Imac DOM on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseSearchForm.h"
#import "suppSearch.h"
#import "categorySearch.h"

@interface misPurchMiningSelect :  baseSearchForm <UITableViewDataSource, UITableViewDelegate>
{
    int refreshTag;
    NSString /**_notificationName,*/ *_suppCode, *_suppVal, *_catCodeQty, *_catValQty, *_catCodeValue, *_catValValue, *_catCodeAvg, *_catValAvg;
    int _scMonthPurchsuppOption, _scMonthPurchCatQty, _scMonthPurchCatVal, _scMonthPurchCatAvg;
    UITextField *txtSupplier, *txtCatQty, *txtCatVal, *txtCatAvg;
    UISegmentedControl *scAllIndSupplier, *scAllIndCatQty, *scAllIndCatVal, *scAllIndCatAvg; 
    categorySearch *searchCategory;
    suppSearch *searchSupp;
    METHODCALLBACK _purchReturnMethod;
}

- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andInitialDict:(NSDictionary*) p_initData andReturnMethod:(METHODCALLBACK) p_returnMethod;
- (void) addGenericCellWithTitle:(UITableViewCell*) p_cell andTitle:(NSString*) p_title;
- (void) storeValues;
- (void) showAlertMessage:(NSString *) dispMessage;
- (NSDictionary*) getValidatedParamDictforOption:(int) p_selOption andselCode:(NSString*) p_selCode andReportNo:(int) p_reportNo forTagName:(NSString*) p_tagCodeName andAlertMsg:(NSString*) p_alertMsg;
- (NSDictionary*) returnPurchaseMiningStoredData;
- (void) unflockStoredDataFromDict:(NSDictionary*) p_storedDict;
- (void) addMonthlyPurchSupplierwise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo;
- (void) addPurchasesQtyCategorywise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo;
- (void) addPurchasesValCategorywise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo;
- (void) addPurchasesAvgCategorywise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo;
- (void) purchMiningDataGenerated:(NSDictionary *)generatedInfo;
- (void) searchSupplierReturn:(NSDictionary *)suppInfo;
- (void) searchCategoryReturnQty:(NSDictionary *)categoryInfo;
- (void) searchCategoryReturnAvg:(NSDictionary *)categoryInfo;
- (void) searchCategoryReturnVal:(NSDictionary *)categoryInfo;
@end
