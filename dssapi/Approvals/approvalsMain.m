//
//  approvalsMain.m
//  dssapi
//
//  Created by Raja T S Sekhar on 1/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "approvalsMain.h"

@implementation approvalsMain

@synthesize popover;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
        headerinforeceived=0;
    }
    return self;
}

- (void) initialize
{
    if (initialized==NO) 
    {
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(approvalsHeaderDataGenerated:) name:@"approvalsHeaderDataGenerated" object:nil];
        /*[[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(hidePopover:) 
                                                     name:@"hidePopover" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(approvalsDocSelected:) 
                                                     name:@"approvalsDocSelected" object:nil];*/
        initialized = YES;
    }    
}

- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removxeObserver:self];
    //[popover release];
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
    [self initialize];
    actview.hidesWhenStopped = TRUE;
    actview.transform = CGAffineTransformMakeScale(5.00, 5.00);        
    [actview startAnimating];
    headerinforeceived = 0;
    [self generateHeaderInformation];
    [menuButton setEnabled:NO];
    currOrientation = self.parentViewController.tabBarController.interfaceOrientation;
    [self willAnimateRotationToInterfaceOrientation:currOrientation duration:0];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) 
        [reorientView setFrame:CGRectMake(100, 250, reorientView.bounds.size.width, reorientView.bounds.size.height)];
    else
        [reorientView setFrame:CGRectMake(225, 125, reorientView.bounds.size.width, reorientView.bounds.size.height)];
    currOrientation = toInterfaceOrientation;
    UIView *previousView = [self.view viewWithTag:555];
    if (previousView!=nil)
    {
        docApprovals *da = (docApprovals*) previousView;
        [da changeInterfaceOrientation:toInterfaceOrientation];
    }
}

- (IBAction) menuButtonClicked:(id)sender
{
    BOOL l_apiexists = NO;
    bool l_flxexists = NO;
    if ([popover isPopoverVisible]) {
        [self.popover dismissPopoverAnimated:YES];
    }
    else {
        //approvalsHeader *ahdr = [[approvalsHeader alloc] initWithNibName:@"approvalsHeader" bundle:nil];
        if (apiData) 
        {
            if ([apiData count]!=0) {
                l_apiexists = YES;
            }
        }
        if (flxData) {
            if ([flxData count]!=0) {
                l_flxexists = YES;
            }
        }
        if (l_flxexists==YES || l_apiexists==YES) 
        {
            METHODCALLBACK l_hideMethod = ^(NSDictionary* p_dictInfo)
            {
                [self hidePopover:p_dictInfo];
            };
            METHODCALLBACK l_appDoctSelcet = ^(NSDictionary* p_dictInfo)
            {
                [self approvalsDocSelected:p_dictInfo];
            };
            approvalsHeader *ahdr = [[approvalsHeader alloc] initWithApiAndFlxHeaderInfo:apiData andFlxData:flxData andHideMethod:l_hideMethod andAppDocSelectMethod:l_appDoctSelcet];
            popover = [[UIPopoverController alloc] initWithContentViewController:ahdr];
            [popover setPopoverContentSize:CGSizeMake(321, 480)];
            [popover presentPopoverFromBarButtonItem:menuButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            //[ahdr release];
        }
        else
            [self generateHeaderInformation];
    }    
}

- (IBAction) refreshClicked:(id) sender
{
    [actview startAnimating];
    headerinforeceived = 0;
    [self generateHeaderInformation];
    [menuButton setEnabled:NO];    
}

- (void) approvalsHeaderDataGenerated : (NSDictionary*) approvalsHeaderInfo
{
    //NSLog(@"received header information %@", [approvalsHeaderInfo userInfo]);
    NSString *l_divisioncode = [[approvalsHeaderInfo valueForKey:@"inputs"] valueForKey:@"p_divcode"] ;
    if ([l_divisioncode isEqualToString:@"API"]) 
    {
        if (apiData) 
        {
            [apiData removeAllObjects];
        }
        apiData = (NSMutableArray*) [approvalsHeaderInfo valueForKey:@"data"];
        //NSLog(@"api header info %@", apiData);
    }
    if ([l_divisioncode isEqualToString:@"FLX"]) 
    {
        if (flxData) 
        {
            [flxData removeAllObjects];
        }
        flxData = (NSMutableArray*) [approvalsHeaderInfo valueForKey:@"data"];
        //NSLog(@"flx header info %@", flxData);
    }
    [self setActivityIndicatorProperly];
}

- (void) generateHeaderInformation
{
    headerinforeceived=0;
    NSString *l_loggeduser =  [[NSString alloc] initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"loggeduser"]];
    
    NSDictionary *inputDict1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"API", @"p_divcode",@"0",@"p_module",l_loggeduser, @"p_usercode" , nil];
    METHODCALLBACK approvalsReturn = ^ (NSDictionary* p_dictInfo)
    {
        [self approvalsHeaderDataGenerated:p_dictInfo];
    };
    [[dssWSCallsProxy alloc] initWithReportType:@"APPROVALHEADER" andInputParams:inputDict1 andReturnMethod:approvalsReturn andReturnInputs:YES];
    
    NSDictionary *inputDict2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"FLX", @"p_divcode",@"0",@"p_module",l_loggeduser, @"p_usercode" , nil];
    [[dssWSCallsProxy alloc] initWithReportType:@"APPROVALHEADER" andInputParams:inputDict2 andReturnMethod:approvalsReturn andReturnInputs:YES];
    /*[[approvalsHeaderData alloc] initWithDivisionCode:@"API"];
    l_loggeduser = ; 
    l_divisioncode = p_divcode;
    [[approvalsHeaderData alloc] initWithDivisionCode:@"FLX"];*/
}

- (void) setActivityIndicatorProperly
{
    headerinforeceived++;
    if (headerinforeceived>=2) {
        [actview stopAnimating];
        actview.hidden=TRUE;
        [menuButton setEnabled:YES];
        //[self menuButtonClicked:nil];
    }
}

- (void)hidePopover:(NSDictionary *)notif {
    [self.popover dismissPopoverAnimated:YES];
}

- (void) approvalsDocSelected : (NSDictionary*) approvalsDocInfo
{
    NSString *divisionCode = [approvalsDocInfo valueForKey:@"divisioncode"];
    NSIndexPath *selectedItem = [approvalsDocInfo valueForKey:@"docselected"];
    int rowno = selectedItem.row;
    CGRect frame = self.view.frame;
    UIView *previousView = [self.view viewWithTag:555];
    if (previousView!=nil) [previousView removeFromSuperview];
    docApprovals *da = [[docApprovals alloc] initWithDivision:divisionCode andDictData:[divisionCode isEqualToString:@"API"]?[apiData objectAtIndex:rowno]:[flxData objectAtIndex:rowno] andFrame:frame andOrientation:currOrientation];
    da.tag = 555;
    [da.menuButtonItem setAction:@selector(menuButtonClicked:)];
    [da.refreshButtonItem setAction:@selector(refreshClicked:)];
    [nBar setHidden:YES];
    [self.view addSubview:da];
}

- (void)swipeLeft {
    NSLog(@"swipe left is done");
}

- (void)swipeRight {
    NSLog(@"swipe right is done");
}

@end
