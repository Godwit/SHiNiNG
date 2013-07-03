//
//  iWonViewController.m
//  iWon
//
//  Created by 高 大伟 on 13-7-2.
//  Copyright (c) 2013年 com.oneshining. All rights reserved.
//

#import "iWonViewController.h"

@interface iWonViewController ()

@end

@implementation iWonViewController{
    NSArray * dealList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dealList = [ NSArray arrayWithObjects:@"Egg Benedict",
                @"Mushroom Risotto",
                @"Full Breakfast",
                nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 通知表是图有多少行
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dealList count];
}

/// 填充单元格数据
-(UITableViewCell*) tableView:(UITableView*)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * simpleTableIdentifier = @"DealCell";
    UITableViewCell * cell = [ tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if ( nil == cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [ dealList objectAtIndex:indexPath.row];
    return cell;
}

@end
