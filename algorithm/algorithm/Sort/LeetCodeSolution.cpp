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

string InterToRoman(int num)
{
    string result;
    static int nums[13] = {1000,900,500,400,100,90,50,40,10,9,5,4,1};
    static string romans[13] = {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};
    
    for (int i = 0; i < 13 && num > 0 ; i++) {
        if (num < nums[i]) {
            continue ;
        }
        
        while (num >= nums[i]) {
            num -= nums[i];
            result += romans[i];
        }
    }
    
    return result;
}

string removeOuter(string s)
{
    string result;
    string temp;
    
    int leftCount = 0;
    
    for (auto a : s) {
        if (a == '(') {
            leftCount++;
        }
        else if (a == ')')
        {
            leftCount--;
        }
        temp += a;
        
        if (leftCount == 0) {
            result += temp.substr(1,temp.length()-2);
            temp = "";
        }
    }
    
    return result;
}

string toLowerCase(string str)
{
//    unordered_map<char, char> letterTable {{'A','a'},{'B','b'},{'C','c'},{'D','d'},{'E','e'},{'F','f'},{'G','g'},{'H','h'},{'I','i'},{'J','j'},{'K','k'},{'L','l'},{'M','m'},{'N','n'},{'O','o'},{'P','p'},{'Q','q'},{'R','r'},{'S','s'},{'T','t'},{'U','u'},{'V','v'},{'W','w'},{'X','x'},{'Y','y'},{'Z','z'}};
//
    
    for(int i=0;i<str.length();i++)
    {
        if (str[i] >= 'A' && str[i] <= 'Z') {
            str[i] += ' ';
        }
    }
    return str;
    
}



