//
//  misDebtorAgeing.h
//  dssapi
//
//  Created by Imac DOM on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misBaseReport.h"

@interface misDebtorAgeing : misBaseReport <UITableViewDataSource, UITableViewDelegate>
{
    NSString *orderColumn;
    BOOL isAscending;
    NSMutableArray *sortedDispRecs;
}

- (id) initDebtorAgeingReportWithFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation;
- (void) performSortingByColumn:(id) sender;
- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo;
- (UITableViewCell*) getHeaderCellforTableView:(UITableView*) p_dispTV;
- (UITableViewCell*) getSummaryCell:(UITableView*) p_dispTV andData:(NSDictionary*) p_dataDict;
- (UITableViewCell*) getDetailCell:(UITableView*) p_dispTV andData:(NSDictionary*) p_dataDict forRowNo:(int) p_rowNo;

@end
