/**
 * INSPINIA - Responsive Admin Theme
 *
 * Inspinia theme use AngularUI Router to manage routing and views
 * Each view are defined as state.
 * Initial there are written state for all view in theme.
 *
 */
function config($stateProvider, $urlRouterProvider, $ocLazyLoadProvider) {
    $urlRouterProvider.otherwise("/index/main");

    $ocLazyLoadProvider.config({
        // Set to true if you want to see what and when is dynamically loaded
        debug: false
    });

    $stateProvider

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
        .state('entry', {
            abstract: true,
            url: "/entry",
            templateUrl: "views/common/content.html",
        })
        .state('index.main', {
            url: "/main",
            templateUrl: "views/main.html",
            data: { pageTitle: 'Example view' }
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
}
angular
    .module('inspinia')
    .config(config)
    .run(function($rootScope, $state) {
        $rootScope.$state = $state;
    });
