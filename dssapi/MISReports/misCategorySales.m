//
//  misCategorySales.m
//  dssapi
//
//  Created by Imac DOM on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "misCategorySales.h"

@implementation misCategorySales

- (id) initReportForDate:(NSString*) p_fordate andDayOffset:(int) p_dayoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"misBaseReport" forFrame:frame andBackButton:YES];
        _fordate = [[NSString alloc] initWithFormat:@"%@", p_fordate];
        _offset = p_dayoffset;
        intOrientation = p_intOrientation;
        //[[NSNotifixcationCenter defaultCenter] addObserver:self selector:@selector(reportCoreDataGenerated:)  name:@"MISCategorySalesGenerated" object:nil];
        [navTitle setTitle:@"Categorywise Sales"];
        [actIndicator startAnimating];
        [self generateDataForOffset:0];
    }
    return self;
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    [super setForOrientation:p_forOrientation];
}

- (void) generateTableView
{
    [super generateTableView];
    [dispTV setDelegate:self];
    [dispTV setDataSource:self];
    [dispTV reloadData];
}

- (void) generateDataForOffset:(int) p_addOffset
{
    if (populationOnProgress==NO)
    {
        populationOnProgress = YES;
        _offset = _offset + p_addOffset;
        if (_offset<0) _offset = 0;
        NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
        [nsdf setDateFormat:@"d-MMM-yyyy"];
        NSTimeInterval secondsforNdays = - (_offset+1) * 24 * 60 * 60;
        newForDate.text = [nsdf stringFromDate:[[nsdf dateFromString:_fordate] dateByAddingTimeInterval:secondsforNdays]];
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", _offset],@"p_dayoffset",@"MIS_CategorywiseSales",@"p_reporttype",  nil];
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self reportCoreDataGenerated:p_dictInfo];
        };
        [[dssWSCallsProxy alloc] initWithReportType:@"MISCATEGORYWISESALES" andInputParams:inputDict andReturnMethod:l_proxyReturn  andReturnInputs:NO];
    }
}

- (IBAction) goBack:(id) sender
{
    if (dataForDisplay) [dataForDisplay removeAllObjects];
    if (dispTV) [dispTV removeFromSuperview];
    [super goBack:sender];
}


- (void) reportCoreDataGenerated:(NSDictionary *)generatedInfo
{
    if (dataForDisplay) {
        [dataForDisplay removeAllObjects];
        //[dataForDisplay release];
    }
    dataForDisplay = [[NSMutableArray alloc] initWithArray:[generatedInfo valueForKey:@"data"] copyItems:YES];
    populationOnProgress = NO;
    if (_offset==0) 
        nextBtn.enabled = NO; 
    else 
        nextBtn.enabled = YES;
    [self setForOrientation:intOrientation];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataForDisplay count] + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float l_returnval;
    if (indexPath.row==0) 
        l_returnval = 45.0f;
    else
        l_returnval = 30.0f;
    return  l_returnval;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int maxRecordNo;
    NSDictionary *tmpDict;
    maxRecordNo = [dataForDisplay count] ;
    switch (indexPath.row) 
    {
        case 0:
            return [self getHeaderCellforTableView:tableView];
            break;
        default:
            tmpDict = [dataForDisplay objectAtIndex:indexPath.row-1];
            if (indexPath.row == maxRecordNo) 
                return [self getSummaryCell:tableView andData:tmpDict];
            else
                return [self getDetailCell:tableView andData:tmpDict forRowNo:indexPath.row];                
            break;
    }
    return nil;
}

