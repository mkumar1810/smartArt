#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class userSecurity_userLogin;
@class userSecurity_userLoginResponse;
@class userSecurity_getDBBusInvColn;
@class userSecurity_getDBBusInvColnResponse;
@class userSecurity_getDBDSalesInvoiceMTD;
@class userSecurity_getDBDSalesInvoiceMTDResponse;
@class userSecurity_getDBDPurchaseSalesForQuarterMonthly;
@class userSecurity_getDBDPurchaseSalesForQuarterMonthlyResponse;
@class userSecurity_getApprovalsHeaderDetail;
@class userSecurity_getApprovalsHeaderDetailResponse;
@class userSecurity_getApprovalsMasterDetail;
@class userSecurity_getApprovalsMasterDetailResponse;
@class userSecurity_getApprovalDocumentDetail;
@class userSecurity_getApprovalDocumentDetailResponse;
@class userSecurity_getMISFrontDisplay;
@class userSecurity_getMISFrontDisplayResponse;
@class userSecurity_getMISBusInvColn;
@class userSecurity_getMISBusInvColnResponse;
@class userSecurity_getMISBusInvDailyStmt;
@class userSecurity_getMISBusInvDailyStmtResponse;
@class userSecurity_getMISBusInvSalesManMonthly;
@class userSecurity_getMISBusInvSalesManMonthlyResponse;
@interface userSecurity_userLogin : NSObject {
	
/* elements */
	NSString * p_eMail;
	NSString * p_passWord;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_userLogin *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_eMail;
@property (retain) NSString * p_passWord;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_userLoginResponse : NSObject {
	
/* elements */
	NSString * userLoginResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_userLoginResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userLoginResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getDBBusInvColn : NSObject {
	
/* elements */
	NSString * p_startdate;
	NSString * p_enddate;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getDBBusInvColn *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_startdate;
@property (retain) NSString * p_enddate;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getDBBusInvColnResponse : NSObject {
	
/* elements */
	NSString * getDBBusInvColnResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getDBBusInvColnResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getDBBusInvColnResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getDBDSalesInvoiceMTD : NSObject {
	
/* elements */
	NSString * p_fordate;
	NSString * p_monthoffset;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getDBDSalesInvoiceMTD *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_fordate;
@property (retain) NSString * p_monthoffset;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getDBDSalesInvoiceMTDResponse : NSObject {
	
/* elements */
	NSString * getDBDSalesInvoiceMTDResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getDBDSalesInvoiceMTDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getDBDSalesInvoiceMTDResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getDBDPurchaseSalesForQuarterMonthly : NSObject {
	
/* elements */
	NSString * p_fordate;
	NSString * p_monthoffset;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getDBDPurchaseSalesForQuarterMonthly *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_fordate;
@property (retain) NSString * p_monthoffset;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getDBDPurchaseSalesForQuarterMonthlyResponse : NSObject {
	
/* elements */
	NSString * getDBDPurchaseSalesForQuarterMonthlyResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getDBDPurchaseSalesForQuarterMonthlyResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getDBDPurchaseSalesForQuarterMonthlyResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getApprovalsHeaderDetail : NSObject {
	
/* elements */
	NSString * p_divcode;
	NSString * p_usercode;
	NSString * p_module;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getApprovalsHeaderDetail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_divcode;
@property (retain) NSString * p_usercode;
@property (retain) NSString * p_module;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getApprovalsHeaderDetailResponse : NSObject {
	
/* elements */
	NSString * getApprovalsHeaderDetailResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getApprovalsHeaderDetailResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getApprovalsHeaderDetailResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getApprovalsMasterDetail : NSObject {
	
/* elements */
	NSString * p_divcode;
	NSString * p_userstatus;
	NSString * p_documentcode;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getApprovalsMasterDetail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_divcode;
@property (retain) NSString * p_userstatus;
@property (retain) NSString * p_documentcode;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getApprovalsMasterDetailResponse : NSObject {
	
/* elements */
	NSString * getApprovalsMasterDetailResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getApprovalsMasterDetailResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getApprovalsMasterDetailResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getApprovalDocumentDetail : NSObject {
	
/* elements */
	NSString * p_divcode;
	NSString * p_documentcode;
	NSString * p_documentno;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getApprovalDocumentDetail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_divcode;
@property (retain) NSString * p_documentcode;
@property (retain) NSString * p_documentno;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getApprovalDocumentDetailResponse : NSObject {
	
/* elements */
	NSString * getApprovalDocumentDetailResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getApprovalDocumentDetailResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getApprovalDocumentDetailResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getMISFrontDisplay : NSObject {
	
/* elements */
	NSString * p_usercode;
	NSString * p_module;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getMISFrontDisplay *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_usercode;
@property (retain) NSString * p_module;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getMISFrontDisplayResponse : NSObject {
	
/* elements */
	NSString * getMISFrontDisplayResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getMISFrontDisplayResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getMISFrontDisplayResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getMISBusInvColn : NSObject {
	
/* elements */
	NSString * p_reporttype;
	NSString * p_fordate;
	NSString * p_dayoffset;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getMISBusInvColn *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_reporttype;
@property (retain) NSString * p_fordate;
@property (retain) NSString * p_dayoffset;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getMISBusInvColnResponse : NSObject {
	
/* elements */
	NSString * getMISBusInvColnResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getMISBusInvColnResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getMISBusInvColnResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getMISBusInvDailyStmt : NSObject {
	
/* elements */
	NSString * p_reporttype;
	NSString * p_monthoffset;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getMISBusInvDailyStmt *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_reporttype;
@property (retain) NSString * p_monthoffset;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getMISBusInvDailyStmtResponse : NSObject {
	
/* elements */
	NSString * getMISBusInvDailyStmtResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getMISBusInvDailyStmtResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getMISBusInvDailyStmtResult;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getMISBusInvSalesManMonthly : NSObject {
	
/* elements */
	NSString * p_reporttype;
	NSString * p_monthoffset;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getMISBusInvSalesManMonthly *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * p_reporttype;
@property (retain) NSString * p_monthoffset;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface userSecurity_getMISBusInvSalesManMonthlyResponse : NSObject {
	
/* elements */
	NSString * getMISBusInvSalesManMonthlyResult;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (userSecurity_getMISBusInvSalesManMonthlyResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getMISBusInvSalesManMonthlyResult;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "userSecurity.h"
@class userSecuritySoapBinding;
@class userSecuritySoap12Binding;
@interface userSecurity : NSObject {
	
}
+ (userSecuritySoapBinding *)userSecuritySoapBinding;
+ (userSecuritySoap12Binding *)userSecuritySoap12Binding;
@end
@class userSecuritySoapBindingResponse;
@class userSecuritySoapBindingOperation;
@protocol userSecuritySoapBindingResponseDelegate <NSObject>
- (void) operation:(userSecuritySoapBindingOperation *)operation completedWithResponse:(userSecuritySoapBindingResponse *)response;
@end
@interface userSecuritySoapBinding : NSObject <userSecuritySoapBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(userSecuritySoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (userSecuritySoapBindingResponse *)userLoginUsingParameters:(userSecurity_userLogin *)aParameters ;
- (void)userLoginAsyncUsingParameters:(userSecurity_userLogin *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getDBBusInvColnUsingParameters:(userSecurity_getDBBusInvColn *)aParameters ;
- (void)getDBBusInvColnAsyncUsingParameters:(userSecurity_getDBBusInvColn *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getDBDSalesInvoiceMTDUsingParameters:(userSecurity_getDBDSalesInvoiceMTD *)aParameters ;
- (void)getDBDSalesInvoiceMTDAsyncUsingParameters:(userSecurity_getDBDSalesInvoiceMTD *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getDBDPurchaseSalesForQuarterMonthlyUsingParameters:(userSecurity_getDBDPurchaseSalesForQuarterMonthly *)aParameters ;
- (void)getDBDPurchaseSalesForQuarterMonthlyAsyncUsingParameters:(userSecurity_getDBDPurchaseSalesForQuarterMonthly *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getApprovalsHeaderDetailUsingParameters:(userSecurity_getApprovalsHeaderDetail *)aParameters ;
- (void)getApprovalsHeaderDetailAsyncUsingParameters:(userSecurity_getApprovalsHeaderDetail *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getApprovalsMasterDetailUsingParameters:(userSecurity_getApprovalsMasterDetail *)aParameters ;
- (void)getApprovalsMasterDetailAsyncUsingParameters:(userSecurity_getApprovalsMasterDetail *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getApprovalDocumentDetailUsingParameters:(userSecurity_getApprovalDocumentDetail *)aParameters ;
- (void)getApprovalDocumentDetailAsyncUsingParameters:(userSecurity_getApprovalDocumentDetail *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getMISFrontDisplayUsingParameters:(userSecurity_getMISFrontDisplay *)aParameters ;
- (void)getMISFrontDisplayAsyncUsingParameters:(userSecurity_getMISFrontDisplay *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getMISBusInvColnUsingParameters:(userSecurity_getMISBusInvColn *)aParameters ;
- (void)getMISBusInvColnAsyncUsingParameters:(userSecurity_getMISBusInvColn *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getMISBusInvDailyStmtUsingParameters:(userSecurity_getMISBusInvDailyStmt *)aParameters ;
- (void)getMISBusInvDailyStmtAsyncUsingParameters:(userSecurity_getMISBusInvDailyStmt *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
- (userSecuritySoapBindingResponse *)getMISBusInvSalesManMonthlyUsingParameters:(userSecurity_getMISBusInvSalesManMonthly *)aParameters ;
- (void)getMISBusInvSalesManMonthlyAsyncUsingParameters:(userSecurity_getMISBusInvSalesManMonthly *)aParameters  delegate:(id<userSecuritySoapBindingResponseDelegate>)responseDelegate;
@end
@interface userSecuritySoapBindingOperation : NSOperation {
	userSecuritySoapBinding *binding;
	userSecuritySoapBindingResponse *response;
	id<userSecuritySoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) userSecuritySoapBinding *binding;
@property (readonly) userSecuritySoapBindingResponse *response;
@property (nonatomic, assign) id<userSecuritySoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end
@interface userSecuritySoapBinding_userLogin : userSecuritySoapBindingOperation {
	userSecurity_userLogin * parameters;
}
@property (retain) userSecurity_userLogin * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_userLogin *)aParameters
;
@end
@interface userSecuritySoapBinding_getDBBusInvColn : userSecuritySoapBindingOperation {
	userSecurity_getDBBusInvColn * parameters;
}
@property (retain) userSecurity_getDBBusInvColn * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getDBBusInvColn *)aParameters
;
@end
@interface userSecuritySoapBinding_getDBDSalesInvoiceMTD : userSecuritySoapBindingOperation {
	userSecurity_getDBDSalesInvoiceMTD * parameters;
}
@property (retain) userSecurity_getDBDSalesInvoiceMTD * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getDBDSalesInvoiceMTD *)aParameters
;
@end
@interface userSecuritySoapBinding_getDBDPurchaseSalesForQuarterMonthly : userSecuritySoapBindingOperation {
	userSecurity_getDBDPurchaseSalesForQuarterMonthly * parameters;
}
@property (retain) userSecurity_getDBDPurchaseSalesForQuarterMonthly * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getDBDPurchaseSalesForQuarterMonthly *)aParameters
;
@end
@interface userSecuritySoapBinding_getApprovalsHeaderDetail : userSecuritySoapBindingOperation {
	userSecurity_getApprovalsHeaderDetail * parameters;
}
@property (retain) userSecurity_getApprovalsHeaderDetail * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getApprovalsHeaderDetail *)aParameters
;
@end
@interface userSecuritySoapBinding_getApprovalsMasterDetail : userSecuritySoapBindingOperation {
	userSecurity_getApprovalsMasterDetail * parameters;
}
@property (retain) userSecurity_getApprovalsMasterDetail * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getApprovalsMasterDetail *)aParameters
;
@end
@interface userSecuritySoapBinding_getApprovalDocumentDetail : userSecuritySoapBindingOperation {
	userSecurity_getApprovalDocumentDetail * parameters;
}
@property (retain) userSecurity_getApprovalDocumentDetail * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getApprovalDocumentDetail *)aParameters
;
@end
@interface userSecuritySoapBinding_getMISFrontDisplay : userSecuritySoapBindingOperation {
	userSecurity_getMISFrontDisplay * parameters;
}
@property (retain) userSecurity_getMISFrontDisplay * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getMISFrontDisplay *)aParameters
;
@end
@interface userSecuritySoapBinding_getMISBusInvColn : userSecuritySoapBindingOperation {
	userSecurity_getMISBusInvColn * parameters;
}
@property (retain) userSecurity_getMISBusInvColn * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getMISBusInvColn *)aParameters
;
@end
@interface userSecuritySoapBinding_getMISBusInvDailyStmt : userSecuritySoapBindingOperation {
	userSecurity_getMISBusInvDailyStmt * parameters;
}
@property (retain) userSecurity_getMISBusInvDailyStmt * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getMISBusInvDailyStmt *)aParameters
;
@end
@interface userSecuritySoapBinding_getMISBusInvSalesManMonthly : userSecuritySoapBindingOperation {
	userSecurity_getMISBusInvSalesManMonthly * parameters;
}
@property (retain) userSecurity_getMISBusInvSalesManMonthly * parameters;
- (id)initWithBinding:(userSecuritySoapBinding *)aBinding delegate:(id<userSecuritySoapBindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getMISBusInvSalesManMonthly *)aParameters
;
@end
@interface userSecuritySoapBinding_envelope : NSObject {
}
+ (userSecuritySoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface userSecuritySoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class userSecuritySoap12BindingResponse;
@class userSecuritySoap12BindingOperation;
@protocol userSecuritySoap12BindingResponseDelegate <NSObject>
- (void) operation:(userSecuritySoap12BindingOperation *)operation completedWithResponse:(userSecuritySoap12BindingResponse *)response;
@end
@interface userSecuritySoap12Binding : NSObject <userSecuritySoap12BindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(userSecuritySoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (userSecuritySoap12BindingResponse *)userLoginUsingParameters:(userSecurity_userLogin *)aParameters ;
- (void)userLoginAsyncUsingParameters:(userSecurity_userLogin *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getDBBusInvColnUsingParameters:(userSecurity_getDBBusInvColn *)aParameters ;
- (void)getDBBusInvColnAsyncUsingParameters:(userSecurity_getDBBusInvColn *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getDBDSalesInvoiceMTDUsingParameters:(userSecurity_getDBDSalesInvoiceMTD *)aParameters ;
- (void)getDBDSalesInvoiceMTDAsyncUsingParameters:(userSecurity_getDBDSalesInvoiceMTD *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getDBDPurchaseSalesForQuarterMonthlyUsingParameters:(userSecurity_getDBDPurchaseSalesForQuarterMonthly *)aParameters ;
- (void)getDBDPurchaseSalesForQuarterMonthlyAsyncUsingParameters:(userSecurity_getDBDPurchaseSalesForQuarterMonthly *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getApprovalsHeaderDetailUsingParameters:(userSecurity_getApprovalsHeaderDetail *)aParameters ;
- (void)getApprovalsHeaderDetailAsyncUsingParameters:(userSecurity_getApprovalsHeaderDetail *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getApprovalsMasterDetailUsingParameters:(userSecurity_getApprovalsMasterDetail *)aParameters ;
- (void)getApprovalsMasterDetailAsyncUsingParameters:(userSecurity_getApprovalsMasterDetail *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getApprovalDocumentDetailUsingParameters:(userSecurity_getApprovalDocumentDetail *)aParameters ;
- (void)getApprovalDocumentDetailAsyncUsingParameters:(userSecurity_getApprovalDocumentDetail *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getMISFrontDisplayUsingParameters:(userSecurity_getMISFrontDisplay *)aParameters ;
- (void)getMISFrontDisplayAsyncUsingParameters:(userSecurity_getMISFrontDisplay *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getMISBusInvColnUsingParameters:(userSecurity_getMISBusInvColn *)aParameters ;
- (void)getMISBusInvColnAsyncUsingParameters:(userSecurity_getMISBusInvColn *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getMISBusInvDailyStmtUsingParameters:(userSecurity_getMISBusInvDailyStmt *)aParameters ;
- (void)getMISBusInvDailyStmtAsyncUsingParameters:(userSecurity_getMISBusInvDailyStmt *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
- (userSecuritySoap12BindingResponse *)getMISBusInvSalesManMonthlyUsingParameters:(userSecurity_getMISBusInvSalesManMonthly *)aParameters ;
- (void)getMISBusInvSalesManMonthlyAsyncUsingParameters:(userSecurity_getMISBusInvSalesManMonthly *)aParameters  delegate:(id<userSecuritySoap12BindingResponseDelegate>)responseDelegate;
@end
@interface userSecuritySoap12BindingOperation : NSOperation {
	userSecuritySoap12Binding *binding;
	userSecuritySoap12BindingResponse *response;
	id<userSecuritySoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) userSecuritySoap12Binding *binding;
@property (readonly) userSecuritySoap12BindingResponse *response;
@property (nonatomic, assign) id<userSecuritySoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
@end
@interface userSecuritySoap12Binding_userLogin : userSecuritySoap12BindingOperation {
	userSecurity_userLogin * parameters;
}
@property (retain) userSecurity_userLogin * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_userLogin *)aParameters
;
@end
@interface userSecuritySoap12Binding_getDBBusInvColn : userSecuritySoap12BindingOperation {
	userSecurity_getDBBusInvColn * parameters;
}
@property (retain) userSecurity_getDBBusInvColn * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getDBBusInvColn *)aParameters
;
@end
@interface userSecuritySoap12Binding_getDBDSalesInvoiceMTD : userSecuritySoap12BindingOperation {
	userSecurity_getDBDSalesInvoiceMTD * parameters;
}
@property (retain) userSecurity_getDBDSalesInvoiceMTD * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getDBDSalesInvoiceMTD *)aParameters
;
@end
@interface userSecuritySoap12Binding_getDBDPurchaseSalesForQuarterMonthly : userSecuritySoap12BindingOperation {
	userSecurity_getDBDPurchaseSalesForQuarterMonthly * parameters;
}
@property (retain) userSecurity_getDBDPurchaseSalesForQuarterMonthly * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getDBDPurchaseSalesForQuarterMonthly *)aParameters
;
@end
@interface userSecuritySoap12Binding_getApprovalsHeaderDetail : userSecuritySoap12BindingOperation {
	userSecurity_getApprovalsHeaderDetail * parameters;
}
@property (retain) userSecurity_getApprovalsHeaderDetail * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getApprovalsHeaderDetail *)aParameters
;
@end
@interface userSecuritySoap12Binding_getApprovalsMasterDetail : userSecuritySoap12BindingOperation {
	userSecurity_getApprovalsMasterDetail * parameters;
}
@property (retain) userSecurity_getApprovalsMasterDetail * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getApprovalsMasterDetail *)aParameters
;
@end
@interface userSecuritySoap12Binding_getApprovalDocumentDetail : userSecuritySoap12BindingOperation {
	userSecurity_getApprovalDocumentDetail * parameters;
}
@property (retain) userSecurity_getApprovalDocumentDetail * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getApprovalDocumentDetail *)aParameters
;
@end
@interface userSecuritySoap12Binding_getMISFrontDisplay : userSecuritySoap12BindingOperation {
	userSecurity_getMISFrontDisplay * parameters;
}
@property (retain) userSecurity_getMISFrontDisplay * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getMISFrontDisplay *)aParameters
;
@end
@interface userSecuritySoap12Binding_getMISBusInvColn : userSecuritySoap12BindingOperation {
	userSecurity_getMISBusInvColn * parameters;
}
@property (retain) userSecurity_getMISBusInvColn * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getMISBusInvColn *)aParameters
;
@end
@interface userSecuritySoap12Binding_getMISBusInvDailyStmt : userSecuritySoap12BindingOperation {
	userSecurity_getMISBusInvDailyStmt * parameters;
}
@property (retain) userSecurity_getMISBusInvDailyStmt * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getMISBusInvDailyStmt *)aParameters
;
@end
@interface userSecuritySoap12Binding_getMISBusInvSalesManMonthly : userSecuritySoap12BindingOperation {
	userSecurity_getMISBusInvSalesManMonthly * parameters;
}
@property (retain) userSecurity_getMISBusInvSalesManMonthly * parameters;
- (id)initWithBinding:(userSecuritySoap12Binding *)aBinding delegate:(id<userSecuritySoap12BindingResponseDelegate>)aDelegate
	parameters:(userSecurity_getMISBusInvSalesManMonthly *)aParameters
;
@end
@interface userSecuritySoap12Binding_envelope : NSObject {
}
+ (userSecuritySoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface userSecuritySoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
