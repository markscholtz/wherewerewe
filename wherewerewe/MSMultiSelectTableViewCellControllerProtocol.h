//
//  MSMultiSelectTableViewCellControllerProtocol.h
//  wherewerewe
//
//  Created by Mark on 2011/05/09.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//


@protocol MSMultiSelectTableViewCellControllerProtocol

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
