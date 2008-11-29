//
//  KBWebArchiver.h
//  ---------------
//
//  (c) Keith Blount 2005
//
//	Takes a URL string and creates a webarchive. You can also pass a textString pointer in to retrieve the
//	plain text string of the web page.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface KBWebArchiver : NSObject
{
	BOOL finishedLoading;
	BOOL loadFailed;
}

+ (WebArchive *)webArchiveFromURLString:(NSString *)URLString textString:(NSString **)textString;
+ (WebArchive *)webArchiveFromURLPathString:(NSString *)path textString:(NSString **)textString;

@end
