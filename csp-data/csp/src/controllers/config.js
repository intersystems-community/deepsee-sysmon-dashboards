/**
 * Created by Admin on 05.07.2017.
 */
(function(){
    'use strict';

    function ConfigCtrl($scope, $http, CONST, notify) {
        $scope.model = {
            classes: []
        };

        $scope.classChk=classChk;
        $scope.docLoc=docLoc;
        $scope.startMon=startMon;
        $scope.stopMon=stopMon;

        checkMon();
        getClasses();

        function classChk(index) {
            var _class = $scope.model.classes[index];
            $http({
                method: 'POST',
                url: CONST.protocol + "//" + CONST.host + "/" + CONST.appname + "/class",
                data: {classname: _class.name, check: _class.checked}
            }).then(function success(response) {
                notify({
                    message: 'Class status has been changed.',
                    classes: 'alert-success'
                });
            }, function error(response) {
                if (response.status = 500) {
                    notify({
                        message: response.data.summary,
                        classes: 'alert-danger'
                    });
                } else {
                    notify({
                        message: response.status+" "+response.statusText,
                        classes: 'alert-danger'
                    });
                }
            });
        }

        function docLoc(index) {
            var newloc = CONST.protocol + '//' + CONST.host
                + '/csp/documatic/%25CSP.Documatic.cls?PAGE=CLASS&LIBRARY=%25SYS&CLASSNAME=%25'
                + $scope.model.classes[index].name.split('%')[1];

            window.open(newloc,"_blank","");
        }

        function startMon() {
            var btn_panel =angular.element(document.getElementById('btn_panel'));
            var start_btn = angular.element(btn_panel.children()[0]);
            var stop_btn = angular.element(btn_panel.children()[1]);

            start_btn.toggleClass('disabled');
            $http({
                method: 'POST',
                url: CONST.protocol + "//" + CONST.host + "/" + CONST.appname + "/mon",
                data: {toggle: 1}
            }).then(function success(response) {
                stop_btn.toggleClass('disabled');
                notify({
                    message: 'Monitor has been started.',
                    classes: 'alert-success'
                });
            }, function error(response) {
                start_btn.toggleClass('disabled');
                if (response.status = 500) {
                    notify({
                        message: response.data.summary,
                        classes: 'alert-danger'
                    });
                } else {
                    notify({
                        message: response.status+" "+response.statusText,
                        classes: 'alert-danger'
                    });
                }
            });
        }

        function stopMon() {
            var btn_panel =angular.element(document.getElementById('btn_panel'));
            var start_btn = angular.element(btn_panel.children()[0]);
            var stop_btn = angular.element(btn_panel.children()[1]);

            stop_btn.toggleClass('disabled');
            $http({
                method: 'POST',
                url: CONST.protocol + "//" + CONST.host + "/" + CONST.appname + "/mon",
                data: {toggle: 0}
            }).then(function success(response) {
                start_btn.toggleClass('disabled');
                notify({
                    message: 'Monitor has been stopped.',
                    classes: 'alert-success'
                });
            }, function error(response) {
                stop_btn.toggleClass('disabled');
                if (response.status = 500) {
                    notify({
                        message: response.data.summary,
                        classes: 'alert-danger'
                    });
                } else {
                    notify({
                        message: response.status+" "+response.statusText,
                        classes: 'alert-danger'
                    });
                }
            });
        }

        function getClasses() {
            $http({
                method: 'GET',
                url: CONST.protocol + "//" + CONST.host + "/" + CONST.appname + "/classes"
            }).then(function success(response) {
                var data = response.data;
                for (var i = 0; i < data.classes.length; i++) {
                    $scope.model.classes.push({
                        name: data.classes[i].name,
                        checked: !!data.classes[i].checked
                    });
                }
            }, function error(response) {
                if (response.status = 500) {
                    notify({
                        message: response.data.summary,
                        classes: 'alert-danger'
                    });
                } else {
                    notify({
                        message: response.data,
                        classes: 'alert-danger'
                    });
                }
            });
        }

        function checkMon() {
            var btn_panel =angular.element(document.getElementById('btn_panel'));
            var start_btn = angular.element(btn_panel.children()[0]);
            var stop_btn = angular.element(btn_panel.children()[1]);
            start_btn.toggleClass('disabled');
            stop_btn.toggleClass('disabled');

            $http({
                method: 'GET',
                url: CONST.protocol + "//" + CONST.host + "/" + CONST.appname + "/mon"
            }).then(function success(response) {
                var data = response.data;
                if (data.runned !== 0) {
                    stop_btn.removeClass('disabled');
                } else {
                    start_btn.removeClass('disabled');
                }
            }, function error(response) {
                if (response.status = 500) {
                    notify({
                        message: response.data.summary,
                        classes: 'alert-danger'
                    });
                } else {
                    notify({
                        message:  response.data,
                        classes: 'alert-danger'
                    });
                }
            });
        }
    }

    angular.module('app').controller('config',['$scope', '$http', 'CONST', 'notify', ConfigCtrl]);
})();