//
//  LeetCodeSolution.cpp
//  algorithm
//
//  Created by chenyuliang on 2019/5/13.
//  Copyright © 2019 didi. All rights reserved.
//

#include "LeetCodeSolution.hpp"

vector<int> twoSum(vector<int>&nums,int target)
{
    unordered_map<int, int> hash;
    vector<int> result;
    
    for (int i = 0; i< nums.size(); i++) {
        int findNum = target - nums[i];
        if (hash.find(findNum) != hash.end()) {
            result.push_back(i);
            result.push_back(hash[findNum]);
            return result;
        }
        
        hash[nums[i]] = i;
    }
    
    return result;
}



