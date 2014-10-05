#Webarchiver

Webarchiver allows you to create Safari .webarchive files from the command line. Webarchives are a convenient way to store a webpage and its associated files (images, css, javascript, etc) in a single file. It is very simple to use:

    ./webarchiver -url http://www.google.com -output google.webarchive

##Usage

    $./webarchiver

    webarchiver 0.9
    Usage: webarchiver -url URL -output FILE
    Example: webarchiver -url http://www.google.com -output google.webarchive
    -url    http:// or path to local file
    -output File to write webarchive to</code>

Do not forget the ‘http://’ if you want to archive a webpage. If no
‘http://’ is present then webarchiver attempts to archive a local file.

##Download

The easiest way to install webarchiver is using
[MacPorts][][:][MacPorts]  
   
    `sudo port install webarchiver`  

##Release notes

Version 0.9 : Removed man page template. Updated Version number in code. Thanks [Kurt Hindenburg][]

Version 0.8 : [Matias Piipari][] fixed error codes.

Version 0.7 : 

- Modernized and improved the code.
- Support for loading local HTML files without an extension.
- If the output path is a folder, we now save the webarchive there.
- **Big thanks to [Jan Weiß][] for the work done in this release**

Version 0.6 : Cleaned up Github release.

Version 0.5 : More robust KBWebArchiver ([Keith Blount][] and [Jan Weiß][]).

Version 0.4 : Code maintenance and cleanup ([Jan Weiß][]).

Version 0.3 : Changed URL and sorted out source for git.

Version 0.2 : [John Winter][] fixed page loading issue.

Version 0.1 : Initial release.

##Credits

-   [Matias Piipari][] for fixing error codes.
-   [Jan Weiß][] for his code fixes, clean up, 0.4 and 0.7 release. 
-   [Keith Blount][] for his very
    useful KBWebArchiver class.
-   [John Winter][] for testing and bug fixing. Thanks John.
-   [Rob Griffiths][] for hosting a copy of the source when my blog was
    down.
-   Boey Maun Suang for creating a MacPort

  [Matias Piipari]: https://github.com/mz2
  [MacPorts]: http://www.macports.org/
  [Jan Weiß]: https://github.com/JanX2/webarchiver
  [John Winter]: http://www.shipsomecode.com/
  [Keith Blount]: http://www.literatureandlatte.com/
  [Rob Griffiths]: http://www.macosxhints.com/
  [Kurt Hindenburg]: https://github.com/kurthindenburg?tab=activity
