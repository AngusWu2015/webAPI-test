//
//  WebService.m
//  kk_WebAPI
//
//  Created by AndyWu on 2018/1/29.
//  Copyright © 2018年 AndyWu. All rights reserved.
//

#import "WebService.h"

@implementation WebService

static WebService *service = nil;
+ (WebService *) instance
{
    if (! service)
        service = [[WebService alloc] init];
    
    return service;
}

-(void)fetchGetResponseWithCallback:(void(^)(NSDictionary *,NSError *))callback{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://httpbin.org/get"]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return callback(nil,error);
        }
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        return callback(dict,nil);
    }];
    [sessionDataTask resume];
}
-(void)postCustomerName:(NSString *)name callback:(void(^)(NSDictionary *, NSError *))callback{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://httpbin.org/post"]];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"custname=%@",name];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return callback(nil,error);
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        return callback(dict,nil);
    }];
    [sessionDataTask resume];
}
-(void)fetchImageWithCallback:(void(^)(UIImage *,NSError *))callback{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://httpbin.org/image/png"]];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error) {
            return callback(nil,error);
        }
        
        UIImage *downloadedImage = [UIImage imageWithData:
                                    [NSData dataWithContentsOfURL:location]];
        if (downloadedImage == nil) {
            return callback(nil,nil);
        }
        return callback(downloadedImage,nil);
     
    }];
  
    [downloadPhotoTask resume];
}


@end
