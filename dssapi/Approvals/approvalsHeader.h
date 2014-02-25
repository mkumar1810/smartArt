//
//  approvalsHeader.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "defaults.h"

@interface approvalsHeader : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_apiData;
    NSMutableArray *_flxData;
    UITableView *_headertv;
    NSMutableArray *currentData;
    NSString *_divisionCode;
    METHODCALLBACK _popOverHideMethod;
    METHODCALLBACK _appDocSelectMethod;
}

//@property (nonatomic, retain) IBOutlet UITableView *_headertv;
- (id) initWithApiAndFlxHeaderInfo:(NSMutableArray*) apiData andFlxData:(NSMutableArray*) flxData andHideMethod:(METHODCALLBACK) p_popHideMethod andAppDocSelectMethod:(METHODCALLBACK) p_appDocSelect;
- (IBAction)selected:(id)sender;

@end
