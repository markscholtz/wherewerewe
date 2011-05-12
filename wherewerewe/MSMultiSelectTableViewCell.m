//
//  MSMultiSelectTableViewCell.m
//  wherewerewe
//
//  Created by Mark on 2011/05/08.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "MSMultiSelectTableViewCell.h"


const NSInteger EDITING_HORIZONTAL_OFFSET = 35;


@implementation MSMultiSelectTableViewCell


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    /*****************************************************************************************************/
    // Refreshed the layout when editing is enabled/disabled.
    /*****************************************************************************************************/
    
	[self setNeedsLayout];
}


- (void)layoutSubviews
{
    /*****************************************************************************************************/
    // When editing, displace everything rightwards to allow space for the selection indicator.
    /*****************************************************************************************************/
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
	[super layoutSubviews];
    
	if (((UITableView *)self.superview).isEditing)
	{
		CGRect contentFrame = self.contentView.frame;
		contentFrame.origin.x = EDITING_HORIZONTAL_OFFSET;
		self.contentView.frame = contentFrame;
	}
	else
	{
		CGRect contentFrame = self.contentView.frame;
		contentFrame.origin.x = 0;
		self.contentView.frame = contentFrame;
	}
    
	[UIView commitAnimations];
}


- (void)dealloc
{
    [super dealloc];
}


@end
