//
//  misPurchMiningSelect.m
//  dssapi
//
//  Created by Imac DOM on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "misPurchMiningSelect.h"

@implementation misPurchMiningSelect

- (id)initWithFrame:(CGRect)frame forOrientation:(UIInterfaceOrientation) p_intOrientation andInitialDict:(NSDictionary*) p_initData andReturnMethod:(METHODCALLBACK) p_returnMethod
{
    self = [super initWithFrame:frame];
    if (self) {
        [super addNIBView:@"getSearch" forFrame:frame];
        intOrientation = p_intOrientation;
        [actIndicator startAnimating];
        _purchReturnMethod = p_returnMethod;
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchMiningDataGenerated:)  name:@"purchMiningDataGenerated" object:nil];
        //[[NSNotificxationCenter defaultCenter] addObserver:self selector:@selector(searchSupplierReturn:) name:@"searchSuppReturnDSSPurchMining" object:nil];
        //[[NSNotifxicationCenter defaultCenter] addObserver:self selector:@selector(searchCategoryReturn:) name:@"searchCatQtyReturnDSSPurchMining" object:nil];
        //[[NSNotifxicationCenter defaultCenter] addObserver:self selector:@selector(searchCategoryReturn:) name:@"searchCatValReturnDSSPurchMining" object:nil];
        //[[NSNotifixcationCenter defaultCenter] addObserver:self selector:@selector(searchCategoryReturn:) name:@"searchCatAvgReturnDSSPurchMining" object:nil];
        //_notificationName = [[NSString alloc] initWithFormat:@"%@",@"purchMiningDataGenerated"];
        if (p_initData) 
            [self unflockStoredDataFromDict:p_initData];
        sBar.text = @"";
        sBar.hidden = YES;
        [navTitle setTitle:@"Purchase Mining"];
        [navTitle leftBarButtonItem].enabled = NO;
        [self generateData];
    }
    return self;
}

- (NSDictionary*) returnPurchaseMiningStoredData
{
    NSMutableDictionary *l_returnDict = [[NSMutableDictionary alloc] init];
    
    if (_suppCode) 
        [l_returnDict setValue:_suppCode forKey:@"suppcode"];
    else
        [l_returnDict setValue:@"" forKey:@"suppcode"];
        
    if (_suppVal) 
        [l_returnDict setValue:_suppVal forKey:@"suppval"];
    else
        [l_returnDict setValue:@"" forKey:@"suppval"];
    
    if (_catCodeQty) 
        [l_returnDict setValue:_catCodeQty forKey:@"catcodeqty"];
    else
        [l_returnDict setValue:@"" forKey:@"catcodeqty"];
    
    if (_catValQty) 
        [l_returnDict setValue:_catValQty forKey:@"catvalqty"];
    else
        [l_returnDict setValue:@"" forKey:@"catvalqty"];

    if (_catCodeValue) 
        [l_returnDict setValue:_catCodeValue forKey:@"catcodevalue"];
    else
        [l_returnDict setValue:@"" forKey:@"catcodevalue"];
    
    if (_catValValue) 
        [l_returnDict setValue:_catValValue forKey:@"catvalvalue"];
    else
        [l_returnDict setValue:@"" forKey:@"catvalvalue"];

    if (_catCodeAvg) 
        [l_returnDict setValue:_catCodeAvg forKey:@"catcodeavg"];
    else
        [l_returnDict setValue:@"" forKey:@"catcodeavg"];

    if (_catValAvg) 
        [l_returnDict setValue:_catValAvg forKey:@"catvalavg"];
    else
        [l_returnDict setValue:@"" forKey:@"catvalavg"];

    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_scMonthPurchsuppOption] forKey:@"scmonthpurchsuppoption"];
    
    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_scMonthPurchCatQty] forKey:@"scpurchcatqty"];
    
    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_scMonthPurchCatVal] forKey:@"scpurchcatval"];
    
    [l_returnDict setValue:[NSString stringWithFormat:@"%d",_scMonthPurchCatAvg] forKey:@"scpurchcatavg"];

    return l_returnDict;
}

