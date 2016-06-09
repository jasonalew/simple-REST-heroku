//
//  ContactsTableViewController.m
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/7/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "ContactsTableViewCell.h"
#import "Contact.h"
#import "Constants.h"
#import "EditContactViewController.h"

@interface ContactsTableViewController ()
@property (strong, nonatomic) NSIndexPath *selectedIndex;
@property (strong, nonatomic) NSArray *contacts;
@property (strong, nonatomic) ContactsHTTPClient *contactsHTTPClient;

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contacts = [[NSArray alloc]init];
    
    self.contactsHTTPClient = [ContactsHTTPClient sharedContactsHTTPClient];
    
    [self.contactsHTTPClient getAllContacts];
    [self addObservers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.contactsHTTPClient.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [self removeObservers];
}

- (void)updateUI {
    NSLog(@"Updating UI");
    [self.contactsHTTPClient getAllContacts];
    
}

#pragma mark - Observers
- (void)addObservers {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(updateUI) name:updatedContactNotification object:nil];
}

- (void)removeObservers {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:updatedContactNotification object:nil];
}

#pragma mark - ContactsHTTPClient Delegate
- (void)contactsHTTPClient:(ContactsHTTPClient *)client didGetAllContacts:(NSArray *)responseObject {
    self.contacts = responseObject;
    NSLog(@"Contacts All: %@", self.contacts);
    
    [self.tableView reloadData];
}

- (void)contactsHTTPClientDidUpdateContact:(ContactsHTTPClient *)client {
    NSLog(@"Contact Updated");
    if (self.selectedIndex) {
        [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndex] withRowAnimation: UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Contact *contact = [[Contact alloc]init:self.contacts[indexPath.row]];
    cell.contact = contact;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath;
    [self performSegueWithIdentifier:editContactSegueIdentifier sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:editContactSegueIdentifier]) {
        
        if ([segue.destinationViewController isKindOfClass:[EditContactViewController class]]) {
            
            EditContactViewController *editVC = (EditContactViewController *)segue.destinationViewController;
            if ([sender isKindOfClass:[ContactsTableViewCell class]]) {
                
                ContactsTableViewCell *contactsCell = (ContactsTableViewCell *)sender;
                editVC.contact = contactsCell.contact;
            }
        }
    }
}

@end
