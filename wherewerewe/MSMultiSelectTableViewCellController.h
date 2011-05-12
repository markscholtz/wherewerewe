//
//  MSMultiSelectTableViewCellController.h
//  wherewerewe
//
//  Created by Mark on 2011/05/09.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSMultiSelectTableViewControllerProtocol.h"
#import "MSMultiSelectTableViewCellControllerProtocol.h"
#import "MSMultiSelectTableViewCell.h"
#import "GenericTableViewController.h"


@interface MSMultiSelectTableViewCellController : NSObject <MSMultiSelectTableViewCellControllerProtocol>
{
	NSString *label;
	BOOL selected;
}


- (id)initWithLabel:(NSString *)newLabel;
- (void)clearSelectionForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
- (BOOL)selected;


@end
