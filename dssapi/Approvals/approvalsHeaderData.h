//
//  approvalsHeaderData.h
//  dssapi
//
//  Created by Raja T S Sekhar on 1/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userSecurity.h"

@interface approvalsHeaderData : NSObject <NSXMLParserDelegate, userSecuritySoapBindingResponseDelegate>
{
    NSMutableArray *resultData;
    NSString* l_divisioncode;
    NSString* l_loggeduser;
	NSMutableData *webData;
    NSXMLParser *xmlParser; 
	NSMutableString *parseElement,*value;
    NSMutableString *respcode, *respmessage;
    NSMutableDictionary *resultDataStruct;  
}
- (id) initWithDivisionCode:(NSString*) p_divcode;
- (void) generateHeaderData;
- (void) showAlertMessage:(NSString *) dispMessage;
- (NSString*) htmlEntityDecode:(NSString *)string;
@end
