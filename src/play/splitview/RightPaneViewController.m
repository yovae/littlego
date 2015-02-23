// -----------------------------------------------------------------------------
// Copyright 2013-2014 Patrick Näf (herzbube@herzbube.ch)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// -----------------------------------------------------------------------------


// Project includes
#import "RightPaneViewController.h"
#import "../boardposition/BoardPositionButtonBoxDataSource.h"
#import "../boardposition/BoardPositionNavigationManager.h"
#import "../boardview/BoardViewController.h"
#import "../controller/DiscardFutureMovesAlertController.h"
#import "../controller/NavigationBarController.h"
#import "../controller/StatusViewController.h"
#import "../gesture/PanGestureController.h"
#import "../../shared/LayoutManager.h"
#import "../../ui/AutoLayoutUtility.h"
#import "../../ui/ButtonBoxController.h"
#import "../../utility/UiColorAdditions.h"


// -----------------------------------------------------------------------------
/// @brief Class extension with private properties for RightPaneViewController.
// -----------------------------------------------------------------------------
@interface RightPaneViewController()
@property(nonatomic, assign) bool useNavigationBar;
@property(nonatomic, retain) DiscardFutureMovesAlertController* discardFutureMovesAlertController;
@property(nonatomic, retain) BoardViewController* boardViewController;
@property(nonatomic, retain) ButtonBoxController* boardPositionButtonBoxController;
@property(nonatomic, retain) BoardPositionButtonBoxDataSource* boardPositionButtonBoxDataSource;
@end


@implementation RightPaneViewController

#pragma mark - Initialization and deallocation

// -----------------------------------------------------------------------------
/// @brief Initializes a RightPaneViewController object.
///
/// @note This is the designated initializer of RightPaneViewController.
// -----------------------------------------------------------------------------
- (id) init
{
  // Call designated initializer of superclass (UIViewController)
  self = [super initWithNibName:nil bundle:nil];
  if (! self)
    return nil;
  [self setupUseNavigationBar];
  [self setupChildControllers];
  return self;
}

// -----------------------------------------------------------------------------
/// @brief Deallocates memory allocated by this RightPaneViewController object.
// -----------------------------------------------------------------------------
- (void) dealloc
{
  if (self.useNavigationBar)
  {
    self.navigationBarController = nil;
  }
  else
  {
    self.boardPositionButtonBoxController = nil;
    self.boardPositionButtonBoxDataSource = nil;
  }
  self.discardFutureMovesAlertController = nil;
  [super dealloc];
}

// -----------------------------------------------------------------------------
/// @brief Private helper for initializer.
// -----------------------------------------------------------------------------
- (void) setupUseNavigationBar
{
  switch ([LayoutManager sharedManager].uiType)
  {
    case UITypePhone:
    {
      bool isPortraitOrientation = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
      self.useNavigationBar = isPortraitOrientation;
      break;
    }
    default:
    {
      self.useNavigationBar = true;
      break;
    }
  }
}

#pragma mark - Container view controller handling

// -----------------------------------------------------------------------------
/// This is an internal helper invoked during initialization.
// -----------------------------------------------------------------------------
- (void) setupChildControllers
{
  if (self.useNavigationBar)
    self.navigationBarController = [[[NavigationBarController alloc] init] autorelease];
  else
    self.boardPositionButtonBoxController = [[[ButtonBoxController alloc] init] autorelease];
  self.discardFutureMovesAlertController = [[[DiscardFutureMovesAlertController alloc] init] autorelease];
  self.boardViewController = [[[BoardViewController alloc] init] autorelease];

  self.boardViewController.panGestureController.delegate = self.discardFutureMovesAlertController;
  if (self.useNavigationBar)
  {
    self.navigationBarController.delegate = self.discardFutureMovesAlertController;
  }
  else
  {
    self.boardPositionButtonBoxDataSource = [[[BoardPositionButtonBoxDataSource alloc] init] autorelease];
    self.boardPositionButtonBoxController.buttonBoxControllerDataSource = self.boardPositionButtonBoxDataSource;
  }
}

// -----------------------------------------------------------------------------
/// @brief Private setter implementation.
// -----------------------------------------------------------------------------
- (void) setNavigationBarController:(NavigationBarController*)navigationBarController
{
  if (_navigationBarController == navigationBarController)
    return;
  if (_navigationBarController)
  {
    [_navigationBarController willMoveToParentViewController:nil];
    // Automatically calls didMoveToParentViewController:
    [_navigationBarController removeFromParentViewController];
    [_navigationBarController release];
    _navigationBarController = nil;
  }
  if (navigationBarController)
  {
    // Automatically calls willMoveToParentViewController:
    [self addChildViewController:navigationBarController];
    [navigationBarController didMoveToParentViewController:self];
    [navigationBarController retain];
    _navigationBarController = navigationBarController;
  }
}

