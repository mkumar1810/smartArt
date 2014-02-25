//
//  misSalesMiningSelect.m
//  dssapi
//
//  Created by Imac DOM on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "misSalesMiningSelect.h"

@implementation misSalesMiningSelect

- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andInitialDict:(NSDictionary*) p_initData withReturnMethod:(METHODCALLBACK) p_returnMethod
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"getSearch" forFrame:frame];
        intOrientation = p_intOrientation;
        [actIndicator startAnimating];
        _returnMethod = p_returnMethod;
        if (p_initData) 
            [self unflockStoredDataFromDict:p_initData];
        sBar.text = @"";
        sBar.hidden = YES;
        [navTitle setTitle:@"Sales Mining"];
        [navTitle leftBarButtonItem].enabled = NO;
        [self generateData];
    }
    return self;
}

- (NSDictionary*) returnSalesMiningStoredData
{
    NSMutableDictionary *l_returnDict = [[NSMutableDictionary alloc] init];

    if (_custCode) 
        [l_returnDict setValue:_custCode forKey:@"custcode"];
    else
        [l_returnDict setValue:@"" forKey:@"custcode"];

    if (_custVal) 
        [l_returnDict setValue:_custVal forKey:@"custval"];
    else
        [l_returnDict setValue:@"" forKey:@"custval"];
    
    if (_categoryCode) 
        [l_returnDict setValue:_categoryCode forKey:@"categorycode"];
    else
        [l_returnDict setValue:@"" forKey:@"categorycode"];

    if (_categoryVal) 
        [l_returnDict setValue:_categoryVal forKey:@"categoryval"];
    else
        [l_returnDict setValue:@"" forKey:@"categoryval"];
    
    if (_smCode) 
        [l_returnDict setValue:_smCode forKey:@"smcode"];
    else
        [l_returnDict setValue:@"" forKey:@"smcode"];
    
    if (_smVal) 
        [l_returnDict setValue:_smVal forKey:@"smval"];
    else
        [l_returnDict setValue:@"" forKey:@"smval"];
    
    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_scMonthSalesCustOption] forKey:@"scmonthsalescustoption"];
    
    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_scMonthSalesCategoryOption] forKey:@"scmonthsalescategoryoption"];
    
    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_scMonthSalesSMOption] forKey:@"scmonthsalessmoption"];
    
    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_prodYear] forKey:@"prodyear"];

    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_smSalesYear] forKey:@"smsalesyear"];

    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_itemSalesYear] forKey:@"itemsalesyear"];

    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_yearlySMSalesYear] forKey:@"yearlysmsalesyear"];

    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_yearExpImpYear] forKey:@"yearexpimpyear"];
    
    return l_returnDict;
}

- (void) unflockStoredDataFromDict:(NSDictionary*) p_storedDict
{
    _custCode =[[NSString alloc] initWithFormat:@"%@", [p_storedDict valueForKey:@"custcode"]];
    _custVal = [[NSString alloc] initWithFormat:@"%@", [p_storedDict valueForKey:@"custval"]];
    _categoryCode = [[NSString alloc] initWithFormat:@"%@",[p_storedDict valueForKey:@"categorycode"]];
    _categoryVal = [[NSString alloc] initWithFormat:@"%@", [p_storedDict valueForKey:@"categoryval"]];
    _smCode = [[NSString alloc] initWithFormat:@"%@",[p_storedDict valueForKey:@"smcode"]];
    _smVal = [[NSString alloc] initWithFormat:@"%@",[p_storedDict valueForKey:@"smval"]];
    _scMonthSalesCustOption = [[p_storedDict valueForKey:@"scmonthsalescustoption"] intValue];
    _scMonthSalesCategoryOption = [[p_storedDict valueForKey:@"scmonthsalescategoryoption"] intValue];
    _scMonthSalesSMOption = [[p_storedDict valueForKey:@"scmonthsalessmoption"] intValue];
    _prodYear = [[p_storedDict valueForKey:@"prodyear"] intValue];
    _smSalesYear = [[p_storedDict valueForKey:@"smsalesyear"] intValue];
    _itemSalesYear = [[p_storedDict valueForKey:@"itemsalesyear"] intValue];
    _yearlySMSalesYear = [[p_storedDict valueForKey:@"yearlysmsalesyear"] intValue];
    _yearExpImpYear = [[p_storedDict valueForKey:@"yearexpimpyear"] intValue];
}

