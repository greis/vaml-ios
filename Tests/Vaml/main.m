//
//  main.m
//  Vaml
//
//  Created by Gabriel Reis on 2/28/14.
//  Copyright (c) 2014 Gabriel Reis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PixateFreestyle/PixateFreestyle.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
  @autoreleasepool {
    [PixateFreestyle initializePixateFreestyle];
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
