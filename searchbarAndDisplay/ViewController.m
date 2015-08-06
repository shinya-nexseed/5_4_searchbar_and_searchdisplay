//
//  ViewController.m
//  searchbarAndDisplay
//
//  Created by Shinya Hirai on 2015/05/04.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // テーブルに表示したいデータソースをセット
    self.dataSourceiPhone = @[@"iPhone 4", @"iPhone 4S", @"iPhone 5", @"iPhone 5c", @"iPhone 5s"];
    self.dataSourceAndroid = @[@"Nexus", @"Galaxy", @"Xperia"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger dataCount;
    
    // ここのsearchDisplayControllerはStoryboardで紐付けされたsearchBarに自動で紐づけられています
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        switch (section) {
            case 0:
                dataCount = self.dataSourceSearchResultsiPhone.count;
                break;
            case 1:
                dataCount = self.dataSourceSearchResultsAndroid.count;
                break;
            default:
                break;
        }
    } else {
        switch (section) {
            case 0:
                dataCount = self.dataSourceiPhone.count;
                break;
            case 1:
                dataCount = self.dataSourceAndroid.count;
                break;
            default:
                break;
        }
    }
    return dataCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // 再利用できるセルがあれば再利用する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    
    // ここのsearchDisplayControllerはStoryboardで紐付けされたsearchBarに自動で紐づけられています
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // 検索中の暗転された状態のテーブルビューはこちらで処理
        switch (indexPath.section) {
            case 0: // iOS
                cell.textLabel.text = self.dataSourceSearchResultsiPhone[indexPath.row];
                break;
            case 1: // Android
                cell.textLabel.text = self.dataSourceSearchResultsAndroid[indexPath.row];
                break;
            default:
                break;
        }
    } else {
        // 通常時のテーブルビューはこちらで処理
        switch (indexPath.section) {
            case 0: // iOS
                cell.textLabel.text = self.dataSourceiPhone[indexPath.row];
                break;
            case 1: // Android
                cell.textLabel.text = self.dataSourceAndroid[indexPath.row];
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)filterContainsWithSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.dataSourceSearchResultsiPhone = [self.dataSourceiPhone filteredArrayUsingPredicate:predicate];
    self.dataSourceSearchResultsAndroid = [self.dataSourceAndroid filteredArrayUsingPredicate:predicate];
}

- (BOOL)searchDisplayController:controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // 検索バーに入力された文字列を引数に、絞り込みをかけます
    [self filterContainsWithSearchText:searchString];
    
    // YESを返すとテーブルビューがリロードされます。
    // リロードすることでdataSourceSearchResultsiPhoneとdataSourceSearchResultsAndroidからテーブルビューを表示します
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"table view tap");
    
    SecondViewController *sVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // 検索中の暗転された状態のテーブルビューはこちらで処理
        switch (indexPath.section) {
            case 0: // iOS
                sVC.title = self.dataSourceSearchResultsiPhone[indexPath.row];
                break;
            case 1: // Android
                sVC.title = self.dataSourceSearchResultsAndroid[indexPath.row];
                break;
            default:
                break;
        }
    } else {
        // 通常時のテーブルビューはこちらで処理
        switch (indexPath.section) {
            case 0: // iOS
                sVC.title = self.dataSourceiPhone[indexPath.row];
                break;
            case 1: // Android
                sVC.title = self.dataSourceAndroid[indexPath.row];
                break;
            default:
                break;
        }
    }
    
    
    [self.navigationController pushViewController:sVC animated:YES];
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
//        NSIndexPath *indexPath = nil;
//        NSString *str;
//        
//        if (self.searchDisplayController.active) {
//            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
//            str = [self.dataSourceSearchResultsiPhone objectAtIndex:indexPath.row];
//        } else {
//            //indexPath = [self.tableView indexPathForSelectedRow];
//            //recipe = [recipes objectAtIndex:indexPath.row];
//        }
//        
//        SecondViewController *sVC = segue.destinationViewController;
//        // sVC.recipe = recipe;
//    }
//}



@end
