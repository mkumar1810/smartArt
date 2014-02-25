//
//  misPurchaseSales.m
//  dssapi
//
//  Created by Imac DOM on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "misPurchaseSales.h"

@implementation misPurchaseSales

- (id) initReportForYearOffset:(int) p_yearoffset andFrame:(CGRect) frame forOrientation:(UIInterfaceOrientation) p_intOrientation
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"misBaseReport" forFrame:frame andBackButton:YES];
        _fordate = [[NSString alloc] initWithFormat:@"%@", [NSDate date]];
        _offset = p_yearoffset;
        intOrientation = p_intOrientation;
        //[[NSNotificxationCenter defaultCenter] addObserver:self selector:@selector(reportCoreDataGenerated:)  name:@"MISPurchSalesGenerated" object:nil];
        [navTitle setTitle:@"Purchase Vs Sales"];
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
        [nsdf setDateFormat:@"yyyy"];
        newForDate.text = [[NSString alloc] initWithFormat:@"%d",[[nsdf stringFromDate:[NSDate date]] integerValue] - _offset ];
        [dateLabel setText:@"For Year"];
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", _offset],@"p_dayoffset",@"MIS_PurchaseVsSales",@"p_reporttype",  nil];
        METHODCALLBACK reportCoreGeneratedMethod = ^ (NSDictionary* p_dictInfo)
        {
            [self reportCoreDataGenerated:p_dictInfo];
        };
        [[dssWSCallsProxy alloc] initWithReportType:@"MISPURCHSALES" andInputParams:inputDict andReturnMethod:reportCoreGeneratedMethod  andReturnInputs:NO];
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
            return [self getMainHeaderCellforTV:tableView];
            break;
        default:
            tmpDict = [dataForDisplay objectAtIndex:indexPath.row-1];
            return [self getDetailCell:tmpDict forTV:tableView inRowNo:indexPath.row];
            break;
    }
    return nil;
}

