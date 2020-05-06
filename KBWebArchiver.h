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

extern NSString *const KBWebArchiverErrorDomain;

typedef NS_ENUM(NSUInteger, KBWebArchiverErrorCode) {
    KBWebArchiverErrorCodeUnknown = 0,
    KBWebArchiverErrorCodeInvalidURL = 1,
    KBWebArchiverErrorCodeLoadFailed = 2,
    KBWebArchiverErrorCodeArchiveCreationFailed = 3
};

@interface KBWebArchiver : NSObject
{
	NSURL *_URL;
	NSString *_customJS;

	NSMutableDictionary *_archiveInformation;
	BOOL _finishedLoading;
	BOOL _loadFailed;

	BOOL _localResourceLoadingOnly;
}

@property (nonatomic, readwrite, strong) NSURL *URL;
@property (nonatomic, readwrite, strong) NSString *customJS;
@property (nonatomic) BOOL localResourceLoadingOnly;

- (id)initWithURLString:(NSString *)aURLString isFilePath:(BOOL)isFilePath;
- (id)initWithURLString:(NSString *)aURLString;
- (id)initWithURL:(NSURL *)aURL;

- (void)setURLString:(NSString *)aURLString isFilePath:(BOOL)isFilePath;
- (NSString *)URLString;
- (BOOL)isFilePath;

- (WebArchive *)webArchive;
- (NSString *)string;
- (NSString *)title;
- (NSError *)error;

@end
