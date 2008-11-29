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
	
	BOOL ispath;
	
	if (url == nil || output == nil){
		fprintf(stderr,"webarchiver 0.2\nUsage: webarchiver -url URL -output FILE \nExample: webarchiver -url http://www.google.com -output google.webarchive\n-url\thttp:// or path to local file\n-output\tFile to write webarchive to\n\nUpdates can be found at http://entropy.textdriven.com/\n");
		exit(1);
	}
	
	NSRange http_range = NSMakeRange(0, [@"http://" length]);	
	NSString *http_protocal = [url substringWithRange:http_range];
	
	if ([http_protocal isEqualToString:@"http://"]) {
		ispath = NO;
	} else {
		ispath = YES;
	}
	
	NSString *ext = @".webarchive";
	if ([output length]<[ext length] || ![[output substringFromIndex:[output length]-[ext length]] isEqualToString:ext] ) {
		fprintf(stderr,"Warning: Output file does not have the .webarchive file extension\n");
	}

	
	KBWebArchiver *webArchiver = [[KBWebArchiver alloc] init];
	NSString *textString;
	WebArchive *wa = [webArchiver archiveFromString:url isPath:ispath textString:&textString];
	NSData *data = [wa data];
	
	if ( wa == nil || data == nil ) {
		fprintf(stderr,"Error: Unable to create webarchive\n");
		exit(1);
	}
	
	BOOL success = [data writeToFile:output atomically:NO];
	if (success == NO) {
		fprintf(stderr,"Error: Unable to write webarchive to file %s\n",[output UTF8String]);
		exit(1);
	}
	
	exit(0);
}