- (void) generateData
{
    if (populationOnProgress==NO)
    {
        populationOnProgress = YES;
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:nil];
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self salesMiningDataGenerated:p_dictInfo];  
        };
        [[dssWSCallsProxy alloc] initWithReportType:@"MISSALESMINING" andInputParams:inputDict andReturnMethod:l_proxyReturn andReturnInputs:NO];
        refreshTag = 0;
    }    
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    [super setForOrientation:p_forOrientation]; 
    if (searchCust) 
        [searchCust setForOrientation:p_forOrientation];
    if (searchCategory) 
        [searchCategory setForOrientation:p_forOrientation];
    if (searchSalesman) 
        [searchSalesman setForOrientation:p_forOrientation];
}


- (void) salesMiningDataGenerated:(NSDictionary *)generatedInfo
{
    if (dataForDisplay) {
        [dataForDisplay removeAllObjects];
        //[dataForDisplay release];
    }
    dataForDisplay = [[NSMutableArray alloc] initWithArray:nil copyItems:YES];
    populationOnProgress = NO;
    [self setForOrientation:intOrientation];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (void) generateTableView
{
    [super generateTableView];
    [dispTV setDelegate:self];
    [dispTV setDataSource:self];
    [dispTV reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int noofRows= 2;
    switch (section) {
        case 0:
            noofRows = 1;
            break;
        case 5:
            noofRows = 1;
            break;
        default:
            break;
    }
    return noofRows;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self storeValues];
    //NSString *inputValue;
    NSString *tagVal = [[NSString alloc] initWithFormat:@"%d",indexPath.section+1];
    NSDictionary *inputDict; 
    switch (indexPath.section) {
        case 0:
            inputDict  = [[NSDictionary alloc] initWithObjectsAndKeys:tagVal , @"reportno", nil];
            break;
        case 1:
            if (indexPath.row!=0) return;
            inputDict = [self getValidatedParamDictforOption:_scMonthSalesCustOption andselCode:_custCode andReportNo:indexPath.section+1 forTagName:@"customercode" andAlertMsg:@"Select a valid Customer"];
            if (!inputDict) return;
            break;
        case 2:
            if (indexPath.row!=0) return;
            inputDict = [self getValidatedParamDictforOption:_scMonthSalesCategoryOption andselCode:_categoryCode andReportNo:indexPath.section+1 forTagName:@"categorycode" andAlertMsg:@"Select a valid Category"];
            if (!inputDict) return;
            break;
        case 3:
            if (indexPath.row!=0) return;
            inputDict  = [[NSDictionary alloc] initWithObjectsAndKeys:tagVal , @"reportno", [NSString stringWithFormat:@"%d",_prodYear], @"yearcode", nil];
            break;
        case 4:
            if (indexPath.row!=0) return;
            inputDict = [self getValidatedParamDictforOption:_scMonthSalesSMOption andselCode:_smCode andReportNo:indexPath.section+1 forTagName:@"salesmancode" andAlertMsg:@"Select a valid Salesman"];
            if (!inputDict) return;
            break;
        case 5:
            inputDict  = [[NSDictionary alloc] initWithObjectsAndKeys:tagVal , @"reportno", nil];
            break;
        case 6:
            inputDict  = [[NSDictionary alloc] initWithObjectsAndKeys:tagVal , @"reportno",[NSString stringWithFormat:@"%d",_smSalesYear], @"yearcode", nil];
            break;
        case 7:
            inputDict  = [[NSDictionary alloc] initWithObjectsAndKeys:tagVal , @"reportno",[NSString stringWithFormat:@"%d",_itemSalesYear], @"yearcode", nil];
            break;
        case 8:
            inputDict  = [[NSDictionary alloc] initWithObjectsAndKeys:tagVal , @"reportno",[NSString stringWithFormat:@"%d",_yearlySMSalesYear], @"yearcode", nil];
            break;
        case 9:
            inputDict  = [[NSDictionary alloc] initWithObjectsAndKeys:tagVal , @"reportno",[NSString stringWithFormat:@"%d",_yearExpImpYear], @"yearcode", nil];
            break;
        default:
            break;
    }
    if (inputDict) 
    {
        NSDictionary *returnInfo = [[NSDictionary alloc] initWithObjectsAndKeys:inputDict , @"data", nil];
        //[[NSNotificatixonCenter defaultCenter] postNoxtificationName:@"salesMiningReturn" object:self userInfo:returnInfo];
        _returnMethod(returnInfo);
        //[self removeFromSuperview];
    }
}

- (NSDictionary*) getValidatedParamDictforOption:(int) p_selOption andselCode:(NSString*) p_selCode andReportNo:(int) p_reportNo forTagName:(NSString*) p_tagCodeName andAlertMsg:(NSString*) p_alertMsg
{
    NSDictionary *l_retDict;
    if (p_selOption==0) 
        l_retDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", p_reportNo] ,@"reportno", @"0", p_tagCodeName , nil];
    else
    {
        if (p_selCode) 
        {
            if ([p_selCode isEqualToString:@""]==NO) 
                l_retDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", p_reportNo] ,@"reportno", p_selCode, p_tagCodeName , nil];
            else
            {
                l_retDict = nil;
                [self showAlertMessage:p_alertMsg];
            }
        }
        else
        {
            l_retDict = nil;
            [self showAlertMessage:p_alertMsg];
        }
    }
    return l_retDict;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"Cell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellid];
        cell.backgroundColor=[UIColor whiteColor];
    }
    else
    {
        NSArray *views = [cell.contentView subviews];
        for (UIView *tmpvw in views) 
        {
            [tmpvw removeFromSuperview];
        }
        cell.textLabel.text = @"";
    }
     
    if (indexPath.section ==0 ) 
        [self addGenericCellWithTitle:cell andTitle:@"Monthly Sales (All History) "];
    
    if (indexPath.section==1) 
        [self addMonthlySalesCustomerwise:cell forRowNo:indexPath.row];

    if (indexPath.section==2) 
        [self addMonthlySalesCategorywise:cell forRowNo:indexPath.row];

    if (indexPath.section==3) 
    {
        if (indexPath.row==0) 
            [self addGenericCellWithTitle:cell andTitle:@"Monthly Sales (Productwise)"];
        else
            txtProdWiseYear = [self addGenericYearPartIntoCell:cell forSection:indexPath.section];
    }
    
    if (indexPath.section==4) 
        [self addMonthlySalesSMWise:cell forRowNo:indexPath.row];
    
    if (indexPath.section==5) 
        [self addGenericCellWithTitle:cell andTitle:@"Export or local Sales"];
    
    if (indexPath.section==6) 
    {
        if (indexPath.row==0) 
            [self addGenericCellWithTitle:cell andTitle:@"Salesmanwise Sales for the year"];
        else
            txtsmSalesYear = [self addGenericYearPartIntoCell:cell forSection:indexPath.section];
    }
    
    if (indexPath.section==7) 
    {
        if (indexPath.row==0)
            [self addGenericCellWithTitle:cell andTitle:@"Itemwise Sales for the year"];
        else
            txtItemSalesYear = [self addGenericYearPartIntoCell:cell forSection:indexPath.section];
    }
    
    if (indexPath.section==8) 
    {
        if (indexPath.row==0)
            [self addGenericCellWithTitle:cell andTitle:@"Yearly salesman wise Sales"];
        else
            txtYearlySMSalesYear = [self addGenericYearPartIntoCell:cell forSection:indexPath.section];
    }

    if (indexPath.section==9) 
    {
        if (indexPath.row==0)
            [self addGenericCellWithTitle:cell andTitle:@"Yearly Export Vs Local Sales"];
        else
            txtYearExpImpYear = [self addGenericYearPartIntoCell:cell forSection:indexPath.section];
    }
    
    return cell;
}

