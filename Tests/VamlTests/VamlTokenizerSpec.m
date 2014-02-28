#import "Kiwi.h"
#import "VamlTokenizer.h"

SPEC_BEGIN(VamlTokenizerSpec)

describe(@"#tokenize", ^{
  let(content, ^{ return @""; });
  let(tokenizer, ^{ return [[VamlTokenizer alloc] initWithContent:content]; });
  
  context(@"tag", ^{
    let(content, ^{ return @"%root"; });
    
    specify(^{
      [[[tokenizer tokenize] should] equal:@[@{
                                               @"tag": @"root"
                                               }]];
    });
  });
  
  context(@"tag with id", ^{
    let(content, ^{ return @"%label#username"; });
    
    specify(^{
      [[[tokenizer tokenize] should] equal:@[@{
                                               @"tag": @"label",
                                               @"id": @"username"
                                               }]];
    });
  });
  
  context(@"only id", ^{
    let(content, ^{ return @"#username"; });
    
    specify(^{
      [[[tokenizer tokenize] should] equal:@[@{
                                               @"id": @"username"
                                               }]];
    });
  });
  
  context(@"tag with single class", ^{
    let(content, ^{ return @"%label.clazz"; });
    
    specify(^{
      [[[tokenizer tokenize] should] equal:@[@{
                                               @"tag": @"label",
                                               @"classes": @[@"clazz"]
                                               }]];
    });
  });
  
  context(@"tag with multiple classes", ^{
    let(content, ^{ return @"%label.clazz.class"; });
    
    specify(^{
      [[[tokenizer tokenize] should] equal:@[@{
                                               @"tag": @"label",
                                               @"classes": @[@"clazz",@"class"]
                                               }]];
    });
  });
  
  context(@"only class", ^{
    let(content, ^{ return @".clazz"; });
    
    specify(^{
      [[[tokenizer tokenize] should] equal:@[@{
                                               @"classes": @[@"clazz"]
                                               }]];
    });
  });
  
  context(@"tag with attributes", ^{
    context(@"with parentheses", ^{
      let(content, ^{ return @"%label(value = 'attr1')"; });
      
      specify(^{
        [[[tokenizer tokenize] should] equal:@[@{
                                                 @"tag": @"label",
                                                 @"attrs": @{@"value": @"attr1"}
                                                 }]];
      });
    });
    context(@"with brackets", ^{
      let(content, ^{ return @"%label{value: 'attr1'}"; });
      
      specify(^{
        [[[tokenizer tokenize] should] equal:@[@{
                                                 @"tag": @"label",
                                                 @"attrs": @{@"value": @"attr1"}
                                                 }]];
      });
    });
  });
  
  context(@"indentation", ^{
    context(@"with spaces", ^{
      let(content, ^{ return @"%root\n  %label"; });
      
      specify(^{
        [[[tokenizer tokenize] should] equal:@[
                                               @{@"tag": @"root"},
                                               @{@"tag": @"label", @"indentation": @"  "}
                                               ]];
      });
    });
    context(@"with tabs", ^{
      let(content, ^{ return @"%root\n\t%label"; });
      
      specify(^{
        [[[tokenizer tokenize] should] equal:@[
                                               @{@"tag": @"root"},
                                               @{@"tag": @"label", @"indentation": @"\t"}
                                               ]];
      });
    });
  });
  
  
  
});

SPEC_END
