//
//  SendTaskViewController.m
//  VedioTeacher
//
//  Created by Cao JianRong on 14-7-16.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "SendTaskViewController.h"

@interface SendTaskViewController ()

@end

@implementation SendTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    didSection = 0;
    showTask = @"1";
    dateArray = [[NSMutableArray alloc] initWithObjects:@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020", nil];;
    taskArray = [[NSMutableArray alloc] init];
    acceptArray = [[NSMutableArray alloc] init];
    
    [self createInitView];
    
}

-(void) sendedTask:(id)sender
{
    
}

-(void) acceptedNewTask:(id)sender
{
    
}

-(void) sendedVideo:(id)sender
{
    
}

-(void) submitTask:(id)sender
{
    
}

#pragma mark ----------------------------------------
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section <= 6) {
        return didSection - section ? 0 : 1;
    }
    if ([showTask isEqualToString:@"1"]) {
        return 100;//[taskArray count];
    }
    return [acceptArray count];
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 6) {
        return nil;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:[NSString stringWithFormat:@"%@年",[dateArray objectAtIndex:section]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 205, 25.0f);
    button.tag = section+500;
    [button addTarget:self action:@selector(sectionHeaderDidSelectAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor getColor:@"E4E4E4"]];
    if (didSection == section) {
        [button setBackgroundColor:[UIColor getColor:@"6ABAFA"]];
    }
    
    UIImageView *hor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 24.5, 205, 0.5)];
    hor.alpha = 0.5;
    hor.backgroundColor = [UIColor lightGrayColor];
    [button addSubview:hor];
    [hor release];
    
    return button;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section <= 6 ? [NSString stringWithFormat:@"%@年",[dateArray objectAtIndex:section]] : nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section <= 6 ? 25.0f : 0.0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section <= 6 ? 80.0f : 30.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section <= 6) {
        static NSString *identifier = @"date";
        DateShowCell *cell = (DateShowCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[DateShowCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        }
        [cell clearClicked];
        return cell;
    }
    static NSString *identifier = @"task";
    TaskCell *cell = (TaskCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[TaskCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.taskName.text = @"123456";
    return cell;
}

-(void) sectionHeaderDidSelectAtIndex:(id) sender
{
    NSInteger section = [sender tag] - 500;
    didSection = section;
    [sendTable reloadData];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void) mouthClickAtIndex:(id)sender
{
    
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, -260, 1024, 768);
    }];
    return YES;
}

-(BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 0, 1024, 768);
    }];
    return YES;
}

