//
//  MSMultiSelectTableViewCellController.m
//  wherewerewe
//
//  Created by Mark on 2011/05/09.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "MSMultiSelectTableViewCellController.h"


const NSInteger SELECTION_INDICATOR_TAG = 54321;
const NSInteger TEXT_LABEL_TAG = 54322;


@implementation MSMultiSelectTableViewCellController


- (id)initWithLabel:(NSString *)newLabel
{
    /*****************************************************************************************************/
    // Init method for the object.
    /*****************************************************************************************************/

	self = [super init];
	if (self != nil)
	{
		self->label = [newLabel retain];
	}
	return self;
}


- (BOOL)selected
{
    /*****************************************************************************************************/
    // Accessor for the selection
    /*****************************************************************************************************/

	return selected;
}


- (void)clearSelectionForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    /*****************************************************************************************************/
    // Clears the selection for the given table
    /*****************************************************************************************************/

	if (self->selected)
	{
		[self tableView:tableView didSelectRowAtIndexPath:indexPath];
		self->selected = NO;
	}
}

//---------------------------------------------------------------------------------------------------//



#pragma mark - MSMultiSelectTableViewCellController Protocol Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*****************************************************************************************************/
    // Marks the current row if editing is enabled.
    /*****************************************************************************************************/

	if (tableView.isEditing)
	{
		self->selected = !self->selected;
		
		[(UITableViewController <MSMultiSelectTableViewControllerProtocol>*)[tableView delegate] updateSelectionCount];
		
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:
                                 [(GenericTableViewController*)[tableView delegate] 
                                  indexPathForCellController:self]];
		
		if (!cell)
		{
			//
			// This path will be taken if the row is not visible
			//
			return;
		}
		
		UIImageView *indicator = (UIImageView *)[cell.contentView viewWithTag:SELECTION_INDICATOR_TAG];
		if (self->selected)
		{
			indicator.image = [UIImage imageNamed:@"IsSelected.png"];
			cell.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
		}
		else
		{
			indicator.image = [UIImage imageNamed:@"NotSelected.png"];
			cell.backgroundView.backgroundColor = [UIColor whiteColor];
		}
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*****************************************************************************************************/
    // Constructs and configures the MultiSelectTableViewCell for this row.
    /*****************************************************************************************************/
    
	static NSString *cellIdentifier = @"MultiSelectCellController";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	UIImageView *indicator;
	UILabel *textLabel;
    
	if (!cell)
	{
        cell = [[[MSMultiSelectTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, tableView.rowHeight)
                                                reuseIdentifier:cellIdentifier] autorelease];
		
		
		indicator = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotSelected.png"]] autorelease];
		
		const NSInteger IMAGE_SIZE = 30;
		const NSInteger SIDE_PADDING = 5;
		
		indicator.tag = SELECTION_INDICATOR_TAG;
		indicator.frame =
        CGRectMake(-EDITING_HORIZONTAL_OFFSET + SIDE_PADDING, (0.5 * tableView.rowHeight) - (0.5 * IMAGE_SIZE), IMAGE_SIZE, IMAGE_SIZE);
		[cell.contentView addSubview:indicator];
		
		textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(SIDE_PADDING, 0, 320, tableView.rowHeight)] autorelease];
		textLabel.tag = TEXT_LABEL_TAG;
		textLabel.textColor = [UIColor blackColor];
		textLabel.backgroundColor = [UIColor clearColor];
		textLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
		[cell.contentView addSubview:textLabel];
        
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.backgroundView = [[[UIView alloc] init] autorelease];
	}
	else
	{
		indicator = (UIImageView *)[cell.contentView viewWithTag:SELECTION_INDICATOR_TAG];
		textLabel = (UILabel *)[cell.contentView viewWithTag:TEXT_LABEL_TAG];
	}
	
	textLabel.text = label;
	
	if (selected)
	{
		indicator.image = [UIImage imageNamed:@"IsSelected.png"];
		cell.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
	}
	else
	{
		indicator.image = [UIImage imageNamed:@"NotSelected.png"];
		cell.backgroundView.backgroundColor = [UIColor whiteColor];
	}
	
	return cell;
}

//---------------------------------------------------------------------------------------------------//



#pragma mark - Memory Management

- (void)dealloc
{
    /*****************************************************************************************************/
    // Releases instance memory.
    /*****************************************************************************************************/

	[label release];
    
	[super dealloc];
}


@end
