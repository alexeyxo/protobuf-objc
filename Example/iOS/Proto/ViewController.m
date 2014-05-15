//
//  ViewController.m
//  Proto
//
//  Created by Will on 11/03/14.
//  Copyright (c) 2014 Will. All rights reserved.
//

#import "ViewController.h"

#import "NSObject+MKBlockTimer.h"
#import "ProtocolBuffers.h"
#import "Person.pb.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self proto];
    [self json];
}


-(void) proto
{
    // Proto Part
    NSData* raw_data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://0.0.0.0:4567/1/getGroups"]];
    if (!raw_data)
    {
        NSLog(@"Please turn on the server");
        return;
    }
    
    __block Person* person;
    NSLog(@"proto content size %@",[NSByteCountFormatter stringFromByteCount:raw_data.length countStyle:NSByteCountFormatterCountStyleMemory]);
   
    [NSObject logTime:^{
        person = [Person parseFromData:raw_data];
        NSLog(@"%ld",(long)person.personId);
    } withPrefix:@"builing proto objects"];
}

-(void) json
{
    // JSON Part
    NSData *raw_data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://0.0.0.0:4567/1/getGroupsJson"]];

    if (!raw_data)
    {
        NSLog(@"Please turn on the server");
        return;
    }

    NSLog(@" ");
    NSLog(@"json content size %@",[NSByteCountFormatter stringFromByteCount:raw_data.length countStyle:NSByteCountFormatterCountStyleMemory]);
    __block NSObject *serial;
    [NSObject logTime:^{
        serial = [NSJSONSerialization JSONObjectWithData:raw_data options:NSJSONReadingMutableContainers error:nil];
    } withPrefix:@"parse json"];
}


@end
