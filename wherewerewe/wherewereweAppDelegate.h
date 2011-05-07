//
//  wherewereweAppDelegate.h
//  wherewerewe
//
//  Created by Mark on 2011/04/28.
//  Copyright 2011 Unboxed Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wherewereweAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
    IBOutlet UINavigationController* findNavigationController;
    IBOutlet UINavigationController* watchNavigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
