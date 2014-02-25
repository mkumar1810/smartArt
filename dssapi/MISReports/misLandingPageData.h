//
//  misLandingPageData.h
//  dssapi
//
//  Created by Raja T S Sekhar on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userSecurity.h"

@interface misLandingPageData : NSObject <NSXMLParserDelegate, userSecuritySoapBindingResponseDelegate>
{
    NSString *_userCode;
	NSMutableData *webData;
    NSXMLParser *xmlParser; 
	NSMutableString *parseElement,*value;
    NSMutableString *respcode, *respmessage;
    NSMutableDictionary *resultDataStruct;
    NSMutableArray *dictData;
}

- (id) initWithUser:(NSString*) p_foruser;
- (void) generateData;
- (void) showAlertMessage:(NSString *) dispMessage;

@end
