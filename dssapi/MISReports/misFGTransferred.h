//
//  misFGTransferred.h
//  dssapi
//
//  Created by Imac DOM on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misBaseReport.h"

@interface misFGTransferred : misBaseReport <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_fordate;
}

- (id) initReportForDate:(NSString*) p_fordate andDayOffset:(int) p_dayoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation;
- (NSString*) getDayStringWithOffsetDays:(int) p_days andMonth:(int) p_month andIncludeinOutput:(BOOL) p_includeday andFromDate:(NSDate*) p_forDate;
- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo;
- (UITableViewCell*) getHeaderCellforTableView:(UITableView*) p_dispTV;
- (UITableViewCell*) getSummaryCell:(UITableView*) p_dispTV andData:(NSDictionary*) p_dataDict;
- (UITableViewCell*) getDetailCell:(UITableView*) p_dispTV andData:(NSDictionary*) p_dataDict forRowNo:(int) p_rowNo;

@end
