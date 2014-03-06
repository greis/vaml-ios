//
//  HamlViews.m
//  HamlViews
//
//  Created by Gabriel Reis on 2/21/14.
//  Copyright (c) 2014 Gabriel Reis. All rights reserved.
//

#import "Vaml.h"
#import <PixateFreestyle/PixateFreestyle.h>
#import "VamlHorizontalLayout.h"
#import "VamlVerticalLayout.h"
#import "VamlTokenizer.h"
#import "VamlTreeBuilder.h"
#import "UIView+Vaml.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation Vaml

+(void)layout:(NSString *)layout view:(UIView *)view {
  VamlTokenizer *tokenizer = [[VamlTokenizer alloc] initWithFileName:layout extension:@"vaml"];
  NSArray *tokens = [tokenizer tokenize];
  VamlTreeBuilder *treeBuilder = [[VamlTreeBuilder alloc] initWithTokens:tokens];
  NSDictionary *tree = [treeBuilder build];
  [self addChildren:tree[@"children"] to:view];
}

+(void)addChildren:(NSArray *)children to:(UIView *)view {
  for (NSDictionary *child in children) {
    UIView *subview = [self viewFromData:child];
    [view addSubview:subview];
    if (child[@"children"]) {
      [self addChildren:child[@"children"] to:subview];
    }
  }
  SEL selector = NSSelectorFromString(@"didAddAllSubviews");
  if ([view respondsToSelector:selector]) {
    [view performSelector:selector];
  }
}

+(UIView *)viewFromData:(NSDictionary *)data {
  //TODO create factory class
  NSString *tag = data[@"tag"];
  UIView *view;
  if ([tag isEqualToString:@"label"]) {
    UILabel *label = [[UILabel alloc] init];
    [label setText:data[@"attrs"][@"text"]];
    view = label;
  } else if ([tag isEqualToString:@"textfield"]) {
    UITextField *textField = [[UITextField alloc] init];
    view = textField;
  } else if ([tag isEqualToString:@"button"]) {
    UIButton *button = [[UIButton alloc] init];
    view = button;
  } else if ([tag isEqualToString:@"horizontal"]) {
    VamlHorizontalLayout *layout = [[VamlHorizontalLayout alloc] init];
    view = layout;
  } else if ([tag isEqualToString:@"vertical"]) {
    VamlVerticalLayout *layout = [[VamlVerticalLayout alloc] init];
    view = layout;
  } else {
    view = [[UIView alloc] init];
    NSLog(@"tag not implemented: %@", tag);
  }
  
  [view setVamlData:data];
  [view setStyleId:data[@"id"]];
  [view setStyleClass:[data[@"classes"] componentsJoinedByString:@" "]];
  return view;
}

@end