- (UITableViewCell*) getDetailCell:(UITableView*) p_dispTV andData:(NSDictionary*) p_dataDict forRowNo:(int) p_rowNo
{
    static NSString *cellid=@"CellDetail";
    UILabel *lblTitle;
    NSString *strTitle;
    int txtAlign = 2;
    UIColor *lblBackColor;
    UITableViewCell  *cell = [p_dispTV dequeueReusableCellWithIdentifier:cellid];
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    int colWidth, xPosition, slWidth, smWidth, xWidth, colHeight;
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:0];
    frm.negativePrefix = @"-";
    frm.negativeSuffix = @"";
    colHeight = 30;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth= 90;
        slWidth = 26;
        smWidth = 110;
    }
    else
    {
        colWidth= 126;
        slWidth = 30;
        smWidth = 130;
    }
    xPosition = 2;
    colHeight = 30;
    if(cell == nil) 
    {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            txtAlign = 2;
            [frm setMaximumFractionDigits:0];
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%d",p_rowNo];
                    txtAlign = 0;
                    lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                    break;
                case 1:
                    xWidth = smWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@ ",[p_dataDict valueForKey:@"CATDESC"]];
                    txtAlign = 1;
                    lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                    break;
                case 2:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESON"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 3:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESUPTO"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 4:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"TOTAL"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 5:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESPREVUPTO"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 6:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"PREVIOUSMONTH"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 7:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"DIFFOFSALES"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                default:
                    break;
            }
            lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth-1, colHeight) andTitle:[[NSString stringWithFormat:@"%@ ",strTitle] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:txtAlign];
            lblTitle.font = [UIFont systemFontOfSize:11.0f];
            [lblTitle setBackgroundColor:lblBackColor];
            lblTitle.tag = 100 + _lblNo;
            xPosition +=  xWidth +1;
            [cell.contentView addSubview:lblTitle];
        }
    }
    else
    {
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    strTitle = [[NSString alloc] initWithFormat:@"%d",p_rowNo];
                    break;
                case 1:
                    strTitle = [[NSString alloc] initWithFormat:@"%@: ",[p_dataDict valueForKey:@"CATDESC"]];
                    break;
                case 2:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESON"] integerValue]]]];
                    break;
                case 3:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESUPTO"] integerValue]]]];
                    break;
                case 4:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"TOTAL"] integerValue]]]];
                    break;
                case 5:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESPREVUPTO"] integerValue]]]];
                    break;
                case 6:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"PREVIOUSMONTH"] integerValue]]]];
                    break;
                case 7:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"DIFFOFSALES"] integerValue]]]];
                    break;
                default:
                    break;
            }
            lblTitle = (UILabel*) [cell.contentView viewWithTag:(100+_lblNo)];
            lblTitle.text = strTitle;
        }
    }
    return cell;
    
}

- (UITableViewCell*) getSummaryCell:(UITableView*) p_dispTV andData:(NSDictionary*) p_dataDict
{
    static NSString *cellid=@"CellSummary";
    UILabel *lblTitle;
    NSString *strTitle;
    int txtAlign = 2;
    UIColor *lblBackColor;
    BOOL addDivider;
    UITableViewCell  *cell = [p_dispTV dequeueReusableCellWithIdentifier:cellid];
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    int colWidth, xPosition, slWidth, smWidth, xWidth, colHeight;
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:0];
    frm.negativePrefix = @"-";
    frm.negativeSuffix = @"";
    colHeight = 30;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth= 90;
        slWidth = 26;
        smWidth = 110;
    }
    else
    {
        colWidth= 126;
        slWidth = 30;
        smWidth = 130;
    }
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        addDivider = YES;
        xPosition = 2;
        colHeight = 30;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            txtAlign = 2;
            [frm setMaximumFractionDigits:0];
            switch (_lblNo) {
                case 0:
                    addDivider = NO;
                    xWidth = slWidth;
                    strTitle = [[NSString alloc] initWithString:@""];
                    lblBackColor = [navidataview backgroundColor];
                    break;
                case 1:
                    xWidth = smWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@: ",[p_dataDict valueForKey:@"CATDESC"]];
                    txtAlign = 2;
                    lblBackColor = [navidataview backgroundColor];
                    break;
                case 2:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESON"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 3:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESUPTO"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 4:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"TOTAL"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 5:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESPREVUPTO"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 6:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"PREVIOUSMONTH"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 7:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"DIFFOFSALES"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                default:
                    break;
            }
            if (_lblNo > 1 ) lblBackColor = [UIColor yellowColor];
            lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth-1, colHeight) andTitle:[[NSString stringWithFormat:@"%@ ",strTitle] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:txtAlign];
            lblTitle.font = [UIFont boldSystemFontOfSize:12.0f];
            [lblTitle setBackgroundColor:lblBackColor];
            lblTitle.tag = 100 + _lblNo;
            xPosition +=  xWidth +1;
            [cell.contentView addSubview:lblTitle];
        }
    }
    else
    {
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    strTitle = [[NSString alloc] initWithString:@""];
                    break;
                case 1:
                    strTitle = [[NSString alloc] initWithFormat:@"%@: ",[p_dataDict valueForKey:@"CATDESC"]];
                    break;
                case 2:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESON"] integerValue]]]];
                    break;
                case 3:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESUPTO"] integerValue]]]];
                    break;
                case 4:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"TOTAL"] integerValue]]]];
                    break;
                case 5:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALESPREVUPTO"] integerValue]]]];
                    break;
                case 6:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"PREVIOUSMONTH"] integerValue]]]];
                    break;
                case 7:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"DIFFOFSALES"] integerValue]]]];
                    break;
                default:
                    break;
            }
            lblTitle = (UILabel*) [cell.contentView viewWithTag:(100+_lblNo)];
            lblTitle.text = strTitle;
        }
    }
    return cell;
}

