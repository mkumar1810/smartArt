//
//  busInvColnReport.h
//  dssapi
//
//  Created by Raja T S Sekhar on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misBaseReport.h"

@interface busInvColnReport : misBaseReport <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITextField *forDate;
    NSString *_fordate;
    IBOutlet UIView *constructionView;
}

- (id) initReportForDate:(NSString*) p_fordate andDayOffset:(int) p_dayoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation;
-(UITableViewCell*) getCellForPortraintOrientationForTV:(UITableView*) tv andRowNo:(int) rowNo;
-(UITableViewCell*) getCellForLandscapeOrientation:(UITableView*) tv andRowNo:(int) rowNo;
- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo;

@end
