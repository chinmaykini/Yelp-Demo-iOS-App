//
//  YelpClient.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term offset:(int)offset params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *defaults = @{@"term": term, @"limit" : @20, @"offset" :[NSNumber numberWithInt:offset], @"ll" : @"37.774866,-122.394556"};
    
    // allowing to add more parameters to teh search api...
    NSMutableDictionary *allParameters = [defaults mutableCopy];
    if(params){
        [allParameters addEntriesFromDictionary:params];
    }
    NSLog(@"chinmay kini %@", allParameters);
    return [self GET:@"search" parameters:allParameters success:success failure:failure];
}

@end
