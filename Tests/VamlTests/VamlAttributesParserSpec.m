#import "Kiwi.h"
#import "VamlAttributesParser.h"

SPEC_BEGIN(VamlAttributesParserSpec)

describe(@"parse", ^{
  let(expression, ^{ return @""; });
  let(parser, ^{
    return [[VamlAttributesParser alloc] initWithString:expression];
  });
  
  context(@"brackets", ^{
    context(@"single attribute with single quotes", ^{
      let(expression, ^{ return @"{value: 'abc'}"; });
      
      specify(^{
        [[[parser parseString] should] equal:@{@"value": @"abc"}];
      });
      
      context(@"double quote inside single quotes", ^{
        let(expression, ^{ return @"{value: 'abc\"s'}"; });
        specify(^{
          [[[parser parseString] should] equal:@{@"value": @"abc\"s"}];
        });
      });
    });
    context(@"single attribute with double quotes", ^{
      let(expression, ^{ return @"{value: \"abc\"}"; });
      
      specify(^{
        [[[parser parseString] should] equal:@{@"value": @"abc"}];
      });
      
      context(@"single quote inside double quotes", ^{
        let(expression, ^{ return @"{value: \"abc's\"}"; });
        specify(^{
          [[[parser parseString] should] equal:@{@"value": @"abc's"}];
        });
      });
    });
    context(@"multiple attributes", ^{
      let(expression, ^{ return @"{value:'abc', display:'yes', name: \"xyz\"}"; });
      
      specify(^{
        [[[parser parseString] should] equal:@{@"value": @"abc", @"display": @"yes", @"name": @"xyz"}];
      });
    });
  });
  
  context(@"parentheses", ^{
    context(@"single attribute with single quotes", ^{
      let(expression, ^{ return @"(value='abc')"; });
      
      specify(^{
        [[[parser parseString] should] equal:@{@"value": @"abc"}];
      });
    });
    context(@"single attribute with double quotes", ^{
      let(expression, ^{ return @"(value=\"abc\")"; });
      
      specify(^{
        [[[parser parseString] should] equal:@{@"value": @"abc"}];
      });
    });
    context(@"multiple attributes", ^{
      let(expression, ^{ return @"(value='abc' display='yes' name=\"xyz\")"; });
      
      specify(^{
        [[[parser parseString] should] equal:@{@"value": @"abc", @"display": @"yes", @"name": @"xyz"}];
      });
    });
  });
});

SPEC_END