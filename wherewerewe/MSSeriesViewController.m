//
//  MSFindSeriesViewController.m
//  wherewerewe
//
//  Created by Mark on 2011/04/29.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import "MSSeriesViewController.h"


@implementation MSSeriesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"-----------> init");
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//---------------------------------------------------------------------------------------------------//




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self->sections = [[NSMutableArray alloc] initWithObjects:@"Ant", @"Ball", @"Cat", @"Dog", @"Egg", @"Frog", @"Goat", @"High", @"Inca", nil];    
    self->rows = [[NSMutableArray alloc] initWithObjects:@"one", @"two", @"three", nil];   
    
    
    self->actionToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 416, 320, 44)];
    UIBarButtonItem* actionToolbarButton = [[[UIBarButtonItem alloc] initWithTitle:@"No Action"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(noAction:)] autorelease];
    [self->actionToolbar setItems:[NSArray arrayWithObject:actionToolbarButton]];

    
	[self.tableView setAllowsSelectionDuringEditing:YES];
    
	// Set the state for not editing.
	[self cancel:self];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[[self view] superview] addSubview:self->actionToolbar];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self->actionToolbar removeFromSuperview];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//---------------------------------------------------------------------------------------------------//




#pragma mark - MSMultiSelectTableViewController Protocol Methods

- (void)updateSelectionCount
{
    /*****************************************************************************************************/
    // Updates the selection count button when selection changes.
    /*****************************************************************************************************/

	NSInteger count = 0;
	
	for (MSMultiSelectTableViewCellController *cellController in [tableGroups objectAtIndex:0])
	{
		if ([cellController selected])
		{
			count++;
		}
	}
	
	actionButton.title = [NSString stringWithFormat:@"No action (%ld)", count];
	actionButton.enabled = (count != 0);
}


- (void)noAction:(id)sender
{
    /*****************************************************************************************************/
    // Clears the selection but otherwise does nothing.
    /*****************************************************************************************************/

	NSInteger row = 0;
	for (MSMultiSelectTableViewCellController *cellController in [tableGroups objectAtIndex:0])
	{
		[cellController clearSelectionForTableView:self.tableView
                                         indexPath:[NSIndexPath indexPathForRow:row inSection:0]];
		row++;
	}
}

//---------------------------------------------------------------------------------------------------//



#pragma mark - Table view editing

- (void)edit:(id)sender
{
    [self showActionToolbar:YES];
    
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(cancel:)] autorelease];
    [self.navigationItem setRightBarButtonItem:cancelButton animated:NO];
    [self updateSelectionCount];
    
    [self.tableView setEditing:YES animated:YES];
}


- (void)cancel:(id)sender
{
    [self showActionToolbar:NO];
    
    UIBarButtonItem *editButton = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(edit:)] autorelease];
    [self.navigationItem setRightBarButtonItem:editButton animated:NO];
    
    NSInteger row = 0;
    for (MSMultiSelectTableViewCellController *cellController in [tableGroups objectAtIndex:0])
    {
        [cellController clearSelectionForTableView:self.tableView
                                         indexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        row++;
    }
    
    [self.tableView setEditing:NO animated:YES];
}


- (void)showActionToolbar:(BOOL)show
{
    /*****************************************************************************************************/
    // Toggles the "action" toolbar
    /*****************************************************************************************************/
	CGRect toolbarFrame = actionToolbar.frame;
	CGRect tableViewFrame = self.tableView.frame;
	if (show)
	{
		toolbarFrame.origin.y = actionToolbar.superview.frame.size.height - toolbarFrame.size.height;
		tableViewFrame.size.height -= toolbarFrame.size.height;
	}
	else
	{
		toolbarFrame.origin.y = actionToolbar.superview.frame.size.height;
		tableViewFrame.size.height += toolbarFrame.size.height;
	}
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
	actionToolbar.frame = toolbarFrame;
	self.tableView.frame = tableViewFrame;
	
	[UIView commitAnimations];
}

//---------------------------------------------------------------------------------------------------//



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self->sections count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self->rows count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [[cell textLabel] setText:[self->rows objectAtIndex:[indexPath row]]];    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self->sections objectAtIndex:section];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self->sections;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*****************************************************************************************************/
    // Specifies editing enabled for all rows.
    /*****************************************************************************************************/

    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//---------------------------------------------------------------------------------------------------//




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-------------> %@", [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]);
    
    // Navigation logic may go here. Create and push another view controller.
    MSSeasonsViewController* seasonsVC = [[MSSeasonsViewController alloc] initWithStyle:UITableViewStylePlain];
    NSString* nextControllerTitle = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    [seasonsVC setTitle:nextControllerTitle];
    
    // Pass the selected object to the new view controller.
    [[self navigationController] pushViewController:seasonsVC animated:YES];
    [seasonsVC release];
}

@end
