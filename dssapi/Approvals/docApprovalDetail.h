//
//  docApprovalDetail.h
//  dssapi
//
//  Created by Raja T S Sekhar on 2/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface docApprovalDetail : NSObject < UITableViewDataSource, UITableViewDelegate>
{
    NSString *_divcode, *_doccode, *_docno, *_docdesc;
    NSDictionary *_docDict;
    NSMutableArray *resultData;
	NSMutableData *webData;
    NSXMLParser *xmlParser; 
	NSMutableString *parseElement,*value;
    NSMutableString *respcode, *respmessage;
    NSMutableDictionary *resultDataStruct;  
    UIInterfaceOrientation intOrientation;
    NSDictionary *schemaDict;    
}

- (id) initWithDivCode:(NSString*) p_divcode andDocCode:(NSString*) p_doccode andDocNo:(NSString*) p_docno andDocDesc:(NSString*) p_docDesc andMainDocDict:(NSDictionary*) p_docDict;
- (void) showAlertMessage:(NSString *) dispMessage;
- (void) setinterfaceOrientation:(UIInterfaceOrientation) p_intOrientation; 
- (int) getXPositionSub :(int) subLblNo;
- (UITextAlignment) getAlignmentPosition:(int) lblNo;
- (void) setTableViewData:(NSArray*) p_tvdata;
- (NSString*) getValidStringForDate:(NSString*) dateStr;

@end
