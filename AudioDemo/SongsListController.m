//
//  SongsListController.m
//  AudioDemo
//
//  Created by LiuFeng on 16/1/27.
//  Copyright © 2016年 LiuFeng. All rights reserved.
//

#import "SongsListController.h"
#import "SongListCell.h"
#import "ViewController.h"

@interface SongsListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,copy) NSArray *dataArray;

@end

@implementation SongsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([SongListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SongListCell class])];
    
    NSArray *songPaths = [NSBundle pathsForResourcesOfType:@".mp3" inDirectory:[[NSBundle mainBundle] resourcePath]];
    self.dataArray = songPaths;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SongListCell *songListCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SongListCell class])];
    [songListCell setValueForMusicPath:self.dataArray[indexPath.row]];
    return songListCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    ViewController *viewController = (ViewController *)self.presentingViewController;
    viewController.musicPath = self.dataArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dealBackToPlayContinue:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