- (void) addGenericCellWithTitle:(UITableViewCell*) p_cell andTitle:(NSString*) p_title
{
    NSString *lblTitle;
    lblTitle = [[NSString alloc] initWithFormat:@"  %@", p_title] ; //] @"Monthly Sales (All History) "] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
    p_cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
    p_cell.textLabel.text = lblTitle;
    p_cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [p_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (UITextField*) addGenericYearPartIntoCell:(UITableViewCell*) p_cell forSection:(int) p_section
{
    UITextField *l_retTextField;
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateFormat:@"yyyy"];
    int yearValue = [[nsdf stringFromDate:[NSDate date]] intValue];
    UIButton *btnPrev, *btnNext;
    int captionWidth, cellHeight;
    cellHeight = 50;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
        captionWidth = 215;
    else
        captionWidth = 300;
    
    btnPrev = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPrev setFrame:CGRectMake(4, 0, captionWidth+50, cellHeight-1)];
    btnPrev.titleLabel.font = [UIFont boldSystemFontOfSize:23.0f];
    [btnPrev setTitle:@"Previous(-)" forState:UIControlStateNormal];
    btnPrev.titleLabel.textAlignment = UITextAlignmentRight;
    [btnPrev setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPrev setBackgroundColor:[UIColor whiteColor]];
    btnPrev.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnPrev addTarget:self action:@selector(addSubtractYear:) forControlEvents:UIControlEventTouchDown];
    btnPrev.tag = p_section*100 - 1;
    [p_cell.contentView addSubview:btnPrev];
    //[btnPrev release];
    
    //return nil;
    
    l_retTextField = [[UITextField alloc] initWithFrame:CGRectMake(captionWidth+6+30, 0, captionWidth-60, cellHeight)];
    l_retTextField.font = [UIFont boldSystemFontOfSize:23.0f];
    l_retTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    l_retTextField.textAlignment = UITextAlignmentCenter;
    switch (p_section) 
    {
        case 3:
            if (_prodYear==0) _prodYear = yearValue;
            l_retTextField.text = [[NSString alloc] initWithFormat:@"%d", _prodYear];
            break;
        case 6:
            if (_smSalesYear==0) _smSalesYear = [[nsdf stringFromDate:[NSDate date]] intValue];
            l_retTextField.text = [[NSString alloc] initWithFormat:@"%d", _smSalesYear];
            break;
        case 7:
            if (_itemSalesYear==0) _itemSalesYear = yearValue;
            l_retTextField.text = [[NSString alloc] initWithFormat:@"%d", _itemSalesYear];
            break;
        case 8:
            if (_yearlySMSalesYear==0) _yearlySMSalesYear = yearValue;
            l_retTextField.text = [[NSString alloc] initWithFormat:@"%d", _yearlySMSalesYear];
            break;
        case 9:
            if (_yearExpImpYear==0) _yearExpImpYear = yearValue;
            l_retTextField.text = [[NSString alloc] initWithFormat:@"%d", _yearExpImpYear];
            break;
        default:
            break;
    }
    [p_cell.contentView addSubview:l_retTextField];          

    btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnNext setFrame:CGRectMake(2*captionWidth+8-30, 0, captionWidth, cellHeight-1)];
    btnNext.titleLabel.font = [UIFont boldSystemFontOfSize:23.0f];
    btnNext.titleLabel.textAlignment = UITextAlignmentLeft;
    [btnNext setTitle:@"Next(+)" forState:UIControlStateNormal];
    [btnNext setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnNext.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnNext setBackgroundColor:[UIColor whiteColor]];
    [btnNext addTarget:self action:@selector(addSubtractYear:) forControlEvents:UIControlEventTouchDown];
    btnNext.tag = p_section*100 + 1;
    [p_cell.contentView addSubview:btnNext];
    //[btnNext release];
    p_cell.accessoryType = UITableViewCellAccessoryNone;
    [p_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return l_retTextField;
}

