#import "ViewController.h"
#import <WebKit/WebKit.h>

#pragma mark - Private interface
@interface ViewController () <WKNavigationDelegate, WKScriptMessageHandler>
    @property (strong, nonatomic) IBOutlet WKWebView *webView;
    @property (nonatomic, strong) WKWebViewConfiguration * webConfig;
    @property (nonatomic, strong) WKPreferences * webPreference;
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

-(WKWebViewConfiguration*) webConfig {
    if (!_webPreference) {
        _webPreference = [[WKPreferences alloc] init];
        _webPreference.javaScriptEnabled = YES;
        _webPreference.javaScriptCanOpenWindowsAutomatically = YES;
    }
    
    if (!_webConfig) {
        _webConfig = [[WKWebViewConfiguration alloc]init];
        
        // set Preference
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

@end