- (void) unflockStoredDataFromDict:(NSDictionary*) p_storedDict
{
    _suppCode =[[NSString alloc] initWithFormat:@"%@", [p_storedDict valueForKey:@"suppcode"]];
    _suppVal = [[NSString alloc] initWithFormat:@"%@", [p_storedDict valueForKey:@"suppval"]];
    _catCodeQty = [[NSString alloc] initWithFormat:@"%@",[p_storedDict valueForKey:@"catcodeqty"]];
    _catValQty = [[NSString alloc] initWithFormat:@"%@", [p_storedDict valueForKey:@"catvalqty"]];
    _catCodeValue = [[NSString alloc] initWithFormat:@"%@",[p_storedDict valueForKey:@"catcodevalue"]];
    _catValValue = [[NSString alloc] initWithFormat:@"%@", [p_storedDict valueForKey:@"catvalvalue"]];
    _catCodeAvg = [[NSString alloc] initWithFormat:@"%@",[p_storedDict valueForKey:@"catcodeavg"]];
    _catValAvg = [[NSString alloc] initWithFormat:@"%@", [p_storedDict valueForKey:@"catvalavg"]];
    _scMonthPurchsuppOption = [[p_storedDict valueForKey:@"scmonthpurchsuppoption"] intValue];
    _scMonthPurchCatQty = [[p_storedDict valueForKey:@"scpurchcatqty"] intValue];
    _scMonthPurchCatVal = [[p_storedDict valueForKey:@"scpurchcatval"] intValue];
    _scMonthPurchCatAvg = [[p_storedDict valueForKey:@"scpurchcatavg"] intValue];
}

- (void) generateData
{
    if (populationOnProgress==NO)
    {
        populationOnProgress = YES;
        NSDictionary *inputDict = [[NSDictionary alloc] initWithObjectsAndKeys:nil];
        METHODCALLBACK l_proxyReturn = ^(NSDictionary* p_dictInfo)
        {
            [self purchMiningDataGenerated:p_dictInfo];
        };
        [[dssWSCallsProxy alloc] initWithReportType:@"MISPURCHASEMINING" andInputParams:inputDict andReturnMethod:l_proxyReturn andReturnInputs:NO];
        refreshTag = 0;
    }    
}

- (void) setForOrientation: (UIInterfaceOrientation) p_forOrientation
{
    [super setForOrientation:p_forOrientation]; 
    if (searchSupp) 
        [searchSupp setForOrientation:p_forOrientation];
    if (searchCategory) 
        [searchCategory setForOrientation:p_forOrientation];
}


