//
//  ViewController.h
//  searchbarAndDisplay
//
//  Created by Shinya Hirai on 2015/05/04.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *dataSourceiPhone;
@property (nonatomic, strong) NSArray *dataSourceAndroid;

@property (nonatomic, strong) NSArray *dataSourceSearchResultsiPhone;
@property (nonatomic, strong) NSArray *dataSourceSearchResultsAndroid;

@end

