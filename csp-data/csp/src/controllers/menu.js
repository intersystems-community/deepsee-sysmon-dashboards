/**
 * Created by Admin on 05.07.2017.
 */
(function(){
    'use strict';

    function MenuCtrl($scope, CONST, $location) {
        $scope.model = {
            title: CONST.title,
            version: CONST.version,
            inPage: {
                _class: true,
                _email: false
            }
        };

        $scope.onClassClick = onClassClick;
        $scope.onEmailClick = onEmailClick;

        checkPage();

        function onEmailClick() {
            $location.path('/email');
            checkPage();
        }

        function onClassClick() {
            $location.path('/');
            checkPage();
        }

        function checkPage() {
            for (var key in $scope.model.inPage) {
                $scope.model.inPage[key] = false;
            }

            var path = $location.path();
            switch (path) {
                case '/': $scope.model.inPage['_class'] = true; break;
                case '/email': $scope.model.inPage['_email'] = true; break;
            }
        }
    }

    angular.module('app').controller('menu',['$scope', 'CONST', '$location', MenuCtrl]);

})();