//
//  AppDelegate.h
//  123456
//
//  Created by 杨利 on 17/3/7.
//  Copyright © 2017年 吴明伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

