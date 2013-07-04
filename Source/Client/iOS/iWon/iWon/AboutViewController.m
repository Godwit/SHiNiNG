//
//  AboutViewController.m
//  iWon
//
//  Created by 高 大伟 on 13-7-4.
//  Copyright (c) 2013年 com.oneshining. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController
@synthesize webView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURL * url = [NSURL URLWithString:@"http://www.iucai.com/aboutme/"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
