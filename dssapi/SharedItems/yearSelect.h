//
//  yearSelect.h
//  dssapi
//
//  Created by Imac DOM on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseSearchForm.h"

@interface yearSelect : baseSearchForm <UITableViewDataSource, UITableViewDelegate>
{
    int refreshTag;
    //NSString *_notificationName;
    METHODCALLBACK _yearSelectReturn;
}

- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andReturnMethod:(METHODCALLBACK) p_returnMethod;
- (void) yearListDataGenerated:(NSDictionary *)generatedInfo;

@end
