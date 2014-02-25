//
//  misRptsProtocol.h
//  dssapi
//
//  Created by Raja T S Sekhar on 3/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol misRptsProtocol <NSObject>

@optional
- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation;
- (IBAction) naviGateDisplay :(id)sender;
- (IBAction) goBack:(id) sender;
- (void) generateTableView;
- (UILabel*) getDefaultlabel:(CGRect) reqFrame andTitle:(NSString*) lblTitle andreqColor:(UIColor*) reqColor andAlignment:(int) alignment;
- (UILabel*) getDefaultlabelForLandScape:(CGRect) reqFrame andTitle:(NSString*) lblTitle andreqColor:(UIColor*) reqColor andAlignment:(int) alignment;
- (void) generateDataForOffset:(int) p_addOffset;
- (void) addNIBView:(NSString*) nibName  forFrame:(CGRect) forframe  andBackButton:(BOOL) addBackButton;
- (NSString*) getOffsetMonthForDisp;
- (NSString*) getValidStringForDate:(NSString*) dateStr;
@end