- (IBAction) addSubtractYear:(id) sender
{
    NSDateFormatter *nsdf = [[NSDateFormatter alloc] init];
    [nsdf setDateFormat:@"yyyy"];
    int currYear = [[nsdf stringFromDate:[NSDate date]] intValue];
    UIButton *btnClicked = (UIButton*) sender;
    switch (btnClicked.tag) {
        case 299:
            _prodYear--;
            [txtProdWiseYear setText:[[NSString alloc] initWithFormat:@"%d", _prodYear]];
            break;
        case 301:
            _prodYear = (_prodYear>=currYear) ? currYear : ++_prodYear;
            [txtProdWiseYear setText:[[NSString alloc] initWithFormat:@"%d", _prodYear]];
            break;
        case 599:
            _smSalesYear--;
            [txtsmSalesYear setText:[[NSString alloc] initWithFormat:@"%d", _smSalesYear]];
            break;
        case 601:
            _smSalesYear = (_smSalesYear>=currYear) ? currYear : ++_smSalesYear;
            [txtsmSalesYear setText:[[NSString alloc] initWithFormat:@"%d", _smSalesYear]];
            break;
        case 699:
            _itemSalesYear--;
            [txtItemSalesYear setText:[[NSString alloc] initWithFormat:@"%d", _itemSalesYear]];
            break;
        case 701:
            _itemSalesYear = (_itemSalesYear>=currYear) ? currYear : ++_itemSalesYear;
            [txtItemSalesYear setText:[[NSString alloc] initWithFormat:@"%d", _itemSalesYear]];
            break;
        case 799:
            _yearlySMSalesYear--;
            [txtYearlySMSalesYear setText:[[NSString alloc] initWithFormat:@"%d", _yearlySMSalesYear]];
            break;
        case 801:
            _yearlySMSalesYear = (_yearlySMSalesYear>=currYear) ? currYear : ++_yearlySMSalesYear;
            [txtYearlySMSalesYear setText:[[NSString alloc] initWithFormat:@"%d", _yearlySMSalesYear]];
            break;
        case 899:
            _yearExpImpYear--;
            [txtYearExpImpYear setText:[[NSString alloc] initWithFormat:@"%d", _yearExpImpYear]];
            break;
        case 901:
            _yearExpImpYear = (_yearExpImpYear>=currYear) ? currYear : ++_yearExpImpYear;
            [txtYearExpImpYear setText:[[NSString alloc] initWithFormat:@"%d", _yearExpImpYear]];
            break;
        default:
            break;
    }
}

