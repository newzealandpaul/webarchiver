#import <Foundation/Foundation.h>


// Category on NSURL to check whether an HTTP URL is valid - thanks to whoever posted it on CocoaDev
// (http://www.cocoadev.com/index.pl?FileExistsAtURL)
@interface NSURL (ValidityChecking)
- (BOOL)httpIsValid;
@end
