//
//  docApprovalMasterData.h
//  dssapi
//
//  Created by Raja T S Sekhar on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "docApprovalDetail.h"
#import "dssWSCallsProxy.h"

@interface docApprovalMasterData : NSObject <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_divcode, *_doccode, *_userstatus, /**_appPopulateNotifyName, *_appDeappNotifyName,*/ *_docdesc /*, *_docDetGenNotifyname*/;
    NSMutableArray *resultData;
	NSMutableData *webData;
    NSXMLParser *xmlParser; 
	NSMutableString *parseElement,*value;
    NSMutableString *respcode, *respmessage;
    NSMutableDictionary *resultDataStruct;  
    UIInterfaceOrientation intOrientation;
    NSDictionary *schemaDict;
    METHODCALLBACK appPopulateMethod, appDeappMethod, docDetGenMethod, updateCompleteReturn,applCompleteNotify;
}

- (id) initWithDivCode:(NSString*) p_divCode andDocCode:(NSString*) p_docCode andUserStatus:(NSString*) p_userStatus andPopulatMethod:(METHODCALLBACK) p_appPopulateMethod andAppDeAppMethod:(METHODCALLBACK) p_appDeappMethod andDocDescription:(NSString*) p_docDesc andDocDetGenMethod:(METHODCALLBACK) p_docDetGenMethod andMainDocDict:(NSDictionary*) p_docDict;
- (void) generateMasterData;
- (void) showAlertMessage:(NSString *) dispMessage;
- (NSString*) getValidStringForDate:(NSString*) dateStr;
- (void) setinterfaceOrientation:(UIInterfaceOrientation) p_intOrientation;
- (int) getXPosition :(int) lblNo;
- (UITextAlignment) getAlignmentPosition:(int) lblNo;
- (void) setTableViewData:(NSArray*) p_tvdata;
- (void) updateAllApprovals:(METHODCALLBACK) p_completeReturn;
- (void) updateNextApprovalFrom:(int) p_startNo;
- (void) approvalCompletionNotify:(NSDictionary*) p_completedStatus;
@end
