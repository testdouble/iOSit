//
//  RedditSpec.m
//  Crapit
//
//  Created by Brent Yoder on 1/22/15.
//  Copyright (c) 2015 Brent Yoder. All rights reserved.
//

#import "Kiwi.h"
#import "OHHTTPStubs.h"

@interface RedditService : NSObject;
-(void) getPosts: (void (^)(NSArray*, NSError*)) callback;
@end

SPEC_BEGIN(RedditSpec)

describe(@"RedditService", ^{
    xit(@"calls out to the API URL", ^{
    });
    
    it(@"fetches data from the API", ^{
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.host isEqualToString:@"reddit.com"];
        } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
            // Stub it with our "wsresponse.json" stub file
            NSData* stubData = [@"{}" dataUsingEncoding:NSUTF8StringEncoding];
            return [OHHTTPStubsResponse responseWithData:stubData statusCode:200
                                                 headers:@{@"Content-Type":@"application/json"}];
        }];
        
        RedditService* redditService = [[RedditService alloc] init];
        
        __block NSArray* results;
        
        [redditService getPosts: ^(NSArray* posts, NSError* error){
            results = posts;
        }];
        
        [[expectFutureValue(results) shouldEventually] equal:@[]];
    });
});

SPEC_END

@implementation RedditService : NSObject
-(void) getPosts: (void (^)(NSArray*, NSError*)) callback {
    callback(@[], nil);
}
@end