//
//  baseSearchForm.h
//  salesapi
//
//  Created by Imac on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseProtocol.h"
#import "dssWSCallsProxy.h"

@interface baseSearchForm : UIView <baseProtocol,UISearchBarDelegate>
{
    NSMutableArray *dataForDisplay;
    IBOutlet UIActivityIndicatorView *actIndicator;
    BOOL populationOnProgress;
    IBOutlet UIView *navidataview;
    UIInterfaceOrientation intOrientation;
    UITableView *dispTV;    
    IBOutlet UISearchBar *sBar;
    IBOutlet UINavigationItem *navTitle;
    UIButton *leftButton, *rightButton;
    BOOL _navigationNeeded;
    dssWSCallsProxy *dssWSCorecall;
}

@end
