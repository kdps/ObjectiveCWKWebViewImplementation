#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewContainer : NSObject

+ (void)triggerJS:(NSString *)jsString webView:(WKWebView *)webView;
+ (void)setURL:(NSString *)requestURLString:(WKWebView *) webView;
+ (WKWebViewConfiguration *)setJS;

@end
