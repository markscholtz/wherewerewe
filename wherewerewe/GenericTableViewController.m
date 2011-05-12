//
//  GenericTableViewController.m
//  MultiRowSelect
//
//  Created by Matt Gallagher on 27/12/08.
//  Copyright 2008 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "GenericTableViewController.h"
#import "MSMultiSelectTableViewCellControllerProtocol.h"

@implementation GenericTableViewController

//
// constructTableGroups
//
// Creates/updates cell data. This method should only be invoked directly if
// a "reloadData" needs to be avoided. Otherwise, updateAndReload should be used.
//
- (void)constructTableGroups
{
	tableGroups = [[NSArray arrayWithObject:[NSArray array]] retain];
}

//
// clearTableGroups
//
// Releases the table group data (it will be recreated when next needed)
//
- (void)clearTableGroups
{
	[tableGroups release];
	tableGroups = nil;
}

//
// updateAndReload
//
// Performs all work needed to refresh the data and the associated display
//
- (void)updateAndReload
{
	[self clearTableGroups];
	[self constructTableGroups];
	[self.tableView reloadData];
}

//
// numberOfSectionsInTableView:
//
// Return the number of sections for the table.
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (!tableGroups)
	{
		[self constructTableGroups];
	}
	
	return [tableGroups count];
}

//
// tableView:numberOfRowsInSection:
//
// Returns the number of rows in a given section.
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (!tableGroups)
	{
		[self constructTableGroups];
	}
	
	return [[tableGroups objectAtIndex:section] count];
}

//
// tableView:cellForRowAtIndexPath:
//
// Returns the cell for a given indexPath.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (!tableGroups)
	{
		[self constructTableGroups];
	}
	
	return
		[[[tableGroups objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]
			tableView:(UITableView *)tableView
			cellForRowAtIndexPath:indexPath];
}

//
// tableView:didSelectRowAtIndexPath:
//
// Handle row selection
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (!tableGroups)
	{
		[self constructTableGroups];
	}
	
	NSObject<MSMultiSelectTableViewCellControllerProtocol> *cellController =
		[[tableGroups objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	if ([cellController respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
	{
		[cellController tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
}

//
// indexPathForCellController:
//
// Returns the indexPath for the specified CellController object
//
- (NSIndexPath *)indexPathForCellController:(id)cellController
{
	NSInteger sectionIndex;
	NSInteger sectionCount = [tableGroups count];
	for (sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++)
	{
		NSArray *section = [tableGroups objectAtIndex:sectionIndex];
		NSInteger rowIndex;
		NSInteger rowCount = [section count];
		for (rowIndex = 0; rowIndex < rowCount; rowIndex++)
		{
			NSArray *row = [section objectAtIndex:rowIndex];
			if ([row isEqual:cellController])
			{
				return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
			}
		}
	}
	
	return nil;
}

//
// didReceiveMemoryWarning
//
// Release any cache data.
//
- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	
	[self clearTableGroups];
}
//
// dealloc
//
// Release instance memory
//
- (void)dealloc
{
	[self clearTableGroups];
	[super dealloc];
}

@end

