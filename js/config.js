/**
 * INSPINIA - Responsive Admin Theme
 *
 * Inspinia theme use AngularUI Router to manage routing and views
 * Each view are defined as state.
 * Initial there are written state for all view in theme.
 *
 */
function config($stateProvider, $urlRouterProvider, $ocLazyLoadProvider) {
    //$urlRouterProvider.otherwise("/index/main");

    $urlRouterProvider.otherwise("/login");

    $ocLazyLoadProvider.config({
        // Set to true if you want to see what and when is dynamically loaded
        debug: false
    });

    $stateProvider

        .state('login', {
            url: "/login",
            templateUrl: "views/login.html",
        })

        .state('index', {
            abstract: true,
            url: "/index",
            templateUrl: "views/common/content.html",
        })
        .state('master', {
            abstract: true,
            url: "/master",
            templateUrl: "views/common/content.html",
        })
        .state('import', {
            abstract: true,
            url: "/import",
            templateUrl: "views/common/content.html",
        })
        .state('entry', {
            abstract: true,
            url: "/entry",
            templateUrl: "views/common/content.html",
        })
        .state('system', {
            abstract: true,
            url: "/system",
            templateUrl: "views/common/content.html",
        })
        .state('inquiry', {
            abstract: true,
            url: "/inquiry",
            templateUrl: "views/common/content.html",
        })
        .state('index.main', {
            url: "/main",
            templateUrl: "views/main.html",
            data: { pageTitle: 'Example view' }
        })
        .state('master.TimeSlot', {
            url: "/TimeSlot",
            templateUrl: "views/master/TimeSlot.html",
        })
        .state('master.HourlyRateMapping', {
            url: "/HourlyRateMapping",
            templateUrl: "views/master/HourlyRateMapping.html",
            data: { pageTitle: 'Example view' }, resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['css/plugins/iCheck/custom.css', 'js/plugins/iCheck/icheck.min.js']
                        }
                    ]);
                }
            }
        })
        .state('master.PayrollGroup', {
            url: "/PayrollGroup",
            templateUrl: "views/master/PayrollGroup.html",
        })
        .state('master.Introducer', {
            url: "/Introducer",
            templateUrl: "views/master/Introducer.html",
        })
        .state('master.Client', {
            url: "/Client",
            templateUrl: "views/master/Client.html",
        })
        .state('master.Worker', {
            url: "/Worker",
            templateUrl: "views/master/Worker.html",
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['css/plugins/iCheck/custom.css', 'js/plugins/iCheck/icheck.min.js']
                        }
                    ]);
                }
            }
        })
        .state('master.TItem', {
            url: "/TItem",
            templateUrl: "views/TItem.html",
            data: { pageTitle: 'Example view' }
        })
        .state('master.minor2', {
            url: "/minor2",
            templateUrl: "views/minor2.html",
            data: { pageTitle: 'Example view' }
        })
        .state('master.master3', {
            url: "/master3",
            templateUrl: "views/master3.html",
            data: { pageTitle: 'Example view' }
        })
        .state('import.Attendance', {
            url: "/Attendance",
            templateUrl: "views/import/Attendance.html",
        })
        .state('entry.entry1', {
            url: "/entry1",
            templateUrl: "views/entry1.html",
            data: { pageTitle: 'Example view' }
        })
        .state('entry.entry2', {
            url: "/entry2",
            templateUrl: "views/entry2.html",
            data: { pageTitle: 'Example view' }
        })
        .state('system.UserProfile', {
            url: "/UserProfile",
            templateUrl: "views/system/UserProfile.html",
        })
        .state('system.ChangePassword', {
            url: "/ChangePassword",
            templateUrl: "views/system/ChangePassword.html",
        })
        .state('inquiry.Inquiry', {
            url: "/Inquiry",
            templateUrl: "views/inquiry/Inquiry.html",
        })
        //.state('test', {
        //    url: "/test",
        //    templateUrl: "views/test.html",
        //    data: { pageTitle: 'Example view' }
        //})
        .state('master.sample', {
            url: "/sample",
            templateUrl: "views/sample.html",
            data: { pageTitle: 'Example view' },
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['css/plugins/iCheck/custom.css', 'js/plugins/iCheck/icheck.min.js']
                        }
                    ]);
                }
            }
        })
        .state('master.sampleChild', {
            url: "/sampleChild",
            templateUrl: "views/sampleChild.html",
            data: { pageTitle: 'Example view' },
            resolve: {
                loadPlugin: function ($ocLazyLoad) {
                    return $ocLazyLoad.load([
                        {
                            files: ['css/plugins/iCheck/custom.css', 'js/plugins/iCheck/icheck.min.js']
                        }
                    ]);
                }
            }
        })
}
angular
    .module('inspinia')
    .config(config).config(['$httpProvider', function ($httpProvider) {
        $httpProvider.interceptors.push('responseObserver');
    }])
    .run(function ($rootScope, $state) {
        $rootScope.$state = $state;
    });
