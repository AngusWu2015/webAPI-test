//
//  kk_WebAPITests.m
//  kk_WebAPITests
//
//  Created by AndyWu on 2018/1/29.
//  Copyright © 2018年 AndyWu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WebService.h"
@interface kk_WebAPITests : XCTestCase

@end

@implementation kk_WebAPITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchGetResponse{

    XCTestExpectation *expectation = [self expectationWithDescription:@"GET"];
    
   
    [[WebService instance]fetchGetResponseWithCallback:^(NSDictionary *dic,NSError *err){
        XCTAssertNotNil(dic, "dictionary should not be nil");
        XCTAssertNil(err, "error should be nil");
        XCTAssertNotNil(dic[@"args"], "dictionary args key not be nil");
        XCTAssertNotNil(dic[@"headers"], "dictionary headers key not be nil");
        XCTAssertNotNil(dic[@"origin"], "dictionary origin key not be nil");
        XCTAssertNotNil(dic[@"url"], "dictionary url key not be nil");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@",error.localizedDescription);
        }
    }];
  
}
- (void)testpostCustomer{
    XCTestExpectation *expectation = [self expectationWithDescription:@"POST"];
    
    
    [[WebService instance]postCustomerName:@"abc" callback:^(NSDictionary *dic,NSError *err){
        XCTAssertNotNil(dic, "dictionary should not be nil");
        XCTAssertNil(err, "error should be nil");
        XCTAssertEqualObjects(dic[@"form"][@"custname"],@"abc",@"custname is not abc");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@",error.localizedDescription);
        }
    }];
}

-(void)testFetchImage{
    XCTestExpectation *expectation = [self expectationWithDescription:@"IMAGE"];
    [[WebService instance]fetchImageWithCallback:^(UIImage *image,NSError *err){
        XCTAssertNil(err, "error should be nil");
        XCTAssertNotNil(image, "image should not be nil");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@",error.localizedDescription);
        }
    }];
}




@end
