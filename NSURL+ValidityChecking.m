//
//  NSURL_ValidityChecking.m
//  Scrivener
//
//  Created by Keith Blount on 19/08/2007.
//

#import "NSURL+ValidityChecking.h"


@implementation NSURL (ValidityChecking)

- (BOOL)httpIsValid
{
	BOOL isValid = NO;
#if 0
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[self copy] autorelease]	// Copy the URL here just in case (shouldn't need to)
														   cachePolicy:NSURLRequestReloadIgnoringCacheData
													   timeoutInterval:60];
	// NOTE: setting the request type to "HEAD" really messes up the import of some web pages, although
	// I have no idea why anything here would mess up code in the web archiver. For intance, this URL:
	// http://www.adobeforums.com/cgi-bin/webx/.3bc30294/0 will not be created as a webarchive properly
	// if the request type is set to "HEAD" here...
	[request setHTTPMethod:@"HEAD"];
#endif
	
	NSURLRequestCachePolicy cachePolicy;
#if (MAC_OS_X_VERSION_MIN_REQUIRED < 1050)	
	cachePolicy = NSURLRequestReloadIgnoringCacheData;
#else
	cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
#endif
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[[self copy] autorelease]	// Don't actually send self, just in case...
											 cachePolicy:cachePolicy
										 timeoutInterval:30];
	NSHTTPURLResponse *response = nil;
	[NSURLConnection sendSynchronousRequest:request
						  returningResponse:&response
									  error:NULL];
	
	if ((response != nil) && ([response statusCode] == 200))
		isValid = YES;
	
	return isValid;
}

@end