- (void) addMonthlySalesSMWise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo
{
    NSString *strTitle;
    UILabel *lblTitle;
    UIButton *btnSelect;
    NSArray *custOptions = [NSArray arrayWithObjects: @"All", @"Individual", nil];
    BOOL dividerNeeded;
    int captionWidth,selectWidth, cellHeight, entryWidth;
    cellHeight = 50;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        captionWidth = 102;
        selectWidth = 180;
        entryWidth = 370;
    }
    else
    {
        captionWidth = 157;
        selectWidth = 240;
        entryWidth = 490;
    }
    
    dividerNeeded = YES;
    switch (p_rowNo) {
        case 0:
            {
                strTitle = [[[NSString alloc] initWithFormat:@"  %@", @"Monthly Sales (Salesmanwise) "] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
                p_cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
                p_cell.textLabel.text = strTitle;
                p_cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
        case 1:
            {
                strTitle =[[NSString alloc] initWithFormat:@"  %@",@"Salesman"];
                strTitle = [strTitle stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
                lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, captionWidth, cellHeight-1)];
                lblTitle.font = [UIFont systemFontOfSize:18.0f];
                lblTitle.text = strTitle;
                [lblTitle setBackgroundColor:[UIColor whiteColor]];
                [p_cell.contentView addSubview:lblTitle];
                //[lblTitle release];
                
                scAllIndSalesman = [[UISegmentedControl alloc] initWithItems:custOptions];
                [scAllIndSalesman setFrame:CGRectMake(captionWidth+6, 0, selectWidth, cellHeight)];
                [scAllIndSalesman setSelectedSegmentIndex:_scMonthSalesSMOption];
                UIFont *font = [UIFont systemFontOfSize:18.0f];
                NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                                       forKey:UITextAttributeFont];
                [scAllIndSalesman setTitleTextAttributes:attributes 
                                                forState:UIControlStateNormal];
                [p_cell.contentView addSubview:scAllIndSalesman];            
                txtSalesman = [[UITextField alloc] initWithFrame:CGRectMake(captionWidth+12+selectWidth, 0, entryWidth-30, cellHeight)];
                if (_smVal) 
                {
                    //NSLog(@"value of smval %@", _smVal);
                    txtSalesman.text = _smVal;
                }
                else
                    txtSalesman.text = @"";
                txtSalesman.enabled = NO;
                txtSalesman.placeholder = @"(Select Salesman)";
                txtSalesman.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                [p_cell.contentView addSubview:txtSalesman];
                btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(captionWidth+25-30+selectWidth+entryWidth, 0, 30, cellHeight)];
                btnSelect.titleLabel.text=@"";
                [btnSelect setImage:[UIImage imageNamed:@"s.png"] forState:UIControlStateNormal];
                [btnSelect addTarget:self action:@selector(selectFromDropdown:) forControlEvents:UIControlEventTouchDown];
                [p_cell.contentView addSubview:btnSelect];
                btnSelect.tag = 4;
            }
            break;
        default:
            {
            
            }
            break;
    }
    [p_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void) addMonthlySalesCategorywise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo
{
    NSString *strTitle;
    UILabel *lblTitle;
    UIButton *btnSelect;
    NSArray *custOptions = [NSArray arrayWithObjects: @"All", @"Individual", nil];
    BOOL dividerNeeded;
    int captionWidth,selectWidth, cellHeight, entryWidth;
    cellHeight = 50;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        captionWidth = 102;
        selectWidth = 180;
        entryWidth = 370;
    }
    else
    {
        captionWidth = 157;
        selectWidth = 240;
        entryWidth = 490;
    }
    
    dividerNeeded = YES;
    switch (p_rowNo) {
        case 0:
        {
            strTitle = [[[NSString alloc] initWithFormat:@"  %@", @"Monthly Sales (Categorywise) "] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
            p_cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
            p_cell.textLabel.text = strTitle;
            p_cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:
        {
            strTitle =[[NSString alloc] initWithFormat:@"  %@",@"Category"];
            strTitle = [strTitle stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
            lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, captionWidth, cellHeight-1)];
            lblTitle.font = [UIFont systemFontOfSize:18.0f];
            lblTitle.text = strTitle;
            [lblTitle setBackgroundColor:[UIColor whiteColor]];
            [p_cell.contentView addSubview:lblTitle];
            //[lblTitle release];
            
            scAllIndCategory = [[UISegmentedControl alloc] initWithItems:custOptions];
            [scAllIndCategory setFrame:CGRectMake(captionWidth+6, 0, selectWidth, cellHeight)];
            [scAllIndCategory setSelectedSegmentIndex:_scMonthSalesCategoryOption];
            UIFont *font = [UIFont systemFontOfSize:18.0f];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                                   forKey:UITextAttributeFont];
            [scAllIndCategory setTitleTextAttributes:attributes 
                                            forState:UIControlStateNormal];
            [p_cell.contentView addSubview:scAllIndCategory];            
            txtCategory = [[UITextField alloc] initWithFrame:CGRectMake(captionWidth+12+selectWidth, 0, entryWidth-30, cellHeight)];
            if (_categoryVal) 
                txtCategory.text = _categoryVal;
            else
                txtCategory.text = @"";
            txtCategory.enabled = NO;
            txtCategory.placeholder = @"(Select Category)";
            txtCategory.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [p_cell.contentView addSubview:txtCategory];
            btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(captionWidth+25-30+selectWidth+entryWidth, 0, 30, cellHeight)];
            btnSelect.titleLabel.text=@"";
            [btnSelect setImage:[UIImage imageNamed:@"s.png"] forState:UIControlStateNormal];
            [btnSelect addTarget:self action:@selector(selectFromDropdown:) forControlEvents:UIControlEventTouchDown];
            [p_cell.contentView addSubview:btnSelect];
            btnSelect.tag = 2;
        }
            break;
        default:
        {}
            break;
    }
    [p_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void) addMonthlySalesCustomerwise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo
{
    NSString *strTitle;
    UILabel *lblTitle;
    UIButton *btnSelect;
    NSArray *custOptions = [NSArray arrayWithObjects: @"All", @"Individual", nil];
    BOOL dividerNeeded;
    int captionWidth,selectWidth, cellHeight, entryWidth;
    cellHeight = 50;
    if (UIInterfaceOrientationIsPortrait(intOrientation)) 
    {
        captionWidth = 102;
        selectWidth = 180;
        entryWidth = 370;
    }
    else
    {
        captionWidth = 157;
        selectWidth = 240;
        entryWidth = 490;
    }
    
    dividerNeeded = YES;
    switch (p_rowNo) {
        case 0:
        {
            strTitle = [[[NSString alloc] initWithFormat:@"  %@", @"Monthly Sales (Customerwise) "] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
            p_cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
            p_cell.textLabel.text = strTitle;
            p_cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:
        {
            strTitle =[[NSString alloc] initWithFormat:@"  %@",@"Customer"];
            strTitle = [strTitle stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
            lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, captionWidth, cellHeight-1)];
            lblTitle.font = [UIFont systemFontOfSize:18.0f];
            lblTitle.text = strTitle;
            [lblTitle setBackgroundColor:[UIColor whiteColor]];
            [p_cell.contentView addSubview:lblTitle];
            //[lblTitle release];
            
            scAllIndCustomer = [[UISegmentedControl alloc] initWithItems:custOptions];
            [scAllIndCustomer setFrame:CGRectMake(captionWidth+6, 0, selectWidth, cellHeight)];
            [scAllIndCustomer setSelectedSegmentIndex:_scMonthSalesCustOption];
            UIFont *font = [UIFont systemFontOfSize:18.0f];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                                   forKey:UITextAttributeFont];
            [scAllIndCustomer setTitleTextAttributes:attributes 
                                            forState:UIControlStateNormal];
            [p_cell.contentView addSubview:scAllIndCustomer];            
            txtCustomer = [[UITextField alloc] initWithFrame:CGRectMake(captionWidth+12+selectWidth, 0, entryWidth-30, cellHeight)];
            if (_custVal) 
                txtCustomer.text = _custVal;
            else
                txtCustomer.text = @"";
            txtCustomer.enabled = NO;
            txtCustomer.placeholder = @"(Select Customer)";
            txtCustomer.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [p_cell.contentView addSubview:txtCustomer];
            btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(captionWidth+25-30+selectWidth+entryWidth, 0, 30, cellHeight)];
            btnSelect.titleLabel.text=@"";
            [btnSelect setImage:[UIImage imageNamed:@"s.png"] forState:UIControlStateNormal];
            [btnSelect addTarget:self action:@selector(selectFromDropdown:) forControlEvents:UIControlEventTouchDown];
            [p_cell.contentView addSubview:btnSelect];
            btnSelect.tag = 1;
        }
            break;
        default:
        {}
            break;
    }
    [p_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void) selectFromDropdown:(id) sender
{
    METHODCALLBACK l_selectReturn;
    [self storeValues];
    UIButton *btnClicked = (UIButton*) sender;
    switch (btnClicked.tag) {
        case 1:
        {
            l_selectReturn = ^(NSDictionary* p_dictInfo)
            {
                [self searchCustomerReturn:p_dictInfo];
            };
            searchCust = [[custSearch alloc] initWithFrame:self.frame forOrientation:intOrientation andReturnMethod:l_selectReturn];
            [self addSubview:searchCust];
        }
            break;
        case 2:
        {
            l_selectReturn = ^(NSDictionary* p_dictInfo)
            {
                [self searchCategoryReturn:p_dictInfo];
            };
            searchCategory = [[categorySearch alloc] initWithFrame:self.frame forOrientation:intOrientation andReturnMethod:l_selectReturn];
            [self addSubview:searchCategory];
        }
            break;
        case 4:
        {
            l_selectReturn = ^(NSDictionary* p_dictInfo)
            {
                [self searchSalesmanReturn:p_dictInfo];
            };
            searchSalesman = [[salesmanSelect alloc] initWithFrame:self.frame forOrientation:intOrientation andReturnMethod:l_selectReturn];
            [self addSubview:searchSalesman];
        }
            break;
        default:
            break;
    }
}

