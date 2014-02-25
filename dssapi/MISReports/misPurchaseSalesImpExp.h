//
//  misPurchaseSalesImpExp.h
//  dssapi
//
//  Created by Imac DOM on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misBaseReport.h"

@interface misPurchaseSalesImpExp : misBaseReport <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
{
}

- (id) initReportForYearOffset:(int) p_yearoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation;
- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo;

@end
