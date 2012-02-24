//
//  KBWebArchiver.h
//  ---------------
//
//  (c) Keith Blount 2005 (updated 2008)
//
//	Takes a URL string and creates a webarchive. It can also retrieve the page title and the plain text string of the web page.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface KBWebArchiver : NSObject
{
	NSURL *URL;
	
	NSMutableDictionary *archiveInformation;
	BOOL finishedLoading;
	BOOL loadFailed;

	BOOL localResourceLoadingOnly;
}

@property (nonatomic) BOOL localResourceLoadingOnly;

- (id)initWithURLString:(NSString *)aURLString isFilePath:(BOOL)isFilePath;
- (id)initWithURL:(NSURL *)aURL;

- (void)setURL:(NSURL *)aURL;
- (NSURL *)URL;

- (void)setURLString:(NSString *)aURLString isFilePath:(BOOL)isFilePath;
- (NSString *)URLString;
- (BOOL)isFilePath;

- (WebArchive *)webArchive;
- (NSString *)string;
- (NSString *)title;
- (NSError *)error;

@end
