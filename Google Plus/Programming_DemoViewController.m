//
//  Programming_DemoViewController.m
//  Google Plus
//
//  Created by Sam on 25/05/15.
//  Copyright (c) 2015 Bets. All rights reserved.
//

#import "Programming_DemoViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "Programming_DemoAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface Programming_DemoViewController ()

@end

@implementation Programming_DemoViewController
@synthesize signInButton;
@synthesize signIn;
@synthesize logout;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    static NSString * const kClientId = @"805395638713-ceg7a14555mjaia8sdig7u1k8j6busch.apps.googleusercontent.com";

    Programming_DemoAppDelegate *appDelegate = (Programming_DemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    
    

    //signIn.shouldFetchGoogleUserID=YES;
    //signIn.shouldFetchGoogleUserEmail=YES;

    //signIn.delegate = self;
    
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
                                   
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
    GTLQueryPlus *query =[GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
     
                         
                          
                          [plusService executeQuery:query
                                  completionHandler:^(GTLServiceTicket *ticket,
                                                      GTLPlusPerson *person,
                                                      NSError *error) {
                                      if (error) {
                                          GTMLoggerError(@"Error: %@", error);
                                      } else {
                                          // Retrieve the display name and "about me" text
                                          //[person retain];
                                          NSString *description = [NSString stringWithFormat:
                                                                   @"%@\n%@", person.displayName,
                                                                   person.aboutMe];
                                          NSLog(@" description=%@,%@",person.displayName,
                                                person.aboutMe);
                                      }
                                  }];


  signIn.delegate = self;


    
    
   //[signIn signOut];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        //[self refreshInterfaceBasedOnSignIn];
        // Get the email address.
        NSLog(@"Received Access Token:%@",auth);
        NSLog(@"user google user id  %@",signIn.authentication.userEmail);
      

    }

}

-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        self.signInButton.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        self.signInButton.hidden = NO;
        // Perform other actions here
    }
}

-(IBAction)logout:(id)sender {
    [[GPPSignIn sharedInstance] signOut];
}




@end
