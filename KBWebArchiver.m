//
//  KBWebArchiver.m (patched by John Winter)
//  ---------------
//
//  Orginal : Keith Blount 2005
//	Page timeout fix: John Winter 2006

#import "KBWebArchiver.h"

// Category on NSURL to check whether an HTTP URL is valid - thanks to whoever posted it on CocoaDev
// (http://www.cocoadev.com/index.pl?FileExistsAtURL)
@interface NSURL (ValidityChecking)
@end

@implementation NSURL (ValidityChecking)
- (BOOL)httpIsValid
{
	BOOL isValid = NO;
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self];
	[request setHTTPMethod:@"HEAD"];
	NSHTTPURLResponse *response = nil;
	[NSURLConnection sendSynchronousRequest:request
						  returningResponse:&response
									  error:NULL];
	if ((response != nil) && ([response statusCode] == 200))
	isValid = YES;

	return isValid;
}
@end


@interface KBWebArchiver (Private)
- (WebArchive *)archiveFromString:(NSString *)URLString isPath:(BOOL)isPath textString:(NSString **)textString;
@end

@implementation KBWebArchiver

+ (WebArchive *)webArchiveFromURLString:(NSString *)URLString textString:(NSString **)textString
{
	KBWebArchiver *archiver = [[[KBWebArchiver alloc] init] autorelease];
	return [archiver archiveFromString:URLString isPath:NO textString:textString];
}

+ (WebArchive *)webArchiveFromURLPathString:(NSString *)path textString:(NSString **)textString
{
	KBWebArchiver *archiver = [[[KBWebArchiver alloc] init] autorelease];
	return [archiver archiveFromString:path isPath:YES textString:textString];
}

- (WebArchive *)archiveFromString:(NSString *)URLString isPath:(BOOL)isPath textString:(NSString **)textString
{
	NSURL *url = (isPath) ? [NSURL fileURLWithPath:URLString] : [NSURL URLWithString:URLString];
	
	if ( (!isPath) && (![url httpIsValid]) )
		return nil;
	
	WebView *webView = [[[WebView alloc] initWithFrame:NSMakeRect(0,0,200,200)] autorelease];
	[webView setFrameLoadDelegate:self];

	finishedLoading = NO;
	loadFailed = NO;
	
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
	
	[[webView mainFrame] loadRequest:theRequest];
	
	double resolution = 1;
	BOOL isRunning;

	do {
		NSDate* next = [NSDate dateWithTimeIntervalSinceNow:resolution]; 
		isRunning = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:next];
	} while (isRunning && finishedLoading == NO);
	
	[[webView mainFrame] stopLoading];	// Ensure the frame stops loading, otherwise will crash when released!
	
	if (loadFailed)
		return nil;
		
	// Get the text
	if ([[[[webView mainFrame] frameView] documentView] conformsToProtocol:@protocol(WebDocumentText)])
		*textString = [(id <WebDocumentText>)[[[webView mainFrame] frameView] documentView] string];
	else
		*textString = @"";	// Return a blank string

	// the -dataSource method was causing some crashes and also some web pages only half-loaded;
	// using the -DOMDocument method seems to work much better.
	
	//return [[[webView mainFrame] dataSource] webArchive];
	return [[[webView mainFrame] DOMDocument] webArchive];
}

// Oh dear, this can cause some crashes - eg. importing Yahoo...

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	if (frame == [sender mainFrame])
		finishedLoading = YES;
}

// Check for errors loading page
- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
	loadFailed = YES;
	finishedLoading = YES;
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
	loadFailed = YES;
	finishedLoading = YES;
}

@end