-(void) createInitView
{
//--------------------------------------------------------
//---------- 个人中心头部界面/高度为300  ---------------------
//--------------------------------------------------------
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 300)];
    headerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:headerView];
    [headerView release];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 260)];
    [bgView setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:bgView];
    [bgView release];
    
    UIButton *sendTask = [UIButton buttonWithType:UIButtonTypeCustom];
    sendTask.frame = CGRectMake(15, headerView.frame.size.height - 35, 90, 30);
    sendTask.layer.cornerRadius = 3.0;
    [sendTask setTitle:@"我发布的任务" forState:UIControlStateNormal];
    [sendTask setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendTask.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [sendTask addTarget:self action:@selector(sendedTask:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:sendTask];
    
    UIButton *newTask = [UIButton buttonWithType:UIButtonTypeCustom];
    newTask.frame = CGRectMake(sendTask.frame.size.width + sendTask.frame.origin.x + 10, headerView.frame.size.height - 35, 90, 30);
    newTask.layer.cornerRadius = 3.0;
    [newTask setTitle:@"我的新任务" forState:UIControlStateNormal];
    [newTask setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newTask.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [newTask addTarget:self action:@selector(acceptedNewTask:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:newTask];
    
    UIButton *sendVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    sendVideo.frame = CGRectMake(newTask.frame.size.width + newTask.frame.origin.x + 10, headerView.frame.size.height - 35, 90, 30);
    sendVideo.layer.cornerRadius = 3.0;
    [sendVideo setTitle:@"我的视频" forState:UIControlStateNormal];
    [sendVideo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendVideo.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [sendVideo addTarget:self action:@selector(sendedVideo:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:sendVideo];
    
    submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(headerView.frame.size.width - 105, headerView.frame.size.height - 35, 90, 30);
    submit.layer.cornerRadius = 3.0;
    [submit setTitle:@"立即发布任务" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submit.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [submit addTarget:self action:@selector(submitTask:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:submit];
    
    userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    userIcon.layer.cornerRadius = userIcon.frame.size.height/2.0f;
    userIcon.clipsToBounds = YES;
    userIcon.layer.borderWidth = 2.0;
    userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    [userIcon setImage:[UIImage imageNamed:@"take_photo"]];
    userIcon.center = CGPointMake(headerView.frame.size.width/2.0f - 60, headerView.frame.size.height/2.0f - 30);
    [headerView addSubview:userIcon];
    [userIcon release];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userIcon.frame.size.width + userIcon.frame.origin.x + 10, userIcon.frame.origin.y + 20, 200, 20)];
    nameLabel.text = @"未登录";
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:17.0f];
    [headerView addSubview:nameLabel];
    [nameLabel release];
    
//-------------------------------------------------------
//---------- 三块位置占比 215:615:215 ---------------------
//-------------------------------------------------------
    sendedView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, 1024, 710 - headerView.frame.size.height)];
    sendedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sendedView];
    [sendedView release];
    
    sendTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 205, sendedView.frame.size.height) style:UITableViewStylePlain];
    sendTable.showsVerticalScrollIndicator = NO;
    sendTable.backgroundColor = [UIColor getColor:@"E4E4E4"];
    sendTable.delegate = self;
    sendTable.dataSource = self;
    sendTable.separatorInset = UIEdgeInsetsZero;
    sendTable.separatorColor = [UIColor clearColor];
    [sendedView addSubview:sendTable];
    [sendTable release];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(sendTable.frame.size.width + 50, 30, 100, 20)];
    name.text = @"任务名称:";
    name.textAlignment = NSTextAlignmentRight;
    name.textColor = [UIColor blackColor];
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:15.0f];
    [sendedView addSubview:name];
    [name release];
    
    taskTitleField = [[UITextField alloc] initWithFrame:CGRectMake(name.frame.origin.x + name.frame.size.width + 15, name.frame.origin.y - 5, 250, 30)];
    [taskTitleField setFont:[UIFont systemFontOfSize:15.0f]];
    taskTitleField.userInteractionEnabled = NO;
    taskTitleField.borderStyle = UITextBorderStyleNone;
    taskTitleField.text = @"新任务";
    [sendedView addSubview:taskTitleField];
    [taskTitleField release];
    
    taskAccount = [[UILabel alloc] initWithFrame:CGRectMake(sendTable.frame.size.width + 50, name.frame.origin.y + name.frame.size.height + 20, 100, 20)];
    taskAccount.text = @"任务发布者:";
    taskAccount.textAlignment = NSTextAlignmentRight;
    taskAccount.textColor = [UIColor blackColor];
    taskAccount.backgroundColor = [UIColor clearColor];
    taskAccount.font = [UIFont systemFontOfSize:15.0f];
    [sendedView addSubview:taskAccount];
    [taskAccount release];
    
    taskAccountName = [[UILabel alloc] initWithFrame:CGRectMake(taskAccount.frame.origin.x + taskAccount.frame.size.width + 15, taskAccount.frame.origin.y, 100, 20)];
    taskAccountName.text = @"任务发布者";
    taskAccountName.textColor = [UIColor blackColor];
    taskAccountName.backgroundColor = [UIColor clearColor];
    taskAccountName.font = [UIFont systemFontOfSize:15.0f];
    [sendedView addSubview:taskAccountName];
    [taskAccountName release];
    
    taskInfo = [[UILabel alloc] initWithFrame:CGRectMake(sendTable.frame.size.width + 50, taskAccount.frame.origin.y + taskAccount.frame.size.height + 20, 100, 20)];
    taskInfo.text = @"任务脚本内容:";
    taskInfo.textAlignment = NSTextAlignmentRight;
    taskInfo.textColor = [UIColor blackColor];
    taskInfo.backgroundColor = [UIColor clearColor];
    taskInfo.font = [UIFont systemFontOfSize:15.0f];
    [sendedView addSubview:taskInfo];
    [taskInfo release];
    
    taskInfoView = [[UITextView alloc] initWithFrame:CGRectMake(taskInfo.frame.origin.x + taskInfo.frame.size.width + 15, taskInfo.frame.origin.y - 8, 400, 200)];
    taskInfoView.delegate = self;
//    taskInfoView.layer.borderWidth = 1.0;
//    taskInfoView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    taskInfoView.text = @"点击右上角上传按钮，先判断是否登录，登录后，出现视频上传界面，如下图。但把左侧的视频列表去掉，只用右侧的界面。右侧的界面中间加一个关联目录的下拉选项，两个下拉框组成，同上，用于确定上传视频的所属分类。其中的关联任务下拉控件和关联目录下拉控件的关系为相互唯一的关系，选了关联任务下方关联目录会自动显示该任务关联的目录，选择了关联目录则关联任务清空，代表是无任务视频。可挑选视频的封面图片供视频列表显示用";
    [taskInfoView setFont:[UIFont systemFontOfSize:15.0]];
    [sendedView addSubview:taskInfoView];
    [taskInfoView release];
    
    userScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(1024 - 204, 0, 204, sendedView.frame.size.height)];
    userScroll.backgroundColor = [UIColor getColor:@"E4E4E4"];
    [sendedView addSubview:userScroll];
    [userScroll release];
    
    sendTask.backgroundColor = [UIColor brownColor];
    newTask.backgroundColor = [UIColor brownColor];
    sendVideo.backgroundColor = [UIColor brownColor];
    submit.backgroundColor = [UIColor brownColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
