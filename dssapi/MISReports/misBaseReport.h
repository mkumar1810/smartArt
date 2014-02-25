//
//  misBaseReport.h
//  dssapi
//
//  Created by Raja T S Sekhar on 3/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "misRptsProtocol.h"
#import "dssWSCallsProxy.h"

@interface misBaseReport : UIView <misRptsProtocol>
{
    NSMutableArray *dataForDisplay;
    IBOutlet UIButton *nextBtn, *backBtn;
    IBOutlet UIScrollView *tableScroll;
    IBOutlet UIActivityIndicatorView *actIndicator;
    BOOL populationOnProgress;
    UIInterfaceOrientation intOrientation;
    IBOutlet UIView *navidataview;
    int _offset;
    UITableView *dispTV;
    IBOutlet UINavigationItem *navTitle;
    IBOutlet UITextField *newForDate;
    IBOutlet UILabel *dateLabel;
    BOOL hideNaviDataView;
    BOOL showScroll;
    int scrollWidth, scrollHeight;
}



@end
