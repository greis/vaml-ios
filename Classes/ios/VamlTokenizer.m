#import "VamlTokenizer.h"
#import "VamlAttributesParser.h"

enum TokenType {
  INDENTATION,
  TAG,
  CLASS,
  ID,
  ATTRS
  } INVALID;

@interface VamlTokenizer ()
@property(nonatomic) NSString* content;
@end

@implementation VamlTokenizer

-(id)initWithContent:(NSString *)content {
  self = [super init];
  if (self) {
    [self setContent:content];
  }
  return self;
}

-(id)initWithFileName:(NSString *)fileName extension:(NSString *)extension {
  NSString* fileRoot = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
  NSString* fileContent = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:nil];
  return [self initWithContent:fileContent];
}

-(NSArray *)tokenize {
  NSArray* lines = [self.content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
  
  NSMutableArray *result = [NSMutableArray array];
  for (NSString *line in lines) {
    if ([line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0) {
      NSDictionary *tokens = [self tokenizeLine:line];
      [result addObject:tokens];
    }
  }
  
  return result;
}

-(NSDictionary *)tokenizeLine:(NSString *)line {
  NSMutableDictionary *tokens = [NSMutableDictionary dictionary];
  
  int lastIndex = line.length - 1;
  int tokenType = [self tokenTypeByChar:[line characterAtIndex:0]];
  int currentIndex = 1;
  int tokenStart = 0;
  int tokenEnd = 0;
  
  while (currentIndex <= lastIndex) {
    char currentChar = [line characterAtIndex:currentIndex];
    
    switch (tokenType) {
      case INDENTATION:
        if (currentChar != ' ') tokenEnd = currentIndex;
        break;
      case TAG:
        if (currentChar < 'a' || currentChar > 'z') tokenEnd = currentIndex;
        break;
      case CLASS:
      case ID:
        if (!((currentChar >= 'a' && currentChar <= 'z') || currentChar == '_')) tokenEnd = currentIndex;
        break;
      case ATTRS:
        if (currentChar == '}' || currentChar == ')') {
          currentIndex++; //increment index to capture '}'
          tokenEnd = currentIndex;
        }
        break;
      default:
        break;
    }
    
    if (tokenEnd == currentIndex) {
      [self addTokenFromRange:NSMakeRange(tokenStart, currentIndex - tokenStart) tokenType:tokenType line:line tokens:tokens];
      
      if (currentIndex <= lastIndex) { //need to check index because ATTRS capture increments currentIndex
        tokenType = [self tokenTypeByChar:[line characterAtIndex:currentIndex]];
        tokenStart = currentIndex;
      }
    }
    
    currentIndex++;
    
  }
  
  if (tokenEnd < line.length) {
    tokenEnd = line.length;
    [self addTokenFromRange:NSMakeRange(tokenStart, tokenEnd - tokenStart) tokenType:tokenType line:line tokens:tokens];
  }
  
  return tokens;
}

-(void)addTokenFromRange:(NSRange)range tokenType:(int)tokenType line:(NSString *)line tokens:(NSMutableDictionary *)tokens {
  switch (tokenType) {
    case INDENTATION:
      tokens[@"indentation"] = [line substringWithRange:range];
      break;
    case TAG:
      tokens[@"tag"] = [line substringWithRange:NSMakeRange(range.location + 1, range.length - 1)];
      break;
    case CLASS: {
      NSMutableArray *classes;
      if (tokens[@"classes"]) {
        classes = tokens[@"classes"];
      } else {
        classes = [NSMutableArray array];
        tokens[@"classes"] = classes;
      }
      [classes addObject:[line substringWithRange:NSMakeRange(range.location + 1, range.length - 1)]];
      break;
    }
    case ID:
      tokens[@"id"] = [line substringWithRange:NSMakeRange(range.location + 1, range.length - 1)];
      break;
    case ATTRS: {
      VamlAttributesParser *attrParser = [[VamlAttributesParser alloc] initWithString:[line substringWithRange:range]];
      tokens[@"attrs"] = [attrParser parseString];
      break;
    }
  }
}

-(int)tokenTypeByChar:(char)character {
  switch (character) {
    case '%':
      return TAG;
    case ' ':
    case '\t':
      return INDENTATION;
    case '.':
      return CLASS;
    case '#':
      return ID;
    case '{':
    case '(':
      return ATTRS;
    default:
      return INVALID;
  }
}

@end
