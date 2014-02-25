//
//  approvalsHeader.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "approvalsHeader.h"


@implementation approvalsHeader

//@synthesize _headertv;

- (id) initWithApiAndFlxHeaderInfo:(NSMutableArray*) apiData andFlxData:(NSMutableArray*) flxData andHideMethod:(METHODCALLBACK) p_popHideMethod andAppDocSelectMethod:(METHODCALLBACK) p_appDocSelect
{
    self = [super initWithNibName:@"approvalsHeader" bundle:nil];
    if (self) {
        _apiData = apiData;
        _flxData = flxData;
         currentData = [[NSMutableArray alloc] initWithArray:_apiData];
        _divisionCode = [[NSString alloc] initWithString:@"API"];
        _popOverHideMethod = p_popHideMethod;
        _appDocSelectMethod = p_appDocSelect;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    //[super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    CGRect tvrect = CGRectMake(0, 45, 320, 425);
    _headertv = [[UITableView alloc] initWithFrame:tvrect style:UITableViewStyleGrouped];
    //[_headertv setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_headertv];
    [_headertv setBackgroundView:nil];
    [_headertv setBackgroundView:[[UIView alloc] init]];
    [_headertv setBackgroundColor:UIColor.clearColor];
    //[self.view setBackgroundColor:[UIColor grayColor]] ; 
    [_headertv setDelegate:self];
    [_headertv setDataSource:self];
    [_headertv reloadData];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(IBAction)selected:(id)sender
{
    UISegmentedControl *sc = (UISegmentedControl*) sender;
    //NSLog(@"selected item is %d", sc.selectedSegmentIndex);
    switch (sc.selectedSegmentIndex) 
    {
        case 0: //api selected
            currentData = [[NSMutableArray alloc] initWithArray:_apiData];
            _divisionCode = @"API";
            break;
        case 1:
            currentData = [[NSMutableArray alloc] initWithArray:_flxData];
            _divisionCode = @"FLX";
            break;
        default:
            currentData = [[NSMutableArray alloc] init];
            break;
    }

    [_headertv reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"no of ites for division  nd count is %d",[currentData count] );
    return [currentData count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* curData =(NSDictionary*) [currentData objectAtIndex:indexPath.row];
    int noofitems = [[curData valueForKey:@"DOC_COUNT"] intValue];
    //noofitems = 1;
    if (noofitems>0) {
        //[[NSNotificatxxionCenter defaultCenter] postNotxxificationName:@"hidePopover" object:nil];    
        _popOverHideMethod(nil);
        NSMutableDictionary *approvalInfo = [[NSMutableDictionary alloc] init ];
        [approvalInfo setValue:_divisionCode forKey:@"divisioncode"];
        [approvalInfo setValue:indexPath forKey:@"docselected"];
        //[[NSNotificxxationCenter defaultCenter] postNotifixxcationName:@"approvalsDocSelected" object:self userInfo:approvalInfo];        
        _appDocSelectMethod(approvalInfo);
    }

    /*NSDictionary *taxDetail=[taxdata objectAtIndex:indexPath.row];
    EditTaxCode *e=[[EditTaxCode alloc]init];
    [e initWithDictionary:taxDetail];
    [self.navigationController pushViewController:e animated:NO];*/
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Executing ceeforrowindex path");
    static NSString *cellid=@"Cell";
    UILabel *lblnoofitems;    
    UILabel *lbldivider;    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:cellid] ;
        cell.backgroundColor=[UIColor clearColor];
        lbldivider = [[UILabel alloc] initWithFrame:CGRectMake(219,0, 1, 30)];
        lbldivider.backgroundColor = [UIColor grayColor];
        lbldivider.text= @"";
        [cell.contentView addSubview:lbldivider];

        lblnoofitems = [[UILabel alloc] initWithFrame:CGRectMake(221,0, 70, 30)];
        lblnoofitems.textColor = cell.textLabel.textColor; //   [UIColor colorWithRed:0.1 green:0.3 blue:0.8 alpha:0.8];
        lblnoofitems.font = [UIFont systemFontOfSize:16.0f];
        lblnoofitems.backgroundColor = [UIColor clearColor];
        lblnoofitems.numberOfLines = 1;
        lblnoofitems.textAlignment = UITextAlignmentRight;
        lblnoofitems.tag = 99;
        [cell.contentView addSubview:lblnoofitems];        
    }
    NSDictionary* curData =(NSDictionary*) [currentData objectAtIndex:indexPath.row];

    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.text = [curData valueForKey:@"DOCDESC"];
    cell.textLabel.numberOfLines = 1;
    //NSLog(@"noof view inside the cell %d", [[cell subviews] count] );

    int noofitems = [[curData valueForKey:@"DOC_COUNT"] intValue];
    lblnoofitems = (UILabel*) [cell.contentView viewWithTag:99];
    NSString *docnostr = [[NSString alloc] initWithFormat:@"%d", noofitems];
    if (noofitems==0) docnostr = @"";
    lblnoofitems.text = docnostr;
    //[lblnoofitems release];
            
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [[NSString alloc] initWithString:@"  Document Name            Pending"];
    return key;
}

@end
