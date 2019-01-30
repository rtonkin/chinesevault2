angular.module('putonghua')
    .directive('suggestedWordForm', function($http, api) {
      return {
      	restrict: 'E',
        template:   
                  '<div layout="column" layout-align="center">'+
										'<div class="alert alert-success" ng-hide="!isFormSubmitted">' +
											'<p style="font-weight:bold">Thank you for your valued input. Your suggestions will be considered for inclusion in the database.</p>' +
											'<div flex class="mtb20px">'+
												'<div layout="row" layout-align="center center">'+
													'<a ui-sref="dictionary" class="md-primary light-blue-btn md-raised md-button md-ink-ripple">Continue</a>'+
												'</div>'+
											'</div>'+
										'</div>'+
										'<div class="text-center">' +
											' <p class="mtb10px" ng-hide="isFormSubmitted">Please enter the Chinese, pinyin (if known) and English. Your submission will be considered for inclusion in the dictionary. Thank you!</p>' +
										'</div>' +
										'<md-content ng-hide="isFormSubmitted">' +
											'<form class="form-horizontal word-add" ng-submit="submit()" name="wordsForm" novalidate>'+
												'<fieldset ng-repeat="form in wordsForm">' +
													'<div layout-gt-xs="row" layout-align="center center" class="profile-box mb10px">'+
														'<div flex="100" flex-gt-xs="25" ng-cloak class="text-right" >'+
															'<label for="chinese">Chinese <span class="required">*</span></label>'+
														'</div>'+
														'<div flex="100" flex-gt-sm="80" ng-cloak >'+
															'<md-input-container md-no-float class="md-block" >'+
																'<input type="text" id="chinese" placeholder="Enter chinese" ng-model="form.chinese" required>'+
															'</md-input-container> '+
														'</div>'+
													'</div>'+
													'<div layout-gt-xs="row" layout-align="center center" class="profile-box mb10px">'+
														'<div flex="100" flex-gt-xs="25" ng-cloak class="text-right" >'+
															'<label for="pinyin">Pinyin </label>'+
														'</div>'+
														'<div flex="100" flex-gt-sm="80" ng-cloak >'+
															'<md-input-container md-no-float class="md-block" >'+
																'<input type="text" id="pinyin" ng-model="form.pinyin" placeholder="Enter pinyin">'+
															'</md-input-container> '+
														'</div>'+
													'</div>'+
													'<div layout-gt-xs="row" layout-align="center center" class="profile-box mb10px">'+
														'<div flex="100" flex-gt-xs="25" ng-cloak class="text-right" >'+
															'<label for="english">English </label>'+
														'</div>'+
														'<div flex="100" flex-gt-sm="80" ng-cloak >'+
															'<md-input-container md-no-float class="md-block" >'+
																'<input type="text" id="english" ng-model="form.english" placeholder="Enter english">'+
															'</md-input-container> '+
														'</div>'+
													'</div>'+
												'</fieldset>'+
												'<div class="m1b10px" layout="row" layout-align="center">'+
													' class="md-primary md-raised light-blue-btn " type="button" ng-click="addForm(form)" ng-hide=" wordsForm.length > 4" >Add Another Word</md-button>'+
													' class="md-primary md-raised light-blue-btn " type="button" ng-click="deleteForm(form)" ng-show="wordsForm.length > 1">Delete Last Word</md-button>'+									
													' type="submit" class="md-primary md-raised light-blue-btn ">Submit</md-button>'+
												'</div>'+
											'</form>'+
										'</md-content>'+
									'</div>',
									  	
    	link: function($scope, element, attrs) {
    		var wordsForm = $scope.wordsForm = [];
        $scope.isFormSubmitted = false;
    		{ wordsForm.push({ /* don't need anything here */ }); };
        if(wordsForm.length >= 4) {
        }
    		$scope.addForm = function() {
    			if(wordsForm.length < 5) {
    				{ wordsForm.push({ /* don't need anything here */ }); };
    			} if(wordsForm.length > 4) {
            $scope.canAddFields = false;
          }
    		}

        $scope.deleteForm = function() {
          wordsForm.length = wordsForm.length - 1;
        }

    		$scope.submit = function () {
          $scope.isFormSubmitted = true;
  				for(var i = 0; i < wordsForm.length; i++) {
            api.addWords(wordsForm[i].chinese, wordsForm[i].english, wordsForm[i].pinyin);
          }
        };
    	}
    };
  });