//
//  AsyncCellImagesExample.m
//  IOSBoilerplate
//
//  Copyright (c) 2011 Alberto Gimeno Brieba
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//  

#import "AsyncCellImagesExample.h"
#import "SVProgressHUD.h"
#import "TwitterSearchClient.h"
#import "AsyncCell.h"
#import "BaiduTopnewsClient.h"
#import "BrowserViewController.h"

#import "JSONKit.h"

@implementation AsyncCellImagesExample

@synthesize table;
@synthesize results;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [results count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AsyncCell *cell = (AsyncCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[AsyncCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary* obj = [results objectAtIndex:indexPath.row];
    [cell updateCellInfo:obj];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary* obj = [results objectAtIndex:indexPath.row];
    NSString *url = [obj objectForKey:@"link"];
    BrowserViewController *bvc = [[BrowserViewController alloc] initWithUrls:url];
    [self.navigationController pushViewController:bvc animated:YES];
    [bvc release];

}
     
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58;
}
 

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"百度风云实讯";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [SVProgressHUD showInView:self.view];
    
//    [[TwitterSearchClient sharedClient] getPath:@"search" parameters:[NSDictionary dictionaryWithObject:@"iOS" forKey:@"q"] success:^(id object) {
//        [SVProgressHUD dismiss];
//        
//        self.results = [object valueForKey:@"results"];
//        [table reloadData];
//    } failure:^(NSHTTPURLResponse *response, NSError *error) {
//        [SVProgressHUD dismissWithError:[error localizedDescription]];
//    }];
//    
    
    [[BaiduTopnewsClient sharedClient] getPath:@"search" parameters:[NSDictionary dictionaryWithObject:@"2" forKey:@"pageno"] success:^(id object) {
        [SVProgressHUD dismiss];
        
        NSArray *f = [object objectFromJSONData];
        
        NSMutableArray *r = [NSMutableArray array];

        for (id i in f) {
            NSArray *newsArr = [i objectForKey:@"news"];
            
            for (NSDictionary *ddd in newsArr) {
                if ([[ddd objectForKey:@"image"] length]>0) {
                    [r addObject:ddd];
                }
            
            }
        }
        
        self.results = r;
        //self.results = [object valueForKey:@"results"];
        [table reloadData];
        
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        [SVProgressHUD dismissWithError:[error localizedDescription]];
    }];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)dealloc {
    [table release];
    [results release];
    
    [super dealloc];
}

@end
