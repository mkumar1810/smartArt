//
//  signIn.m
//  dssapi
//
//  Created by Raja T S Sekhar on 2/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "signIn.h"


@implementation signIn

- (id) init //WithReloginMethod:(METHODCALLBACK) p_reloginMethod
{
    self = [super init];
    if (self) {
        CGRect myframe = [self.view bounds];
        //_reloginMethod = p_reloginMethod;
        __block id myself = self;
        METHODCALLBACK loginReturn = ^ (NSDictionary* p_dictInfo)
        {
            [myself loginSuccessful:p_dictInfo];
        };
        signLogin = [[login alloc] initWithFrame:myframe andReturnMethod:loginReturn];
        /*if ([p_notifyName isEqualToString:@"loginSuccessful"]==YES) 
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessful:) name:@"loginSuccessful" object:nil];*/
        [self.view addSubview:signLogin];
        //[signLogin setForOrientation:self.interfaceOrientation];
        // Custom initialization
    }
    return  self;
}

- (void)dealloc
{
    //[signLogin release];
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    //[[NSNotificationCenter defaultCenter] removexObserver:self];
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
    //[signLogin setFrame:self.view.frame];
    [signLogin setForOrientation:toInterfaceOrientation];
}

- (void) loginSuccessful : (NSDictionary*) signInfo
{
    NSDictionary *returnedDict =  [[signInfo valueForKey:@"data"] objectAtIndex:0];
    NSString *respCode = [returnedDict valueForKey:@"RESPONSECODE"];
    NSString *respMsg = [returnedDict valueForKey:@"RESPONSEMESSAGE"];
    if ([respCode isEqualToString:@"0"]) {
        NSString *loginuser = [returnedDict valueForKey:@"LOGGEDUSER"];
        NSUserDefaults *standardUserDefaults=[NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:[loginuser uppercaseString] forKey:@"loggeduser"];    
        //[[self.view viewWithTag:1001] removeFromSuperview];
        [signLogin resetValues];
        METHODCALLBACK l_rlSetOrientation = ^(NSDictionary* p_dictInfo)
        {
            [self setOrientationProperly:p_dictInfo];
        };
        mainController *mainCtrl=[[mainController alloc]initWithNibName:@"mainController" bundle:nil withReLoginSetOrientationMethod:l_rlSetOrientation];
        [self.navigationController pushViewController:mainCtrl animated:YES];
    }
    else
        [self showAlertMessage:respMsg];
}

- (void) showAlertMessage:(NSString *) dispMessage
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:dispMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    //[alert release];
}

- (void) setOrientationProperly:(NSDictionary*) p_dictInfo
{
    [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:0.0];
}

@end