- (void) searchCustomerReturn:(NSDictionary *)custInfo
{
    [searchCust removeFromSuperview];
    if (custInfo) {
        //NSLog(@"customer info %@", recdData);
        _custCode= [[NSString alloc] initWithFormat:@"%@", [custInfo valueForKey:@"CD"]];
        _custVal = [[NSString alloc] initWithFormat:@"%@ - %@", [custInfo valueForKey:@"CD"], [custInfo valueForKey:@"CN"]];
    }
    //[searchCust release];
    searchCust = nil;
    [self setForOrientation:intOrientation];
}

- (void) searchCategoryReturn:(NSDictionary *)categoryInfo
{
    [searchCategory removeFromSuperview];
    if (categoryInfo) 
    {
        _categoryCode= [[NSString alloc] initWithFormat:@"%@", [categoryInfo valueForKey:@"CATCODE"]];
        _categoryVal = [[NSString alloc] initWithFormat:@"%@ - %@", [categoryInfo valueForKey:@"CATCODE"], [categoryInfo valueForKey:@"CATDESC"]];
    }
    //[searchCategory release];
    searchCategory = nil;
    [self setForOrientation:intOrientation];
}

- (void) searchSalesmanReturn:(NSDictionary *)salesmanInfo
{
    [searchSalesman removeFromSuperview];
    if (salesmanInfo) {
        _smCode = [[NSString alloc] initWithFormat:@"%@", [salesmanInfo valueForKey:@"SMCODE"]];
        _smVal = [[NSString alloc] initWithFormat:@"%@ - %@", [salesmanInfo valueForKey:@"SMCODE"], [salesmanInfo valueForKey:@"SMNAME"]];
    }
    //[searchSalesman release];
    searchSalesman = nil;
    [self setForOrientation:intOrientation];
}


