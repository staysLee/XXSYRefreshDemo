//
//  XXSYRefreshDemoTests.m
//  XXSYRefreshDemoTests
//
//  Created by liming on 2018/7/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestModel.h"

@interface XXSYRefreshDemoTests : XCTestCase

@end

@implementation XXSYRefreshDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testModelFunc_randomLessThanTen
{
    XCTestModel *model = [[XCTestModel alloc] init];
    NSInteger randomNum = [model randomLessThanTen];
    XCTAssert(randomNum<10,@"应该小于10");
}
@end