- (void) purchMiningDataGenerated:(NSDictionary *)generatedInfo
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
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int noofRows;
    if (section==0) 
        noofRows = 1;
    else
        noofRows = 2;
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
    NSString *tagVal = [[NSString alloc] initWithFormat:@"%d",indexPath.section+1];
    NSDictionary *inputDict; 
    switch (indexPath.section) {
        case 0:
            inputDict  = [[NSDictionary alloc] initWithObjectsAndKeys:tagVal , @"reportno", nil];
            break;
        case 1:
            if (indexPath.row!=0) return;
            inputDict = [self getValidatedParamDictforOption:_scMonthPurchsuppOption andselCode:_suppCode andReportNo:indexPath.section+1 forTagName:@"suppliercode" andAlertMsg:@"Select a valid Supplier"];
            if (!inputDict) return;
            break;
        case 2:
            if (indexPath.row!=0) return;
            inputDict = [self getValidatedParamDictforOption:_scMonthPurchCatQty andselCode:_catCodeQty andReportNo:indexPath.section+1 forTagName:@"categorycode" andAlertMsg:@"Select a valid Category"];
            if (!inputDict) return;
            break;
        case 3:
            if (indexPath.row!=0) return;
            inputDict = [self getValidatedParamDictforOption:_scMonthPurchCatVal andselCode:_catCodeValue andReportNo:indexPath.section+1 forTagName:@"categorycode" andAlertMsg:@"Select a valid Category"];
            if (!inputDict) return;
            break;
        case 4:
            if (indexPath.row!=0) return;
            inputDict = [self getValidatedParamDictforOption:_scMonthPurchCatAvg andselCode:_catCodeAvg andReportNo:indexPath.section+1 forTagName:@"categorycode" andAlertMsg:@"Select a valid Category"];
            if (!inputDict) return;
            break;
        default:
            break;
    }
    if (inputDict) 
    {
        NSDictionary *returnInfo = [[NSDictionary alloc] initWithObjectsAndKeys:inputDict , @"data", nil];
        //[[NSNotificaxtionCenter defaultCenter] postNotifxicationName:@"purchMiningReturn" object:self userInfo:returnInfo];
        _purchReturnMethod(returnInfo);
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
        [self addGenericCellWithTitle:cell andTitle:@"Monthly Purchases (All History) "];
    
    if (indexPath.section==1) 
        [self addMonthlyPurchSupplierwise:cell forRowNo:indexPath.row];
    
    if (indexPath.section==2) 
        [self addPurchasesQtyCategorywise:cell forRowNo:indexPath.row];
    
    if (indexPath.section==3) 
        [self addPurchasesValCategorywise:cell forRowNo:indexPath.row];
    
    if (indexPath.section==4) 
        [self addPurchasesAvgCategorywise:cell forRowNo:indexPath.row];
    
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

- (void) addMonthlyPurchSupplierwise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo
{
    NSString *strTitle;
    UILabel *lblTitle;
    UIButton *btnSelect;
    NSArray *suppOptions = [NSArray arrayWithObjects: @"All", @"Individual", nil];
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
            strTitle = [[[NSString alloc] initWithFormat:@"  %@", @"Monthly Purchases (Supplierwise) "] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
            p_cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
            p_cell.textLabel.text = strTitle;
            p_cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:
        {
            strTitle =[[NSString alloc] initWithFormat:@"  %@",@"Supplier"];
            strTitle = [strTitle stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"];
            lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, captionWidth, cellHeight-1)];
            lblTitle.font = [UIFont systemFontOfSize:18.0f];
            lblTitle.text = strTitle;
            [lblTitle setBackgroundColor:[UIColor whiteColor]];
            [p_cell.contentView addSubview:lblTitle];
            //[lblTitle release];
            
            scAllIndSupplier = [[UISegmentedControl alloc] initWithItems:suppOptions];
            [scAllIndSupplier setFrame:CGRectMake(captionWidth+6, 0, selectWidth, cellHeight)];
            [scAllIndSupplier setSelectedSegmentIndex:_scMonthPurchsuppOption];
            UIFont *font = [UIFont systemFontOfSize:18.0f];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                                   forKey:UITextAttributeFont];
            [scAllIndSupplier setTitleTextAttributes:attributes 
                                            forState:UIControlStateNormal];
            [p_cell.contentView addSubview:scAllIndSupplier];            
            txtSupplier = [[UITextField alloc] initWithFrame:CGRectMake(captionWidth+12+selectWidth, 0, entryWidth-30, cellHeight)];
            if (_suppVal) 
            {
                //NSLog(@"value of smval %@", _smVal);
                txtSupplier.text = _suppVal;
            }
            else
                txtSupplier.text = @"";
            txtSupplier.enabled = NO;
            txtSupplier.placeholder = @"(Select Supplier)";
            txtSupplier.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [p_cell.contentView addSubview:txtSupplier];
            
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

- (void) addPurchasesQtyCategorywise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo
{
    NSString *strTitle;
    UILabel *lblTitle;
    UIButton *btnSelect;
    NSArray *suppOptions = [NSArray arrayWithObjects: @"All", @"Individual", nil];
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
            strTitle = [[[NSString alloc] initWithFormat:@"  %@", @"Categorywise Purchases - Quantity "] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
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
            
            scAllIndCatQty = [[UISegmentedControl alloc] initWithItems:suppOptions];
            [scAllIndCatQty setFrame:CGRectMake(captionWidth+6, 0, selectWidth, cellHeight)];
            [scAllIndCatQty setSelectedSegmentIndex:_scMonthPurchCatQty];
            UIFont *font = [UIFont systemFontOfSize:18.0f];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                                   forKey:UITextAttributeFont];
            [scAllIndCatQty setTitleTextAttributes:attributes 
                                            forState:UIControlStateNormal];
            [p_cell.contentView addSubview:scAllIndCatQty];            
            txtCatQty = [[UITextField alloc] initWithFrame:CGRectMake(captionWidth+12+selectWidth, 0, entryWidth-30, cellHeight)];
            if (_catValQty) 
                txtCatQty.text = _catValQty;
            else
                txtCatQty.text = @"";
            txtCatQty.enabled = NO;
            txtCatQty.placeholder = @"(Select Category)";
            txtCatQty.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [p_cell.contentView addSubview:txtCatQty];
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

- (void) addPurchasesValCategorywise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo
{
    NSString *strTitle;
    UILabel *lblTitle;
    UIButton *btnSelect;
    NSArray *suppOptions = [NSArray arrayWithObjects: @"All", @"Individual", nil];
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
            strTitle = [[[NSString alloc] initWithFormat:@"  %@", @"Categorywise Purchases - Value "] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
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
            
            scAllIndCatVal = [[UISegmentedControl alloc] initWithItems:suppOptions];
            [scAllIndCatVal setFrame:CGRectMake(captionWidth+6, 0, selectWidth, cellHeight)];
            [scAllIndCatVal setSelectedSegmentIndex:_scMonthPurchCatVal];
            UIFont *font = [UIFont systemFontOfSize:18.0f];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                                   forKey:UITextAttributeFont];
            [scAllIndCatVal setTitleTextAttributes:attributes 
                                          forState:UIControlStateNormal];
            [p_cell.contentView addSubview:scAllIndCatVal];            
            txtCatVal = [[UITextField alloc] initWithFrame:CGRectMake(captionWidth+12+selectWidth, 0, entryWidth-30, cellHeight)];
            if (_catValValue) 
                txtCatVal.text = _catValValue;
            else
                txtCatVal.text = @"";
            txtCatVal.enabled = NO;
            txtCatVal.placeholder = @"(Select Category)";
            txtCatVal.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [p_cell.contentView addSubview:txtCatVal];
            btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(captionWidth+25-30+selectWidth+entryWidth, 0, 30, cellHeight)];
            btnSelect.titleLabel.text=@"";
            [btnSelect setImage:[UIImage imageNamed:@"s.png"] forState:UIControlStateNormal];
            [btnSelect addTarget:self action:@selector(selectFromDropdown:) forControlEvents:UIControlEventTouchDown];
            [p_cell.contentView addSubview:btnSelect];
            btnSelect.tag = 3;
        }
            break;
        default:
        {}
            break;
    }
    [p_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void) addPurchasesAvgCategorywise:(UITableViewCell*) p_cell forRowNo:(int) p_rowNo
{
    NSString *strTitle;
    UILabel *lblTitle;
    UIButton *btnSelect;
    NSArray *suppOptions = [NSArray arrayWithObjects: @"All", @"Individual", nil];
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
            strTitle = [[[NSString alloc] initWithFormat:@"  %@", @"Categorywise Purchases - Average "] stringByReplacingOccurrencesOfString:@" " withString:@"\u00A0"]; 
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
            
            scAllIndCatAvg = [[UISegmentedControl alloc] initWithItems:suppOptions];
            [scAllIndCatAvg setFrame:CGRectMake(captionWidth+6, 0, selectWidth, cellHeight)];
            [scAllIndCatAvg setSelectedSegmentIndex:_scMonthPurchCatAvg];
            UIFont *font = [UIFont systemFontOfSize:18.0f];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                                   forKey:UITextAttributeFont];
            [scAllIndCatAvg setTitleTextAttributes:attributes 
                                          forState:UIControlStateNormal];
            [p_cell.contentView addSubview:scAllIndCatAvg];            
            txtCatAvg = [[UITextField alloc] initWithFrame:CGRectMake(captionWidth+12+selectWidth, 0, entryWidth-30, cellHeight)];
            if (_catValAvg) 
                txtCatAvg.text = _catValAvg;
            else
                txtCatAvg.text = @"";
            txtCatAvg.enabled = NO;
            txtCatAvg.placeholder = @"(Select Category)";
            txtCatAvg.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [p_cell.contentView addSubview:txtCatAvg];
            btnSelect = [[UIButton alloc] initWithFrame:CGRectMake(captionWidth+25-30+selectWidth+entryWidth, 0, 30, cellHeight)];
            btnSelect.titleLabel.text=@"";
            [btnSelect setImage:[UIImage imageNamed:@"s.png"] forState:UIControlStateNormal];
            [btnSelect addTarget:self action:@selector(selectFromDropdown:) forControlEvents:UIControlEventTouchDown];
            [p_cell.contentView addSubview:btnSelect];
            btnSelect.tag = 4;
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
    METHODCALLBACK l_returnMethod;
    [self storeValues];
    UIButton *btnClicked = (UIButton*) sender;
    switch (btnClicked.tag) {
        case 1:
        {
            l_returnMethod = ^(NSDictionary* p_dictInfo)
            {
                [self searchSupplierReturn:p_dictInfo];
            };
            searchSupp = [[suppSearch alloc] initWithFrame:self.frame forOrientation:intOrientation andReturnMethod:l_returnMethod];
            [self addSubview:searchSupp];
        }
            break;
        case 2:
        {
            l_returnMethod = ^(NSDictionary* p_dictInfo)
            {
                [self searchCategoryReturnQty:p_dictInfo];
            };
            searchCategory = [[categorySearch alloc] initWithFrame:self.frame forOrientation:intOrientation andReturnMethod:l_returnMethod];
            [self addSubview:searchCategory];
        }
            break;
        case 3:
        {
            l_returnMethod = ^(NSDictionary* p_dictInfo)
            {
                [self searchCategoryReturnVal:p_dictInfo];
            };
            searchCategory = [[categorySearch alloc] initWithFrame:self.frame forOrientation:intOrientation andReturnMethod:l_returnMethod];
            [self addSubview:searchCategory];
        }
            break;
        case 4:
        {
            l_returnMethod = ^(NSDictionary* p_dictInfo)
            {
                [self searchCategoryReturnVal:p_dictInfo];
            };
            searchCategory = [[categorySearch alloc] initWithFrame:self.frame forOrientation:intOrientation andReturnMethod:l_returnMethod];
            [self addSubview:searchCategory];
        }
            break;
        default:
        {}
            break;
    }
}

