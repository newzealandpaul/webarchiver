//If you use this code, please link to my blog: http://www.entropytheblog.com/blog/ . thanks.

#import <Foundation/Foundation.h>
#import <Webkit/Webkit.h>
#import <WebKit/WebArchive.h>
#import "KBWebArchiver.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSUserDefaults *args = [NSUserDefaults standardUserDefaults];	
	
	NSString *url = [args stringForKey:@"url"];
	NSString *localOnlyString = [args stringForKey:@"local"];
	NSString *output = [args stringForKey:@"output"];

	BOOL localOnly = [localOnlyString isEqualToString:@"YES"];

	if (url == nil || output == nil) {
		fprintf(stderr, "webarchiver 0.5\nUsage: webarchiver -url URL -output FILE \nExample: webarchiver -url http://www.google.com -output google.webarchive\n-url\thttp:// or path to local file\n-output\tFile to write webarchive to\n\nUpdates can be found at https://github.com/newzealandpaul/webarchiver/\n");
		exit(1);
	}
	
	BOOL isDirectory;
	BOOL diskItemExists = [[NSFileManager defaultManager] fileExistsAtPath:output 
														   isDirectory:&isDirectory];
	
	NSString *ext = @"webarchive";
	if (![[output pathExtension] isEqualToString:ext]
		&& !isDirectory) {
		fprintf(stderr, "Warning: Output file does not have the .webarchive file extension\n");
	}

	
	WebArchive *webarchive;
	KBWebArchiver *archiver = [[KBWebArchiver alloc] initWithURLString:url];
	archiver.localResourceLoadingOnly = localOnly;
	webarchive = [archiver webArchive];
	NSString *title = [archiver title];
	NSData *data = [webarchive data];
	NSError *error = [archiver error];
	[archiver release];
	
	if ( webarchive == nil || data == nil ) {
		fprintf(stderr, "Error: Unable to create webarchive\n");
		if (error != nil)  fprintf(stderr, "%s\n", [[error description] UTF8String]);
		
		[pool drain];
		return EXIT_FAILURE;
	}
	
	if (diskItemExists && isDirectory) {
		NSString *cleanedTitle = [title stringByReplacingOccurrencesOfString:@"/" 
																  withString:@":" 
																	 options:NSLiteralSearch 
																	   range:NSMakeRange(0, [title length])];
		output = [output stringByAppendingPathComponent:cleanedTitle];
		output = [output stringByAppendingPathExtension:ext];
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