- (UITableViewCell*) getHeaderCellforTableView:(UITableView*) p_dispTV;
{
    static NSString *cellid=@"CellHeader";
    UILabel *lblTitle;
    NSString *strTitle;
    BOOL addDivider;
    UITableViewCell  *cell = [p_dispTV dequeueReusableCellWithIdentifier:cellid];
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    int colWidth, xPosition, slWidth, smWidth,  xWidth, colHeight;
    NSDate *stmtForDate;
    colHeight = 30;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth= 90;
        slWidth = 26;
        smWidth = 110;
    }
    else
    {
        colWidth= 126;
        slWidth = 30;
        smWidth = 130;
    }

    [nsdf setDateFormat:@"d-MMM-yyyy"];
    NSTimeInterval secondsforNdays = - (_offset+1) * 24 * 60 * 60;
    stmtForDate = [[nsdf dateFromString:_fordate] dateByAddingTimeInterval:secondsforNdays];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        addDivider = YES;
        xPosition = 2;
        colHeight = 45;
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth;
                    strTitle = [[NSString alloc] initWithString:@"Sl"];
                    break;
                case 1:
                    xWidth = smWidth;
                    strTitle = [[NSString alloc] initWithString:@"Sales \nCategory"];
                    break;
                case 2:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"Sales on \n%@",[self getDayStringWithOffsetDays:0 andMonth:0 andIncludeinOutput:YES andFromDate:stmtForDate]];
                    break;
                case 3:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"Sales upto \n%@",[self getDayStringWithOffsetDays:1 andMonth:0 andIncludeinOutput:YES andFromDate:stmtForDate]];
                    break;
                case 4:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"Total"];
                    break;
                case 5:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"Sales upto \n%@",[self getDayStringWithOffsetDays:0 andMonth:1 andIncludeinOutput:YES andFromDate:stmtForDate]];
                    break;
                case 6:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[self getDayStringWithOffsetDays:0 andMonth:1 andIncludeinOutput:NO andFromDate:stmtForDate]];
                    break;
                case 7:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"Diff. of Sales"];
                    break;
                default:
                    break;
            }
            lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth, colHeight) andTitle:strTitle andreqColor:cell.textLabel.textColor andAlignment:0];
            lblTitle.font = [UIFont boldSystemFontOfSize:11.0f];
            [lblTitle setBackgroundColor:[navidataview backgroundColor]];
            lblTitle.tag = 100 + _lblNo;
            xPosition +=  xWidth ;
            [cell.contentView addSubview:lblTitle];
            //[lblTitle release];
        }
    }
    else
    {
        for (int _lblNo = 0; _lblNo<8; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    strTitle = [[NSString alloc] initWithString:@"Sl"];
                    break;
                case 1:
                    strTitle = [[NSString alloc] initWithString:@"Sales \nCategory"];
                    break;
                case 2:
                    strTitle = [[NSString alloc] initWithFormat:@"Sales on \n%@",[self getDayStringWithOffsetDays:0 andMonth:0 andIncludeinOutput:YES andFromDate:stmtForDate]];
                    break;
                case 3:
                    strTitle = [[NSString alloc] initWithFormat:@"Sales upto \n%@",[self getDayStringWithOffsetDays:1 andMonth:0 andIncludeinOutput:YES andFromDate:stmtForDate]];
                    break;
                case 4:
                    strTitle = [[NSString alloc] initWithString:@"Total"];
                    break;
                case 5:
                    strTitle = [[NSString alloc] initWithFormat:@"Sales upto \n%@",[self getDayStringWithOffsetDays:0 andMonth:1 andIncludeinOutput:YES andFromDate:stmtForDate]];
                    break;
                case 6:
                    strTitle = [[NSString alloc] initWithFormat:@"%@",[self getDayStringWithOffsetDays:0 andMonth:1 andIncludeinOutput:NO andFromDate:stmtForDate]];
                    break;
                case 7:
                    strTitle = [[NSString alloc] initWithString:@"Diff. of Sales"];
                    break;
                default:
                    break;
            }
            lblTitle = (UILabel*) [cell.contentView viewWithTag:(100+_lblNo)];
            lblTitle.text = strTitle;
        }
    }
    return cell;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (void)dealloc
{
    //[super dealloc];
}


