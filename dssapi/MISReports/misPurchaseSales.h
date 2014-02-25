//
//  misPurchaseSales.h
//  dssapi
//
//  Created by Imac DOM on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misBaseReport.h"

@interface misPurchaseSales : misBaseReport <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_fordate;
}

- (id) initReportForYearOffset:(int) p_yearoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation;
- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo;
- (UITableViewCell*) getMainHeaderCellforTV:(UITableView*) p_TV;
- (UITableViewCell*) getDetailCell:(NSDictionary*) p_dataDict forTV:(UITableView*) p_TV inRowNo:(int) p_rowNo;

@end
