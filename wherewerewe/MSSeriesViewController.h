//
//  MSFindSeriesViewController.h
//  wherewerewe
//
//  Created by Mark on 2011/04/29.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSeasonsViewController.h"
#import "MSMultiSelectTableViewCellController.h"
#import "MSMultiSelectTableViewControllerProtocol.h"
#import "GenericTableViewController.h"


@interface MSSeriesViewController : GenericTableViewController <MSMultiSelectTableViewControllerProtocol>
{
    UIToolbar* actionToolbar;
    UIBarButtonItem *actionButton;
    NSMutableArray* sections;
    NSMutableArray* rows;
}


- (void)edit:(id)sender;
- (void)cancel:(id)sender;
- (void)showActionToolbar:(BOOL)show;


@end