- (NSString*) getDayStringWithOffsetDays:(int) p_days andMonth:(int) p_month andIncludeinOutput:(BOOL) p_includeday andFromDate:(NSDate*) p_forDate
{
    NSString *l_resultval;
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateFormat:@"d/MMM/yyyy"];
    NSDate *l_fordate = p_forDate;
    if (p_days == 0 & p_month == 0) 
        l_resultval = [[NSString alloc] initWithFormat:@"%@",[nsdf stringFromDate:l_fordate]];
    
    if (p_days!=0 & p_month==0) 
    {
        NSTimeInterval secondsforNdays = - p_days * 24 * 60 * 60;
        l_resultval = [[NSString alloc] initWithFormat:@"%@",[nsdf stringFromDate:[l_fordate dateByAddingTimeInterval:secondsforNdays]]];
    }
    
    if (p_days==0 & p_month!=0) 
    {
        NSString *curMonthFirstDayStr,*nextMonthFirstDayStr;
        NSDate *curMonthFirstDay,*nextMonthFirstDay,*prevMonthLastDay, *currMonthLastDay;
        int currentDay, prevmonthDays, currMonthDays;
        [nsdf setDateFormat:@"1/MMM/yyyy"];
        curMonthFirstDayStr = [[NSString alloc] initWithFormat:@"%@",[nsdf stringFromDate:l_fordate]];            
        [nsdf setDateFormat:@"dd/MMM/yyyy"];
        curMonthFirstDay = [nsdf dateFromString:curMonthFirstDayStr];
        NSTimeInterval secondsforOneDay = - 24 * 60 * 60;
        prevMonthLastDay = [curMonthFirstDay dateByAddingTimeInterval:secondsforOneDay];
        [nsdf setDateFormat:@"d"];
        currentDay = [[nsdf stringFromDate:l_fordate] intValue];
        prevmonthDays = [[nsdf stringFromDate:prevMonthLastDay] intValue];
        if (currentDay<=prevmonthDays) 
        {
            NSString *prevMonthFormat = [[NSString alloc] initWithFormat:@"%d/MMM/yyyy",currentDay];
            [nsdf setDateFormat:prevMonthFormat];
            l_resultval = [[NSString alloc] initWithFormat:@"%@",[nsdf stringFromDate:prevMonthLastDay]];
        }
        else
        {
            [nsdf setDateFormat:@"dd/MMM/yyyy"];
            l_resultval = [[NSString alloc] initWithFormat:@"%@",[nsdf stringFromDate:prevMonthLastDay]];
        }
        [nsdf setDateFormat:@"yyyyMM"];
        NSInteger curMonthYearValue = [[nsdf stringFromDate:l_fordate] integerValue];
        [nsdf setDateFormat:@"MM"];
        NSInteger curMonthValue = [[nsdf stringFromDate:l_fordate] integerValue];
        NSInteger nextMonthYearValue;
        if (curMonthValue==12) 
            nextMonthYearValue = curMonthYearValue + 100 - curMonthValue+1;
        else
            nextMonthYearValue = curMonthYearValue + 1;
        [nsdf setDateFormat:@"yyyyMMd"];
        nextMonthFirstDayStr = [[NSString alloc] initWithFormat:@"%d%d", nextMonthYearValue , 1];
        nextMonthFirstDay = [nsdf dateFromString:nextMonthFirstDayStr];
        currMonthLastDay = [nextMonthFirstDay dateByAddingTimeInterval:secondsforOneDay];
        [nsdf setDateFormat:@"d"];
        currMonthDays = [[nsdf stringFromDate:currMonthLastDay] intValue];
        if (currentDay==currMonthDays) 
        {
            [nsdf setDateFormat:@"dd/MMM/yyyy"];
            l_resultval = [[NSString alloc] initWithFormat:@"%@",[nsdf stringFromDate:prevMonthLastDay]];
        }
        if (p_includeday==NO) 
        {
            [nsdf setDateFormat:@"dd/MMM/yyyy"];
            NSDateFormatter *dfMonthYearOnly = [[NSDateFormatter alloc] init];
            [dfMonthYearOnly setDateFormat:@"MMMM,YYYY"];
            l_resultval = [[NSString alloc] initWithFormat:@"%@",[dfMonthYearOnly stringFromDate:[nsdf dateFromString:l_resultval]]];
        }
    }
    return l_resultval;
}

@end
