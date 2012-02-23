//If you use this code, please link to my blog: http://www.entropytheblog.com/blog/ . thanks.

#import <Foundation/Foundation.h>
#import <Webkit/Webkit.h>
#import <WebKit/WebArchive.h>
#import "KBWebArchiver.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSUserDefaults *args = [NSUserDefaults standardUserDefaults];	
	
	NSString *url = [args stringForKey:@"url"];
	NSString *output = [args stringForKey:@"output"];
	
	BOOL isPath;
	
	if (url == nil || output == nil) {
		fprintf(stderr, "webarchiver 0.5\nUsage: webarchiver -url URL -output FILE \nExample: webarchiver -url http://www.google.com -output google.webarchive\n-url\thttp:// or path to local file\n-output\tFile to write webarchive to\n\nUpdates can be found at https://github.com/newzealandpaul/webarchiver/\n");
		exit(1);
	}
	
	if ([url hasPrefix:@"http://"] || [url hasPrefix:@"file://"]) {
		isPath = NO;
	} else {
		isPath = YES;
	}
	
	NSString *ext = @".webarchive";
	if (![output hasSuffix:ext]) {
		fprintf(stderr, "Warning: Output file does not have the .webarchive file extension\n");
	}

	
	WebArchive *webarchive;
	KBWebArchiver *archiver = [[KBWebArchiver alloc] initWithURLString:url isFilePath:isPath];
	webarchive = [archiver webArchive];
	NSData *data = [webarchive data];
	NSError *error = [archiver error];
	[archiver release];
	
	if ( webarchive == nil || data == nil ) {
		fprintf(stderr, "Error: Unable to create webarchive\n");
		if (error != nil)  fprintf(stderr, "%s\n", [[error description] UTF8String]);
		
		[pool drain];
		return EXIT_FAILURE;
	}
	
	BOOL success = [data writeToFile:output atomically:NO];
	if (success == NO) {
		fprintf(stderr, "Error: Unable to write webarchive to file %s\n", [output UTF8String]);
		
		[pool drain];
		return EXIT_FAILURE;
	}
	
	[pool drain];
	return EXIT_SUCCESS;
}
