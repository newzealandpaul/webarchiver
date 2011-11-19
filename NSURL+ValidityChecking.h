//
//  NSURL_ValidityChecking.h
//  Scrivener
//
//  Created by Keith Blount on 19/08/2007.
//
// Category on NSURL to check whether an HTTP URL is valid - thanks to whoever posted it on CocoaDev
// (http://www.cocoadev.com/index.pl?FileExistsAtURL)

#import <Foundation/Foundation.h>


@interface NSURL (ValidityChecking)
- (BOOL)httpIsValid;
@end
