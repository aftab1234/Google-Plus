//
//  Programming_DemoViewController.h
//  Google Plus
//
//  Created by Sam on 25/05/15.
//  Copyright (c) 2015 Bets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

@class GPPSignInButton;
@class GTLServicePlus;


@interface Programming_DemoViewController : UIViewController<GPPSignInDelegate>

    


@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;

@property (retain, nonatomic) IBOutlet  GPPSignIn *signIn;

@property (retain, nonatomic) IBOutlet  UIButton *logout;
-(IBAction)logout:(id)sender;


@end
