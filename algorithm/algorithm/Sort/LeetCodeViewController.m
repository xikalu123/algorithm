//
//  LeetCodeViewController.m
//  algorithm
//
//  Created by chenyuliang on 2019/5/13.
//  Copyright © 2019 didi. All rights reserved.
//

#import "LeetCodeViewController.h"
#import "LeetCodeSolution.hpp"

@interface LeetCodeViewController ()

@end

@implementation LeetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    vector<int> input{2,3,4,5,6,1,9};
    vector<int> result = twoSum(input, 11);
    
    for (int i = 0; i<result.size(); i++) {
         std::cout<<result[i]<<"  "<<std::endl;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
