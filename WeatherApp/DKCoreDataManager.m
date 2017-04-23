//
//  DKLocationManager.m
//  WeatherApp
//
//  Created by Denis on 20.04.17.
//  Copyright © 2017 Denis. All rights reserved.
//

#import "DKCoreDataManager.h"


static NSString * const EntityInfo = @"InfoEntity";

@interface DKCoreDataManager ()

@property (nonatomic,strong)NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong)NSManagedObjectContext *managedObjectContext;


@end

@implementation DKCoreDataManager

+(DKCoreDataManager*)sharedInstance
{
    static DKCoreDataManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[DKCoreDataManager alloc]init];
        
    });
    
    return sharedInstance;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self managedObjectContextWithCoreDataName:@"WeatherApp" sqliteName:@"CoreDataSqlite"];
        
    }
    return self;
}



- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if (managedObjectContext.hasChanges && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

#pragma mark - Info

-(void)saveInfo:(DKInfoModel*)info {
    
    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"empty"];
    
    NSManagedObjectContext *context = (self.fetchedResultsController).managedObjectContext;
    
    InfoEntity *entity = [[InfoEntity alloc] initWithContext:context];
    
    entity.city = info.city;
    entity.temp = info.temp;
    entity.time = info.date;
    entity.adress = info.adress;
    
    [self saveContext];
    
}


-(DKInfoModel*)convertInfoEntityToModelAtIndex:(NSIndexPath*)index {
    
    InfoEntity* infoEntity = [self.fetchedResultsController objectAtIndexPath:index];
    
    DKInfoModel*infoObj = [DKInfoModel new];
    
    infoObj.city = infoEntity.city;
    infoObj.temp = infoEntity.temp;
    infoObj.date = infoEntity.time;
    infoObj.adress = infoEntity.adress;
    
    return infoObj;
    
}



#pragma mark - CreateCoreData

- (NSManagedObjectContext *)managedObjectContextWithCoreDataName:(NSString *)coreDataName
                                                      sqliteName:(NSString *)sqliteName
{
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinatorWithCoreDataName:coreDataName sqliteName:sqliteName];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = coordinator;
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithCoreDataName:(NSString *)coreDataName
                                                                  sqliteName:(NSString *)sqliteName
{
    NSURL *storeURL = [[self applicationLibraryDirectory] URLByAppendingPathComponent:sqliteName];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModelWithCoreDataName:coreDataName]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error])
    {
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModelWithCoreDataName:(NSString *)coreDataName
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:coreDataName
                                              withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSURL *)applicationLibraryDirectory
{
    NSString *coreDataDirPath = [NSString stringWithFormat:
                                 @"%@/%@",
                                 NSHomeDirectory(),
                                 @"Library"];
    return [NSURL fileURLWithPath:coreDataDirPath];
}

- (NSFetchedResultsController<InfoEntity *> *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<InfoEntity *> *fetchRequest = InfoEntity.fetchRequest;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO];
    
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController<InfoEntity *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {}

@end
