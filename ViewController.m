#import "ViewController.h"
#import <WebKit/WebKit.h>

#pragma mark - Private interface
@interface ViewController () <WKNavigationDelegate, WKScriptMessageHandler>
    @property (strong, nonatomic) IBOutlet WKWebView *webView;
    @property (nonatomic, strong) WKWebViewConfiguration * webConfig;
@end

#pragma mark - Implementation
@implementation ViewController

@end