- (IBAction) refreshData:(id) sender
{
    [actIndicator setHidden:NO];
    [actIndicator startAnimating];
    [dispTV removeFromSuperview];
    refreshTag = 1;
    [self generateData];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidBeginEditing:searchBar];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidEndEditing:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [super searchBarCancelButtonClicked:searchBar];
}

// called when Search (in our case “Done”) button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [super searchBarSearchButtonClicked:searchBar];
    [self generateData];
}

- (IBAction) goBack:(id) sender
{
    NSMutableDictionary *returnInfo = [[NSMutableDictionary alloc] init];
    [returnInfo setValue:nil forKey:@"data"];
    //[[NSNotifxicationCenter defaultCenter] postNotixficationName:@"salesMiningReturn" object:self userInfo:returnInfo];
    _returnMethod(returnInfo);

}

- (void)dealloc
{
    //[super dealloc];
}

- (void) storeValues
{
    if (scAllIndCustomer) 
        _scMonthSalesCustOption = [scAllIndCustomer selectedSegmentIndex];
    
    if (scAllIndCategory) 
        _scMonthSalesCategoryOption = [scAllIndCategory selectedSegmentIndex];
    
    if (scAllIndSalesman) 
        _scMonthSalesSMOption = [scAllIndSalesman selectedSegmentIndex];
    
}

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

@end