// -----------------------------------------------------------------------------
/// @brief Private setter implementation.
// -----------------------------------------------------------------------------
- (void) setBoardViewController:(BoardViewController*)boardViewController
{
  if (_boardViewController == boardViewController)
    return;
  if (_boardViewController)
  {
    [_boardViewController willMoveToParentViewController:nil];
    // Automatically calls didMoveToParentViewController:
    [_boardViewController removeFromParentViewController];
    [_boardViewController release];
    _boardViewController = nil;
  }
  if (boardViewController)
  {
    // Automatically calls willMoveToParentViewController:
    [self addChildViewController:boardViewController];
    [boardViewController didMoveToParentViewController:self];
    [boardViewController retain];
    _boardViewController = boardViewController;
  }
}

// -----------------------------------------------------------------------------
/// @brief Private setter implementation.
// -----------------------------------------------------------------------------
- (void) setBoardPositionButtonBoxController:(ButtonBoxController*)boardPositionButtonBoxController
{
  if (_boardPositionButtonBoxController == boardPositionButtonBoxController)
    return;
  if (_boardPositionButtonBoxController)
  {
    [_boardPositionButtonBoxController willMoveToParentViewController:nil];
    // Automatically calls didMoveToParentViewController:
    [_boardPositionButtonBoxController removeFromParentViewController];
    [_boardPositionButtonBoxController release];
    _boardPositionButtonBoxController = nil;
  }
  if (boardPositionButtonBoxController)
  {
    // Automatically calls willMoveToParentViewController:
    [self addChildViewController:boardPositionButtonBoxController];
    [boardPositionButtonBoxController didMoveToParentViewController:self];
    [boardPositionButtonBoxController retain];
    _boardPositionButtonBoxController = boardPositionButtonBoxController;
  }
}

#pragma mark - UIViewController overrides

// -----------------------------------------------------------------------------
/// @brief UIViewController method.
// -----------------------------------------------------------------------------
- (void) loadView
{
  [super loadView];
  [self setupViewHierarchy];
  [self setupAutoLayoutConstraints];
  [self configureViews];
}

#pragma mark - Private helpers for loadView

// -----------------------------------------------------------------------------
/// @brief Private helper for loadView.
// -----------------------------------------------------------------------------
- (void) setupViewHierarchy
{
  [self.view addSubview:self.boardViewController.view];
  if (self.useNavigationBar)
    [self.view addSubview:self.navigationBarController.view];
  else
    [self.view addSubview:self.boardPositionButtonBoxController.view];
}

// -----------------------------------------------------------------------------
/// @brief Private helper for loadView.
// -----------------------------------------------------------------------------
- (void) setupAutoLayoutConstraints
{
  self.automaticallyAdjustsScrollViewInsets = NO;

  self.boardViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
  NSMutableDictionary* viewsDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          self.boardViewController.view, @"boardView",
                                          nil];
  NSMutableArray* visualFormats = [NSMutableArray arrayWithObjects:
                                   @"H:|-0-[boardView]-0-|",
                                   nil];

  if (self.useNavigationBar)
  {
    self.navigationBarController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [viewsDictionary setObject:self.navigationBarController.view forKey:@"navigationBarView"];
    [visualFormats addObject:@"H:|-0-[navigationBarView]-0-|"];
    // Don't need to specify height value for navigationBarView because
    // UINavigationBar specifies a height value in its intrinsic content size
    [visualFormats addObject:@"V:|-0-[navigationBarView]-0-[boardView]-0-|"];
  }
  else
  {
    self.boardPositionButtonBoxController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [viewsDictionary setObject:self.boardPositionButtonBoxController.view forKey:@"buttonBox"];
    [visualFormats addObject:@"V:|-0-[boardView]-0-|"];
    // TODO xxx proper placement
    [visualFormats addObject:[NSString stringWithFormat:@"H:|-15-[buttonBox(==%f)]", self.boardPositionButtonBoxController.buttonBoxSize.width]];
    [visualFormats addObject:[NSString stringWithFormat:@"V:[buttonBox(==%f)]-15-|", self.boardPositionButtonBoxController.buttonBoxSize.height]];
  }

  [AutoLayoutUtility installVisualFormats:visualFormats withViews:viewsDictionary inView:self.view];
}

// -----------------------------------------------------------------------------
/// @brief Private helper for loadView.
// -----------------------------------------------------------------------------
- (void) configureViews
{
  // Set a color (should be the same as the main window's) because we need to
  // paint over the parent split view background color.
  self.view.backgroundColor = [UIColor whiteColor];

  // TODO xxx proper colors
  self.boardPositionButtonBoxController.collectionView.backgroundColor = [UIColor navigationbarBackgroundColor];
  self.boardPositionButtonBoxController.collectionView.layer.borderWidth = 1;
}

@end
