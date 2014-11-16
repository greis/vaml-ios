#import "Kiwi.h"
#import "VamlRenderer.h"
#import "VamlContext.h"

SPEC_BEGIN(VamlRendererSpec)

describe(@"#render", ^{
  
  let(view, ^id{ return [UIView new]; });
  let(vamlContext, ^id{ return [VamlContext new]; });
  let(vaml, ^id{ return nil; });
  let(locals, ^id{
    return @{@"foo": @(YES)};
  });
  
  let(render, ^id{
    return ^{
      [vamlContext setLocals:locals];
      VamlRenderer *renderer = [[VamlRenderer alloc] initWithView:view vaml:vaml context:vamlContext];
      [renderer render];
    };
  });
  
  context(@"conditions", ^{
    context(@"if statement", ^{
      context(@"true evaluation", ^{
        let(vaml, ^id{ return
          @"%root\n"
          " %label\n"
          " - if foo\n"
          "  %label";
        });
        
        it(@"renders the view inside the statement", ^{
          ((void(^)())render)();
          [[[view subviews] should] haveCountOf:2];
        });
      });
      
      context(@"false evaluation", ^{
        let(vaml, ^id{ return
          @"%root\n"
          " %label\n"
          " - if zzz\n"
          "  %label";
        });
        
        it(@"does not render the view inside the statement", ^{
          ((void(^)())render)();
          [[[view subviews] should] haveCountOf:1];
        });
      });
      
    });
    context(@"2 if statements", ^{
      let(vaml, ^id{ return
        @"%root\n"
        " %label\n"
        " - if foo\n"
        "  %label\n"
        " - if foo\n"
        "  %label";
      });
      
      it(@"renders the views inside the statements", ^{
        ((void(^)())render)();
        [[[view subviews] should] haveCountOf:3];
      });
    });
    context(@"elsif statement", ^{
      context(@"true evaluation", ^{
        let(vaml, ^id{ return
          @"%root\n"
          " %label\n"
          " - if zzz\n"
          "  %label\n"
          "  %label\n"
          " - elsif foo\n"
          "  %label";
        });
        
        it(@"renders the view inside the statement", ^{
          ((void(^)())render)();
          [[[view subviews] should] haveCountOf:2];
        });
      });
      
      context(@"false evaluation", ^{
        let(vaml, ^id{ return
          @"%root\n"
          " %label\n"
          " - if zzz\n"
          "  %label\n"
          "  %label\n"
          " - elsif xxx\n"
          "  %label";
        });
        
        it(@"does not render the view inside the statement", ^{
          ((void(^)())render)();
          [[[view subviews] should] haveCountOf:1];
        });
      });
    });
    context(@"else statement", ^{
      let(vaml, ^id{ return
        @"%root\n"
        " %label\n"
        " - if xxx\n"
        "  %label\n"
        "  %label\n"
        " - elsif zzz\n"
        "  %label\n"
        "  %label\n"
        " - else\n"
        "  %label";
      });
      
      it(@"renders the view inside the statement", ^{
        ((void(^)())render)();
        [[[view subviews] should] haveCountOf:2];
      });
    });
  });
});

SPEC_END