- (void) searchSupplierReturn:(NSDictionary *)suppInfo
{
    [searchSupp removeFromSuperview];
    if (suppInfo) {
        _suppCode= [[NSString alloc] initWithFormat:@"%@", [suppInfo valueForKey:@"CD"]];
        _suppVal = [[NSString alloc] initWithFormat:@"%@ - %@", [suppInfo valueForKey:@"CD"], [suppInfo valueForKey:@"SNAME"]];
    }
    //[searchSupp release];
    searchSupp = nil;
    [self setForOrientation:intOrientation];
}

- (void) searchCategoryReturnQty:(NSDictionary *)categoryInfo
{
    NSDictionary *recdData = [categoryInfo  valueForKey:@"data"];
    [searchCategory removeFromSuperview];
    if (recdData) 
    {
        _catCodeQty = [[NSString alloc] initWithFormat:@"%@", [recdData valueForKey:@"CATCODE"]];
        _catValQty = [[NSString alloc] initWithFormat:@"%@ - %@", [recdData valueForKey:@"CATCODE"], [recdData valueForKey:@"CATDESC"]];
    }
    //[searchCategory release];
    searchCategory = nil;
    [self setForOrientation:intOrientation];
}

- (void) searchCategoryReturnAvg:(NSDictionary *)categoryInfo
{
    NSDictionary *recdData = [categoryInfo  valueForKey:@"data"];
    [searchCategory removeFromSuperview];
    if (recdData) 
    {
        _catCodeAvg = [[NSString alloc] initWithFormat:@"%@", [recdData valueForKey:@"CATCODE"]];
        _catValAvg = [[NSString alloc] initWithFormat:@"%@ - %@", [recdData valueForKey:@"CATCODE"], [recdData valueForKey:@"CATDESC"]];
    }
    //[searchCategory release];
    searchCategory = nil;
    [self setForOrientation:intOrientation];
}

