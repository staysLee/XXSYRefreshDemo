//
//  GCDTest.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/31.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "GCDTest.h"

@implementation GCDTest

- (void)test1{
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //串行
    dispatch_queue_t serialQueue = dispatch_queue_create("com.test.serialQueue", DISPATCH_QUEUE_SERIAL);
    //并行
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.test.ConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    //main
    dispatch_queue_t mainQueue;
    mainQueue = dispatch_get_main_queue();
    
    dispatch_queue_t customQueue = dispatch_queue_create("com.test.customQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(customQueue, ^{
        
    });
    dispatch_sync(customQueue, ^{
        
    });
}

- (void)test2{
    ///方法1
    //这里执行结果是先输出A后在输出B，注意CFRunLoopRun()的位置
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@""] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"AAA");
        CFRunLoopStop(CFRunLoopGetMain());
    }];
    [task resume];
    CFRunLoopRun();
    NSLog(@"BBB");
    
    ///方法2
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"AAA");
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"BBB");
    });
    
    ///方法3
    dispatch_queue_t  queue3 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue3, ^{
        NSLog(@"AAA");
    });
    dispatch_async(queue3, ^{
        NSLog(@"BBB");
    });
    dispatch_barrier_async(queue3, ^{
        NSLog(@"前面的都执行完了");
    });
    dispatch_async(queue3, ^{
        NSLog(@"CCC");
    });
    dispatch_async(queue3, ^{
        NSLog(@"DDD");
    });
    dispatch_async(queue3, ^{
        NSLog(@"EEE");
    });
    
    ///方法4
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"AAA");
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"BBB");
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"CCC");
    }];
    
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [operationQueue addOperations:@[op1,op2,op3] waitUntilFinished:YES];
    NSLog(@"DDD");
    
}

- (void)test3{
    NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationRunAction_Main) object:nil];
    [op start];
    
    /******************/
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationRunAction_Asnys) object:nil];
    [queue addOperation:op2];
}

- (void)invocationRunAction_Main
{
    //说明
    //  在没有使用NSOperationQueue、单独使用NSInvocationOperation的情况下，NSInvocationOperation在主线程执行操作，并没有开启新线程。
     NSLog(@"当前NSInvocationOperation执行的线程为：%@", [NSThread currentThread]);
}
- (void)invocationRunAction_Asnys
{
    NSLog(@"当前addAsnysOperationFormInvocation执行的线程为：%@", [NSThread currentThread]);
    //输出：当前addAsnysOperationFormInvocation执行的线程为：<NSThread: 0x600000279040>{number = 8, name = (null)}
    //说明
    //  创建NSOperationQueue队列，并把NSInvocationOperation加入则会新开一个线程来执行。
}


- (void)addOprationFormBlock
{
    
}


@end
