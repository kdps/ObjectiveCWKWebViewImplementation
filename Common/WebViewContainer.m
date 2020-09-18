#import "WebViewContainer.h"
#import <WebKit/WebKit.h>

@implementation WebViewContainer

+ (void) loadURL(NSString *)requestURLString:(WKWebView *) webView {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requestURLString]];
    
    [webView loadRequest:request];
}
    
+ (void)setURL:(NSString *)requestURLString:(WKWebView *) webView {
    NSURL *url = [[NSURL alloc] initWithString: requestURLString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url
                                                  cachePolicy: NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval: 5];
    
    [webView loadRequest: request];
}

+ (WKWebViewConfiguration *)setJS {
    NSString *jsString = @"";
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource: jsString
                                                      injectionTime: WKUserScriptInjectionTimeAtDocumentEnd
                                                   forMainFrameOnly:YES];
    WKUserContentController *wkUController = [WKUserContentController new];
    [wkUController addUserScript: userScript];
    
    [wkUController addScriptMessageHandler:self name:@"callbackHandler"];
    
    WKWebViewConfiguration *wkWebConfig = [WKWebViewConfiguration new];
    wkWebConfig.userContentController = wkUController;
    
    return wkWebConfig;
}

+ (void)triggerJS:(NSString *)jsString webView:(WKWebView *)webView {
    [webView evaluateJavaScript:jsString
              completionHandler:^(NSString *result, NSError *error){
                  if (error != nil) {
                      return;
                  }
              }];
}

@end
