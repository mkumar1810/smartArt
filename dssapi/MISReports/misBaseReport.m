//
//  misBaseReport.m
//  dssapi
//
//  Created by Raja T S Sekhar on 3/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "misBaseReport.h"

@implementation misBaseReport

- (IBAction) naviGateDisplay :(id)sender
{
    UIButton *btn = (UIButton*) sender;
    [actIndicator setHidden:NO];
    [actIndicator startAnimating];
    [self generateDataForOffset:btn.tag];
}

- (IBAction) goBack:(id) sender
{
    [self removeFromSuperview];
    //[[NSNotificationCenter defaultCenter] removexObserver:self];
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    CGRect frame;
    CGRect navidataframe;
    intOrientation = p_forOrientation;
    if (UIInterfaceOrientationIsPortrait(p_forOrientation)) 
    {
        frame = CGRectMake(0, 0, 768, 1004);
        navidataframe = CGRectMake(40, 88, 648, 40);
    }
    else
    {
        frame = CGRectMake(0, 0, 1028, 768);
        navidataframe = CGRectMake(170, 88, 648, 40);
    }
    [self setFrame:frame];
    [navidataview setFrame:navidataframe];
    [self generateTableView];
}

- (void) generateTableView
{
    int tvYShift;
    //return;
    if (dispTV) {
        [dispTV removeFromSuperview];
        //[dispTV release];
    }
    CGRect tvrect;
    [navidataview setHidden:NO];
    if (hideNaviDataView) 
    {
        tvYShift = 60;
        [navidataview setHidden:YES];
    }
    else
        tvYShift = 0;
    
    if (showScroll==NO) 
    {
        if (UIInterfaceOrientationIsPortrait(intOrientation)) 
            tvrect = CGRectMake(0, 140 - tvYShift, 768, 768+tvYShift);
        else
            tvrect = CGRectMake(0, 140 - tvYShift, 1004, 500+tvYShift);
    }
    else
    {
        [tableScroll setHidden:NO];
        CGRect scrollFrame = CGRectMake(0, 140 - tvYShift, scrollWidth, scrollHeight);
        [tableScroll setFrame:scrollFrame];
        tvrect = CGRectMake(0, 10 , scrollWidth, scrollHeight);
        [tableScroll setClipsToBounds:YES];
        [tableScroll setCanCancelContentTouches:NO];
        tableScroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        CGRect indicatorframe = actIndicator.frame;
        indicatorframe.origin.y = indicatorframe.origin.y - 140;
        [actIndicator setFrame:indicatorframe];
        [tableScroll addSubview:actIndicator];
        
    }
    
    dispTV = [[UITableView alloc] initWithFrame:tvrect style:UITableViewStyleGrouped];
    if (showScroll==NO) 
        [self addSubview:dispTV];
    else
        [tableScroll addSubview:dispTV];
        
    [dispTV setBackgroundView:nil];
    [dispTV setBackgroundView:[[UIView alloc] init] ];
    [dispTV setBackgroundColor:UIColor.clearColor];
    if (populationOnProgress==NO) 
        [actIndicator stopAnimating];
}

- (UILabel*) getDefaultlabel:(CGRect) reqFrame andTitle:(NSString*) lblTitle andreqColor:(UIColor*) reqColor andAlignment:(int) alignment
{
    UILabel *resLbl = [[UILabel alloc] initWithFrame:reqFrame];
    resLbl.text = lblTitle;
    resLbl.numberOfLines = 0;
    if (alignment==0) resLbl.textAlignment = UITextAlignmentCenter;
    if (alignment==1) resLbl.textAlignment = UITextAlignmentLeft;
    if (alignment==2) resLbl.textAlignment = UITextAlignmentRight;
    resLbl.textColor = reqColor;
    resLbl.font = [UIFont systemFontOfSize:22.0f];
    return  resLbl;
}

- (void) addNIBView:(NSString*) nibName  forFrame:(CGRect) forframe  andBackButton:(BOOL) addBackButton
{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:nibName
                                                      owner:self
                                                    options:nil];
    UIView *newview = [nibViews objectAtIndex:0];
    [newview setFrame:forframe];
    [self addSubview:newview];        // Initialization code
    actIndicator.transform = CGAffineTransformMakeScale(5.00, 5.00);        
    if (addBackButton==YES) 
    {
        UIImage *backbtnImage = [UIImage imageNamed:@"back.png"];
        backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15,10,55,28)];
        backBtn.titleLabel.text=@"Back";
        [backBtn setImage:backbtnImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:backBtn];        
        //[backBtn release];
    }
}

- (UILabel*) getDefaultlabelForLandScape:(CGRect) reqFrame andTitle:(NSString*) lblTitle andreqColor:(UIColor*) reqColor andAlignment:(int) alignment
{
    UILabel *resLbl = [[UILabel alloc] initWithFrame:reqFrame];
    resLbl.text = lblTitle;
    resLbl.numberOfLines = 0;
    if (alignment==0) resLbl.textAlignment = UITextAlignmentCenter;
    if (alignment==1) resLbl.textAlignment = UITextAlignmentLeft;
    if (alignment==2) resLbl.textAlignment = UITextAlignmentRight;
    resLbl.textColor = reqColor;
    resLbl.font = [UIFont systemFontOfSize:13.0f];
    return  resLbl;
}

- (NSString*) getOffsetMonthForDisp
{
    NSString *retval = [[NSString alloc] init];
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    NSTimeInterval secondsforNdays = - 24 * 60 * 60;
    [nsdf setDateFormat:@"d-MMM-yyyy"];
    NSDate *l_fordate = [NSDate date];
    l_fordate = [l_fordate dateByAddingTimeInterval:secondsforNdays];
    [nsdf setDateFormat:@"yyyyMM"];
    NSInteger curMonthYearValue = [[nsdf stringFromDate:l_fordate] integerValue];
    [nsdf setDateFormat:@"MM"];
    NSInteger curMonthValue = [[nsdf stringFromDate:l_fordate] integerValue];
    NSInteger subyear = _offset / 12;
    NSInteger submonths = _offset - subyear*12;
    if (submonths>= curMonthValue) 
        curMonthYearValue = curMonthYearValue - 100 +12;
    NSInteger prevMonthValue = curMonthYearValue - subyear*100 - submonths;
    [nsdf setDateFormat:@"yyyyMMd"];
    NSString *prevMonthStr = [[NSString alloc] initWithFormat:@"%d%d", prevMonthValue, 1];
    NSDate *prevMonthDate = [nsdf dateFromString:prevMonthStr];
    [nsdf setDateFormat:@"MMMM,YYYY"];
    retval = [nsdf stringFromDate:prevMonthDate];
    return  retval;
}

- (void)dealloc
{
    //[dataForDisplay release];
    //[dispTV release];
    //[[NSNotificationCenter defaultCenter] removexObserver:self];    
    //[super dealloc];
}

- (NSString*) getValidStringForDate:(NSString*) dateStr
{
    NSString *retVal = [[NSString alloc] init];
    @try {
        NSString *fieldval = [[NSString alloc] init];
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"YYYY-MM-dd"];
        fieldval = [dateStr substringToIndex:10];
        NSDate *dateval = [nsdf dateFromString:fieldval];
        [nsdf setDateFormat:@"dd-MM-YYYY"];
        retVal = [nsdf stringFromDate:dateval];
    }
    @catch (NSException *exception) {
        retVal = dateStr;
    }
    @finally {
    }
    return  retVal;
}

@end