- (UITableViewCell*) getDetailCell:(NSDictionary*) p_dataDict forTV:(UITableView*) p_TV inRowNo:(int) p_rowNo
{
    static NSString *cellid=@"CellDetail";
    UILabel *lblTitle;
    NSString *strTitle;
    int txtAlign = 2;
    UIColor *lblBackColor;
    BOOL addDivider;
    NSNumberFormatter *frm = [[NSNumberFormatter alloc] init];
    int colWidth, xPosition, slWidth, xWidth, colHeight;;
    [frm setNumberStyle:NSNumberFormatterCurrencyStyle];
    [frm setCurrencySymbol:@""];
    [frm setMaximumFractionDigits:0];
    frm.negativePrefix = @"-";
    frm.negativeSuffix = @"";
    colHeight = 30;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth= 130;
        slWidth = 26;
    }
    else
    {
        colWidth= 176;
        slWidth = 30;
    }
    UITableViewCell  *cell = [p_TV dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        [cell setBackgroundColor:[UIColor whiteColor]];
        xPosition = 2;
        colHeight = 30;
        for (int _lblNo = 0; _lblNo<6; _lblNo++) 
        {
            txtAlign = 2;
            [frm setMaximumFractionDigits:0];
            switch (_lblNo) {
                case 0:
                    addDivider = NO;
                    xWidth = slWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%d",p_rowNo];
                    txtAlign = 0;
                    lblBackColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.4];
                    break;
                case 1:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"  %@    ",[p_dataDict valueForKey:@"MONTHS"]];
                    txtAlign = 1;
                    lblBackColor = [UIColor colorWithRed:205.0f/255.0f green:133.0f/255.0f blue:63.0f/255.0f alpha:1.0];
                    break;
                case 2:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@   ",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALES"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:244.0f/255.0f green:194.0f/255.0f blue:194.0f/255.0f alpha:1.0];
                    break;
                case 3:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@   ",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"PURCHASES"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:247.0f/255.0f green:127.0f/255.0f blue:190.0f/255.0f alpha:1.0];
                    break;
                case 4:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithFormat:@"%@   ",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"VARIANCE"] integerValue]]]];
                    lblBackColor = [UIColor colorWithRed:185.0f/255.0f green:145.0f/255.0f blue:210.0f/255.0f alpha:1.0];
                    break;
                case 5:
                    xWidth = colWidth;
                    [frm setMaximumFractionDigits:2];
                    strTitle = [[NSString alloc] initWithFormat:@"%@   ",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"VARIANCEPERC"] doubleValue]]]];
                    lblBackColor = [UIColor colorWithRed:200.0f/255.0f green:115.0f/255.0f blue:185.0f/255.0f alpha:1.0];
                    break;
                default:
                    break;
            }
            lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth-1, colHeight) andTitle:[[NSString stringWithFormat:@"%@ ",strTitle] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"] andreqColor:cell.textLabel.textColor andAlignment:txtAlign];
            lblTitle.font = [UIFont systemFontOfSize:11.0f];
            [lblTitle setBackgroundColor:lblBackColor];
            xPosition +=  xWidth +1;
            lblTitle.tag = 100 + _lblNo;
            [cell.contentView addSubview:lblTitle];
            //[lblTitle release];
        }
    }
    else
    {
        for (int _lblNo = 0; _lblNo<6; _lblNo++) 
        {
            txtAlign = 2;
            [frm setMaximumFractionDigits:0];
            switch (_lblNo) {
                case 0:
                    strTitle = [[NSString alloc] initWithFormat:@"%d",p_rowNo];
                    break;
                case 1:
                    strTitle = [[NSString alloc] initWithFormat:@"  %@    ",[p_dataDict valueForKey:@"MONTHS"]];
                    break;
                case 2:
                    strTitle = [[NSString alloc] initWithFormat:@"%@   ",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"SALES"] integerValue]]]];
                    break;
                case 3:
                    strTitle = [[NSString alloc] initWithFormat:@"%@   ",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"PURCHASES"] integerValue]]]];
                    break;
                case 4:
                    strTitle = [[NSString alloc] initWithFormat:@"%@   ",[frm stringFromNumber:[NSNumber numberWithInteger:[[p_dataDict valueForKey:@"VARIANCE"] integerValue]]]];
                    break;
                case 5:
                    [frm setMaximumFractionDigits:2];
                    strTitle = [[NSString alloc] initWithFormat:@"%@   ",[frm stringFromNumber:[NSNumber numberWithDouble:[[p_dataDict valueForKey:@"VARIANCEPERC"] doubleValue]]]];
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

- (UITableViewCell*) getMainHeaderCellforTV:(UITableView*) p_TV
{
    static NSString *cellid=@"CellHeader";
    UILabel *lblTitle;
    NSString *strTitle;
    UITableViewCell  *cell = [p_TV dequeueReusableCellWithIdentifier:cellid];
    int colWidth, xPosition, slWidth, xWidth, colHeight;;
    colHeight = 30;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) {
        colWidth= 130;
        slWidth = 26;
    }
    else
    {
        colWidth= 176;
        slWidth = 30;
    }
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellid] ;
        [cell setBackgroundColor:[UIColor whiteColor]];
        xPosition = 2;
        colHeight = 45;
        for (int _lblNo = 0; _lblNo<6; _lblNo++) 
        {
            switch (_lblNo) {
                case 0:
                    xWidth = slWidth;
                    strTitle = [[NSString alloc] initWithString:@"Sl"];
                    break;
                case 1:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"Month"];
                    break;
                case 2:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"Sales"];
                    break;
                case 3:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"Purchases"];
                    break;
                case 4:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"Variance"];
                    break;
                case 5:
                    xWidth = colWidth;
                    strTitle = [[NSString alloc] initWithString:@"Variance %"];
                    break;
                default:
                    break;
            }
            lblTitle = [self getDefaultlabel:CGRectMake(xPosition, 0, xWidth, colHeight) andTitle:strTitle andreqColor:cell.textLabel.textColor andAlignment:0];
            lblTitle.font = [UIFont boldSystemFontOfSize:11.0f];
            [lblTitle setBackgroundColor:[navidataview backgroundColor]];
            xPosition +=  xWidth ;
            [cell.contentView addSubview:lblTitle];
            //[lblTitle release];
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

@end
