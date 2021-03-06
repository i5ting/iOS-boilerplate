//
//  IOSBoilerplateAppDelegate.h
//  IOSBoilerplate
//
//  Copyright (c) 2011 Alberto Gimeno Brieba
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//  

#import <UIKit/UIKit.h>

#import "SinaWeibo.h"
#import "SNViewController.h"

/**将下面注释取消，并定义自己的app key，app secret以及授权跳转地址uri
 此demo即可编译运行**/

#define kAppKey             @"774472872"
#define kAppSecret          @"f7a16fab166225c072d0a84f6e95bcdb"
#define kAppRedirectURI     @"http://uhzl006130.chinaw3.com/aa/index.php"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@class SinaWeibo;
@class SNViewController;


@interface IOSBoilerplateAppDelegate : NSObject <UIApplicationDelegate>{

    SinaWeibo *sinaweibo;
}

@property (readonly, nonatomic) SinaWeibo *sinaweibo;


@property (retain, nonatomic) SNViewController *viewController;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

+ (IOSBoilerplateAppDelegate*) sharedAppDelegate;

- (BOOL)openURL:(NSURL*)url;

@end