- (void) searchCategoryReturnVal:(NSDictionary *)categoryInfo
{
    NSDictionary *recdData = [categoryInfo  valueForKey:@"data"];
    [searchCategory removeFromSuperview];
    if (recdData) 
    {
        _catCodeValue = [[NSString alloc] initWithFormat:@"%@", [recdData valueForKey:@"CATCODE"]];
        _catValValue = [[NSString alloc] initWithFormat:@"%@ - %@", [recdData valueForKey:@"CATCODE"], [recdData valueForKey:@"CATDESC"]];
    }
    //[searchCategory release];
    searchCategory = nil;
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
    //[[NSNotificxationCenter defaultCenter] postNotificxationName:@"purchMiningReturn" object:self userInfo:returnInfo];
    _purchReturnMethod(returnInfo);
}

- (void)dealloc
{
    //[super dealloc];
}

- (void) storeValues
{
    if (scAllIndSupplier) 
        _scMonthPurchsuppOption = [scAllIndSupplier selectedSegmentIndex];
    
    if (scAllIndCatQty) 
        _scMonthPurchCatQty = [scAllIndCatQty selectedSegmentIndex];
    
    if (scAllIndCatVal) 
        _scMonthPurchCatVal = [scAllIndCatVal selectedSegmentIndex];

    if (scAllIndCatAvg) 
        _scMonthPurchCatAvg = [scAllIndCatAvg selectedSegmentIndex];

}

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

@end
