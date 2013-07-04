//
//  DealDetailViewController.m
//  iWon
//
//  Created by 高 大伟 on 13-7-4.
//  Copyright (c) 2013年 com.oneshining. All rights reserved.
//

#import "DealDetailViewController.h"

@interface DealDetailViewController ()

@end

@implementation DealDetailViewController
@synthesize dealLabel;
@synthesize dealName;

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
    // Set the Label text with the selected deal
    dealLabel.text = dealName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
