#import "ViewController.h"
#import <WebKit/WebKit.h>

#pragma mark - Private interface
@interface ViewController () <WKNavigationDelegate, WKScriptMessageHandler>
    @property (strong, nonatomic) IBOutlet WKWebView *webView;
    @property (nonatomic, strong) WKWebViewConfiguration * webConfig;
    @property (nonatomic, strong) WKPreferences * webPreference;
    @property (nonatomic, strong) WKProcessPool * webProcessPool;
@end

#pragma mark - Implementation
@implementation ViewController

NSString *javascriptNamespace = @"ios";

#pragma mark - LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:self.webConfig];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.webView setNavigationDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(WKWebViewConfiguration*) webConfig {
    if (!_webPreference) {
        _webPreference = [[WKPreferences alloc] init];
        _webPreference.javaScriptEnabled = YES;
        _webPreference.javaScriptCanOpenWindowsAutomatically = YES;
    }
    
    if (!_webProcessPool) {
        _webProcessPool= [[WKProcessPool alloc] init];
    }
    
    if (!_webConfig) {
        _webConfig = [[WKWebViewConfiguration alloc]init];

        // Set Process Pool
        if (!_webProcessPool) {
            _webConfig.processPool = _webProcessPool;
        }
        
        // Set Preference
        if (!_webPreference) {
            _webConfig.preferences = _webPreference;
        }
        
        WKUserContentController* userController = [[WKUserContentController alloc]init];
        
        // Add Javascript Message Handler
        [userController addScriptMessageHandler:self name:javascriptNamespace];
        
        _webConfig.userContentController = userController;
        
    }
    return _webConfig;
    
}

-(void) presentWebviewControllerWithRequest:(NSURLRequest *)urlRequest {
    NSLog(@"presentWebviewControllerWithRequest");
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
}

#pragma mark - WKNavigationDelegate Methods
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"1. didCommitNavigation");
}
 
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"2. didFinishNavigation");
}
 
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"3. didFailNavigation");
}
 
@end
