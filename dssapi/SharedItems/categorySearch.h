//
//  categorySearch.h
//  dssapi
//
//  Created by Imac DOM on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseSearchForm.h"

@interface categorySearch : baseSearchForm <UITableViewDataSource, UITableViewDelegate>
{
    int refreshTag;
    //NSString *_notificationName;
    METHODCALLBACK _categoryReturnMethod;
}
- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andReturnMethod:(METHODCALLBACK) p_catReturnMethod;
- (void) categoryListDataGenerated:(NSDictionary *)generatedInfo;
@end
