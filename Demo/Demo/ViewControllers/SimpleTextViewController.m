//
//  SimpleTextViewController.m
//
//  Created by Constantine Mureev on 16.02.12.
//  Copyright (c) 2012 Team Force LLC. All rights reserved.
//

#import "SimpleTextViewController.h"
#import "CMHTMLView.h"


@implementation SimpleTextViewController


- (void)viewDidLoad {
    [super viewDidLoad];    
    CMHTMLView* htmlView = [[[CMHTMLView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height/2)] autorelease];
    htmlView.backgroundColor = [UIColor whiteColor];
    htmlView.meta = nil;
    htmlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Simple" ofType:@"html"];  
    NSData* htmlData = [NSData dataWithContentsOfFile:filePath];
    NSString* htmlString = [[[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding] autorelease];
    
    htmlView.alpha = 0;
    
    htmlView.urlClick = ^(NSString* url) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"URL Click" message:url delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
    };
    
    htmlView.imageClick = ^(NSString* url) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Click" message:url delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [alert release];
    };
    
    [htmlView loadHtmlBody:htmlString competition:^(NSError *error) {
        if (!error) {
            [UIView animateWithDuration:0.2 animations:^{
                htmlView.alpha = 1;
            }];
        }
    }];
    
    [self.view addSubview:htmlView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end