// -----------------------------------------------------------------------------
// Copyright 2013-2015 Patrick Näf (herzbube@herzbube.ch)
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
#import "BoardPositionNavigationManager.h"
#import "CurrentBoardPositionViewController.h"

// Forward declarations
@class BoardPositionListViewController;


// -----------------------------------------------------------------------------
/// @brief The BoardPositionToolbarController class provides a visual
/// representation of the abstract set of board position navigation operations
/// defined by BoardPositionNavigationManager. The visual representation is
/// a toolbar with one button per navigation operation.
///
/// BoardPositionToolbarController is a container view controller on the iPhone,
/// and a child view controller on the iPad. It has the following
/// responsibilities:
/// - Populate the toolbar with controls. This includes knowledge how the
///   controls need to be laid out in the toolbar.
/// - iPhone only: Integrate child view controllers' root views into the toolbar
///   as subviews and use Auto Layout to place them
///
/// BoardPositionToolbarController specifically is @b NOT responsible for
/// managing user interaction with child view controller's root views - this is
/// the job of the respective child view controllers.
///
/// @see BoardPositionNavigationManager
// -----------------------------------------------------------------------------
@interface BoardPositionToolbarController : UIViewController <UIToolbarDelegate,
                                                              CurrentBoardPositionViewControllerDelegate,
                                                              BoardPositionNavigationManagerDelegate>
{
}

@property(nonatomic, retain) BoardPositionListViewController* boardPositionListViewController;
@property(nonatomic, retain) CurrentBoardPositionViewController* currentBoardPositionViewController;

@end
