//
//  WebService.h
//  kk_WebAPI
//
//  Created by AndyWu on 2018/1/29.
//  Copyright © 2018年 AndyWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WebService : NSObject
+ (WebService *) instance;
-(void)fetchGetResponseWithCallback:(void(^)(NSDictionary *,NSError *))callback;
-(void)postCustomerName:(NSString *)name callback:(void(^)(NSDictionary *, NSError *))callback;
-(void)fetchImageWithCallback:(void(^)(UIImage *,NSError *))callback;
@end
