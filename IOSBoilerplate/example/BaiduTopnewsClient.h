//
//  BaiduTopnewsClient.h
//  IOSBoilerplate
//
//  Created by sang on 3/8/13.
//
//

#import "AFHTTPClient.h"

@interface BaiduTopnewsClient : AFHTTPClient
+ (BaiduTopnewsClient *)sharedClient;
@end
