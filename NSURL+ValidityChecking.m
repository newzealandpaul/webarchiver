#import "NSURL+ValidityChecking.h"


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
