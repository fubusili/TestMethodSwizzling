//
//  ViewController.m
//  swizling
//
//  Created by hc_cyril on 16/4/29.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "ViewController.h"
//#import "NSDictionary+NoNull.h"
#import "NSString+ExChangeMethod.h"

@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSArray *dataSources;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dict = @{@"a":@"1",@"b":@"12",@"c":@"123",};
    NSString *str = dict[@"a"];
    NSLog(@"%@",str);
    NSLog(@"%@",[str substringFromIndex:0]);
    
    [self testPickerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void)testPickerView {
    
    self.dataSources = [NSArray arrayWithObjects:@"dds", @"dddds", @"dsssssss", nil];
    
    UIPickerView *view = [UIPickerView new];
    view.backgroundColor = [UIColor lightGrayColor];
    view.frame = self.view.bounds;
    view.delegate = self;
    view.dataSource = self;
    [self.view addSubview:view];
}

#pragma mark - pickerView delegate and dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return self.dataSources.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return self.dataSources[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    
}

@end
