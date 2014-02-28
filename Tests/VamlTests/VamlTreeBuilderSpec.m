#import "Kiwi.h"
#import "VamlTreeBuilder.h"

SPEC_BEGIN(VamlTreeBuilderSpec)

describe(@"#build", ^{
  let(tokens, ^{ return @""; });
  let(builder, ^{ return [[VamlTreeBuilder alloc] initWithTokens:tokens]; });
  
  
  context(@"one child", ^{
    let(tokens, ^{
      return @[
               @{@"tag": @"root"},
               @{@"tag": @"label",
                 @"indentation": @"\t",
                 @"id": @"xyz",
                 @"classes": @[@"class",@"clazz"],
                 @"attrs": @{@"value": @"abc"}}
               ];
    });
    specify(^{
      [[[builder build] should] equal:@{
                                        @"tag": @"root",
                                        @"children": @[
                                            @{
                                              @"tag": @"label",
                                              @"id": @"xyz",
                                              @"indentation": @"\t",
                                              @"classes": @[@"class",@"clazz"],
                                              @"attrs": @{@"value" : @"abc"}
                                              }
                                            ]
                                        }];
    });
  });
  
  context(@"nested children", ^{
    let(tokens, ^{
      return @[
               @{@"tag": @"root"},
               @{@"tag": @"view", @"indentation": @"\t"},
               @{@"tag": @"label", @"indentation": @"\t\t"},
               @{@"tag": @"custom", @"indentation": @"\t\t\t"},
               @{@"tag": @"button", @"indentation": @"\t"},
               @{@"tag": @"scroll", @"indentation": @"\t"}
               ];
    });
    specify(^{
      [[[builder build] should] equal:@{
                                        @"tag": @"root",
                                        @"children": @[
                                            @{@"tag": @"view", @"indentation": @"\t",
                                              @"children": @[
                                                  @{@"tag": @"label", @"indentation": @"\t\t",
                                                    @"children": @[
                                                        @{@"tag": @"custom", @"indentation": @"\t\t\t"}
                                                        ]}
                                                  ]
                                              },
                                            @{@"tag": @"button", @"indentation": @"\t"},
                                            @{@"tag": @"scroll", @"indentation": @"\t"}
                                            ]
                                        }];
    });
  });
});

SPEC_END