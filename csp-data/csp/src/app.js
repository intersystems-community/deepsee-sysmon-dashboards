/**
 * Created by Admin on 05.07.2017.
 */
(function(){
    'use strict';
    angular.module('templates',[]);

    angular.module('app',['ngRoute' ,'cgNotify' , 'ngAnimate', 'templates'])
        .config(['$routeProvider', function ($routeProvider) {
            $routeProvider
                .when('/',{
                    templateUrl: 'src/views/config.html',
                    controller: 'config'
                })
                .when('/email',{
                    templateUrl: 'src/views/email.html',
                    controller: 'email'
                })
                .otherwise({ redirectTo: '/' });
        }])
        .constant('CONST',{
            title: 'SYSMONConfigurator UI',
            version: '{{package.json.version}}',
            protocol: location.protocol,
            host: location.host, /*"localhost:57772",*/
            appname: 'sysmon'
        })
        .run(['notify', function (notify) {
            notify.config({
                duration: 5000,
                position: 'right',
                maximumOpen: 5,
                verticalSpacing: 20,
                startTop: 20
            });
        }]);
})();