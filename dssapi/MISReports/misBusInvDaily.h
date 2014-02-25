//
//  misBusInvDaily.h
//  dssapi
//
//  Created by Raja T S Sekhar on 3/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misBaseReport.h"
#import "misReportsCore.h"

@interface misBusInvDaily : misBaseReport <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITextField *forMonth;    
}

- (id) initReportForDayOffset:(int) p_Dayoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation;
- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo;
- (UITableViewCell*) getTotalSummaryCell:(NSDictionary*) p_totalDict forTV:(UITableView*) p_TV;
- (UITableViewCell*) getMainHeaderCellforTV:(UITableView*) p_TV;
- (UITableViewCell*) getSecondHeaderCellforTV:(UITableView*) p_TV;
- (UITableViewCell*) getDetailCell:(NSDictionary*) p_dataDict forTV:(UITableView*) p_TV inRowNo:(int) p_rowNo;

@end
