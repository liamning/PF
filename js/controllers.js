/**
 * INSPINIA - Responsive Admin Theme
 *
 */

/**
 * MainCtrl - controller
 */


function LoginCtrl($scope, $http, $state, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.loginObj = {
        };


    })();

    $scope.login = function () {
        //if ($scope.userForm.$invalid) return; 
        $http({
            method: 'POST',
            url: 'HttpHandler/LoginHandler.ashx',
            data: $.param({
                action: "login",
                UserID: $scope.loginObj.UserID,
                Password: $scope.loginObj.Password
            }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {

            console.log("success");

            if (response.result == "1") {
                $rootScope.LoginInfo = {
                    UserID: $scope.loginObj.UserID
                };
                window.LoginInfo = $rootScope.LoginInfo;
                $state.go("index.main");
            }

            else {
                alert('Invalid User ID or Password');
            }
        });

    };

    $rootScope.LoginInfo = window.LoginInfo;

}

function MainCtrl($scope, $state, $http, $rootScope) {

    //$scope.loginID = "Administrator";

    $scope.refresh_ui_select_list = {};
    $scope.refresh_ui_select = function (table, input, limit, includeInput, callback) {
        if (limit && (!input || input.length < limit)) return;
        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({ action: "refreshList", Table: table, Input: input }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {

            //console.log('refresh_ui_select [' + table + '] [Done].');

            if (response) {
                $scope.refresh_ui_select_list[table] = response;
                if (response && input && includeInput)
                    response.unshift({
                        'Code': input,
                        'Desc': input,
                    });
            }
            if (callback)
                callback(response);
        });

    }
    $scope.ui_select_change = function (table) {
        $scope.refresh_ui_select_list[table].length = 0;
    }


    $scope.generalMaster = {};
    $scope.getGeneralMasterList = function (categories, callback) {
        var index;
        for (var pro in $scope.generalMaster) {
            index = categories.indexOf(pro);
            if (index >= 0) {
                categories.splice(index, 1);
            }
        }

        if (categories.length == 0) return;

        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({ action: "getGeneralMasterList", categories: JSON.stringify(categories) }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {
            if (response) {

                for (pro in response) {
                    if ($scope.generalMaster[pro]) $scope.generalMaster[pro].length = 0;
                    $scope.generalMaster[pro] = response[pro];
                }
                console.log($scope.generalMaster);
            }

            if (callback)
                callback(response);
        });
    }

    $scope.postToServer = function (input) {

        $http({
            method: 'POST',
            url: input.url ? input.url : 'HttpHandler/BatchHandler.ashx',
            data: $.param({ params: JSON.stringify(input.data) }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {
            if (response.error) {
                alert(response.error);
                return;
            }
            for (var pro in response) {
                if (response[pro])
                    response[pro] = JSON.parse(response[pro]);
            }

            if (input.callback)
                input.callback(response);
        });

    }

    $rootScope.LoginInfo = window.LoginInfo;
    $rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
        console.log(fromState.name);
        if (fromState.name == "login") return;

        if (!$rootScope.LoginInfo.UserID && toState.name != "login") {
            event.preventDefault();
            return $state.go('login');
        }
        return;
    });
};

function SampleCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.sampleObj = {
        };
        $scope.editMode = [];

        $scope.templateURL = {
            name: "Sample",
            url: 'views/sampleHeader.html',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        $scope.getGeneralMasterList(["Relationship"]);

    })();

    //event 
    $scope.addChild = function () {
        if (!$scope.sampleObj.ChildList)
            $scope.sampleObj.ChildList = [];
        $scope.sampleObj.ChildList.push({
        });

    }

    $scope.editChild = function (child) {

        $scope.currentChild = child;

        $scope.templateURL.name = 'Child Details';
        $scope.templateURL.url = 'views/sampleChild.html';

        $scope.templateURL.pageNo++;
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };
    }

    $scope.removeChild = function (child) {
        for (var i = 0; i < $scope.sampleObj.ChildList.length; i++) {
            var obj = $scope.sampleObj.ChildList[i];

            if (obj.ID == child.ID) {
                $scope.sampleObj.ChildList.splice(i, 1);
            }
        }

    }

    $scope.save = function () {

        if ($scope.userForm && $scope.userForm.$invalid) return;

        $scope.postToServer({
            data: [{
                action: "saveSample",
                SampleInfo: JSON.stringify($scope.sampleObj)
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["saveSample"].message);
            }
        });



    };

    $scope.delete = function () {

        if (!$scope.sampleObj.ClientNo) return;

        $.ajax({
            url: "/HttpHandler/AjaxHandler.ashx",
            type: 'POST',
            data: {
                action: "deleteSample",
                ClientNo: $scope.sampleObj.ClientNo
            },
            dataType: "json",
            error: function (xhr) {
                //console.log("failed");
            },
            success: function (response) {
                alert(response.message);
                //console.log("success");
            }
        });
    };

    $scope.sampleIDChange = function () {
        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({ action: "getSample", SampleNo: $scope.sampleObj.SampleNo }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {
            //console.log(response);
            if (response)
                $scope.sampleObj = response;
            else {
                confirm("Confirm to Create a new record?")
                $scope.sampleObj = {
                    SampleNo: $scope.sampleObj.SampleNo,
                };
            }

            //console.log($scope.sampleObj);

        });

    }

}

function SampleChildCtrl($scope, $http, $window) {


    $scope.confirm = function () {

        $scope.viewsList.splice($scope.templateURL.pageNo, 1);

        $scope.templateURL.pageNo--;
        var currentView = $scope.viewsList[$scope.templateURL.pageNo];

        $scope.templateURL.name = currentView.name;
        $scope.templateURL.url = currentView.url;

    };

    $scope.cancel = function () {

        $scope.viewsList.splice($scope.templateURL.pageNo, 1);

        $scope.templateURL.pageNo--;
        var currentView = $scope.viewsList[$scope.templateURL.pageNo];

        $scope.templateURL.name = currentView.name;
        $scope.templateURL.url = currentView.url;

    };
}

function TimeSlotCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.timeSlotObj = {
        };
        $scope.editMode = [];

        $scope.templateURL = {
            name: "Time Slot",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        $scope.getGeneralMasterList(["TimeSlotType"]);

    })();

    $scope.timeSlotIDChange = function () {


        $scope.postToServer({
            data: [{
                action: "getTimeSlot",
                TimeSlotCode: $scope.timeSlotObj.TimeSlotCode
            }],
            callback: function (response) {
                response = response["getTimeSlot"];

                if (response)
                    $scope.timeSlotObj = response;
                else {
                    confirm("Confirm to Create a new record?")
                    $scope.timeSlotObj = {
                        TimeSlotCode: $scope.timeSlotObj.TimeSlotCode,
                    };
                }

                //console.log($scope.timeSlotObj);
            }
        });


    }

    $scope.save = function () {
        $scope.submitted = true;
        if ($scope.userForm.$invalid) return;

        $scope.postToServer({
            data: [{
                action: "saveTimeSlot",
                TimeSlotInfo: JSON.stringify($scope.timeSlotObj)
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["saveTimeSlot"].message);
            }
        });
    };

    $scope.delete = function () {

        if (!$scope.timeSlotObj.TimeSlotCode) return;

        $scope.postToServer({
            data: [{
                action: "deleteTimeSlot",
                TimeSlotCode: $scope.timeSlotObj.TimeSlotCode
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["deleteTimeSlot"].message);
            }
        });
    };

}

function ClientCtrl($scope, $http, $document, $timeout, $rootScope, $state) {

    var vm = this;

    //object initialization
    (function () {
        $scope.clientObj = {
        };
        $scope.editMode = [];

        $scope.templateURL = {
            name: "Client",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        $scope.getGeneralMasterList(["ClientType"]);

    })();

    $scope.clientIDChange = function () {


        $scope.postToServer({
            data: [{
                action: "getClient",
                ClientCode: $scope.clientObj.ClientCode
            }],
            callback: function (response) {
                response = response["getClient"];

                if (response)
                    $scope.clientObj = response;
                else {
                    confirm("Confirm to Create a new record?")
                    $scope.clientObj = {
                        ClientCode: $scope.clientObj.ClientCode,
                    };
                }

            }
        });


    }

    $scope.save = function () {
        $scope.submitted = true;
        if ($scope.userForm.$invalid) return;

        $scope.postToServer({
            data: [{
                action: "saveClient",
                ClientInfo: JSON.stringify($scope.clientObj)
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["saveClient"].message);
            }
        });
    };

    $scope.delete = function () {

        if (!$scope.clientObj.ClientCode) return;

        $scope.postToServer({
            data: [{
                action: "deleteClient",
                ClientCode: $scope.clientObj.ClientCode
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["deleteClient"].message);
            }
        });
    };

    $scope.import = function () {

        if (!$scope.clientObj.ClientCode) return;
        $rootScope.clientObj = $scope.clientObj;
        $state.go("import.Attendance");
    };

}

function IntroducerCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.introducerObj = {
        };
        $scope.editMode = [];

        $scope.templateURL = {
            name: "Introducer",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        //$scope.getGeneralMasterList(["TimeSlotType"]);

    })();

    $scope.introducerIDChange = function () {

        $scope.postToServer({
            data: [{
                action: "getIntroducer",
                IntroducerCode: $scope.introducerObj.IntroducerCode
            }],
            callback: function (response) {
                response = response["getIntroducer"];

                if (response)
                    $scope.introducerObj = response;
                else {
                    confirm("Confirm to Create a new record?")
                    $scope.introducerObj = {
                        IntroducerCode: $scope.introducerObj.IntroducerCode,
                    };
                }

                //console.log($scope.introducerObj);
            }
        });

    }

    $scope.save = function () {
        $scope.submitted = true;
        if ($scope.userForm.$invalid) return;

        $scope.postToServer({
            data: [{
                action: "saveIntroducer",
                IntroducerInfo: JSON.stringify($scope.introducerObj)
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["saveIntroducer"].message);
            }
        });
    };

    $scope.delete = function () {

        if (!$scope.introducerObj.IntroducerCode) return;

        $scope.postToServer({
            data: [{
                action: "deleteIntroducer",
                IntroducerCode: $scope.introducerObj.IntroducerCode
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["deleteIntroducer"].message);
            }
        });
    };

}

function WorkerCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.workerObj = {
        };
        $scope.editMode = [];
        $scope.btn1Class = 'active';
        $scope.templateURL = {
            name: "Worker",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        $scope.getGeneralMasterList(["WorkerType"]);

    })();

    $scope.workerIDChange = function () {

        $scope.postToServer({
            data: [{
                action: "getWorker",
                WorkerID: $scope.workerObj.WorkerID
            }],
            callback: function (response) {
                response = response["getWorker"];

                if (response) {
                    $scope.workerObj = response;
                    $scope.refresh_ui_select('Introducer', $scope.workerObj.Introducer, 0);
                    $scope.refresh_ui_select('PayrollGroup', $scope.workerObj.PayrollGroup, 0);
                }
                else {
                    confirm("Confirm to Create a new record?")
                    $scope.workerObj = {
                        WorkerID: $scope.workerObj.WorkerID,
                    };
                }

            }
        });

    }

    $scope.save = function () {
        $scope.submitted = true;
        if ($scope.userForm.$invalid) return;

        $scope.postToServer({
            data: [{
                action: "saveWorker",
                WorkerInfo: JSON.stringify($scope.workerObj)
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["saveWorker"].message);
            }
        });
    };

    $scope.delete = function () {

        if (!$scope.workerObj.WorkerID) return;

        $scope.postToServer({
            data: [{
                action: "deleteWorker",
                WorkerID: $scope.workerObj.WorkerID
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["deleteWorker"].message);
            }
        });
    };

    $scope.$watch('workerObj.DOB', function (newval, oldval) {
        if (!$scope.workerObj.DOB) return;
        var dateOfBirth = moment($scope.workerObj.DOB, 'DD/MM/YYYY HH:mm:ss').toDate();
        $scope.workerObj.Age = parseInt(moment().diff(dateOfBirth, 'years', true)) + 1;
    }, true);
}

function PayrollGroupCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.payrollGroupObj = {
        };
        $scope.editMode = [];

        $scope.templateURL = {
            name: "PayrollGroup",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        //$scope.getGeneralMasterList(["TimeSlotType"]);

    })();

    $scope.payrollGroupIDChange = function () {

        $scope.postToServer({
            data: [{
                action: "getPayrollGroup",
                PayrollGroupID: $scope.payrollGroupObj.PayrollGroupID
            }],
            callback: function (response) {
                response = response["getPayrollGroup"];

                if (response)
                    $scope.payrollGroupObj = response;
                else {
                    confirm("Confirm to Create a new record?")
                    $scope.payrollGroupObj = {
                        PayrollGroupID: $scope.payrollGroupObj.PayrollGroupID,
                    };
                }

                //console.log($scope.payrollGroupObj);
            }
        });

    }

    $scope.save = function () {
        $scope.submitted = true;
        if ($scope.userForm.$invalid) return;

        $scope.postToServer({
            data: [{
                action: "savePayrollGroup",
                PayrollGroupInfo: JSON.stringify($scope.payrollGroupObj)
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["savePayrollGroup"].message);
            }
        });
    };

    $scope.delete = function () {

        if (!$scope.payrollGroupObj.PayrollGroupID) return;

        $scope.postToServer({
            data: [{
                action: "deletePayrollGroup",
                PayrollGroupID: $scope.payrollGroupObj.PayrollGroupID
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["deletePayrollGroup"].message);
            }
        });
    };

}

function AttendanceImportCtrl($scope, $http, $document, $timeout, $rootScope, $state) {

    var vm = this;

    //object initialization
    (function () {
        if ($rootScope.clientObj) {
            $scope.clientObj = $rootScope.clientObj;
            $rootScope.clientObj = undefined;
        } else {
            $state.go("master.Client");
        }
        $scope.editMode = [];

        $scope.templateURL = {
            name: "Attendance Import",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

    })();

    $scope.import = function () {
        var f = document.getElementById('attendanceFile').files[0];
        var formData = new FormData();
        formData.append("action", "attendanceImport");
        formData.append("ClientCode", $scope.clientObj.ClientCode);
        formData.append("file", f);

        $http({
            method: 'POST',
            url: 'HttpHandler/FileUpload.ashx',
            data: formData,
            headers: { 'Content-Type': undefined }
        }).success(function (response) {


        });
    };

}

function UserProfileCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.userProfileObj = {
        };
        $scope.editMode = [];

        $scope.templateURL = {
            name: "User Profile",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        //$scope.getGeneralMasterList(["TimeSlotType"]);

    })();

    $scope.userProfileIDChange = function () {

        $scope.postToServer({
            data: [{
                action: "getUserProfile",
                UserID: $scope.userProfileObj.UserID
            }],
            callback: function (response) {
                response = response["getUserProfile"];

                if (response)
                    $scope.userProfileObj = response;
                else {
                    confirm("Confirm to Create a new record?")
                    $scope.userProfileObj = {
                        UserID: $scope.userProfileObj.UserID,
                    };
                }

                //console.log($scope.userProfileObj);
            }
        });

    }

    $scope.save = function () {
        $scope.submitted = true;
        if ($scope.userForm.$invalid) return;

        $scope.postToServer({
            data: [{
                action: "saveUserProfile",
                UserProfileInfo: JSON.stringify($scope.userProfileObj)
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["saveUserProfile"].message);
            }
        });
    };

    $scope.delete = function () {

        if (!$scope.userProfileObj.UserID) return;

        $scope.postToServer({
            data: [{
                action: "deleteUserProfile",
                UserID: $scope.userProfileObj.UserID
            }],
            callback: function (response) {
                //console.log(response);
                alert(response["deleteUserProfile"].message);
            }
        });
    };

}

function ChangePasswordCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.changePasswordObj = {
        };
        $scope.editMode = [];

        $scope.templateURL = {
            name: "Change Password",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };


    })();


    $scope.change = function () {
        $scope.submitted = true;
        if ($scope.userForm.$invalid) return;
        if ($scope.changePasswordObj.NewPassword != $scope.changePasswordObj.ConfirmPassword) {
            alert("New password not equal to confirm password.");
            return;
        }

        $scope.postToServer({
            data: [{
                action: "changePassword",
                CurrentPassword: $scope.changePasswordObj.CurrentPassword,
                NewPassword: $scope.changePasswordObj.NewPassword,
            }],
            callback: function (response) {
                alert(response["changePassword"].message);
            }
        });
    };

}

function InquiryCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.inquiryObj = {
        };

        $scope.templateURL = {
            name: "Inquiry",
            url: 'views/inquiry/Inquiry_Criteria.html',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        };

        $scope.criterias = [{
            displayName: "WorkerID",
            field: 'WorkerID',
            value: '',
            type: 'select',
            table: 'Worker',
        }, {
            displayName: "Payroll Group",
            field: 'PayrollGroup',
            value: '',
            type: 'select',
            table: 'PayrollGroup',
        }, {
            displayName: "Field 2",
            field: 'Field2',
            value: ''
        }];

        $scope.view = "V_Worker";


    })();

    $scope.refresh = function () {

        for (var i = 0, item; item = $scope.criterias[i]; i++) {
            if (item.table && item.value)
                $scope.refresh_ui_select(item.table, item.value, 0);
        }
    };

    $scope.reset = function () {

        for (var i = 0, item; item = $scope.criterias[i]; i++) {
            item.value = '';
        }
    }
    $scope.search = function () {
        var filters = [];
        var tmp;
        for (var i = 0, item; item = $scope.criterias[i]; i++) {
            if (item.value) {
                tmp = {};
                tmp[item.field] = item.value;
                filters.push(tmp);
            }
        }

        $scope.postToServer({
            data: [{
                action: "inquiry",
                Filters: JSON.stringify(filters),
                View: $scope.view,
            }],
            callback: function (response) {
                //alert(response["inquiry"].message);
                console.log(response['inquiry']);

                $scope.result = response['inquiry'];
                if ($scope.result.length) {
                    $scope.header = $scope.result[0];
                }


                $scope.templateURL.name = 'Result';
                $scope.templateURL.url = 'views/inquiry/Inquiry_Result.html';

                $scope.templateURL.pageNo++;
                $scope.viewsList[$scope.templateURL.pageNo] = {
                    name: $scope.templateURL.name,
                    url: $scope.templateURL.url
                };
            }
        });


    }
}

function HourlyRateMappingCtrl($scope, $http, $document, $timeout, $rootScope) {

    var vm = this;

    //object initialization
    (function () {
        $scope.hourlyRateMapping = [];

        $scope.editMode = [];

        $scope.templateURL = {
            name: "Hourly Rate Mapping",
            url: '',
            pageNo: 0
        };

        $scope.viewsList = [];
        $scope.viewsList[$scope.templateURL.pageNo] = {
            name: $scope.templateURL.name,
            url: $scope.templateURL.url
        }; 


        $scope.getGeneralMasterList(["Gender", "YN", "Session"]);
    })();

    $scope.refresh = function () {

        for (var i = 0, item; item = $scope.criterias[i]; i++) {
            if (item.table && item.value)
                $scope.refresh_ui_select(item.table, item.value, 0);
        }
    };

    $scope.save = function () {

        $scope.postToServer({
            data: [{
                action: "saveHourlyRateMapping",
                HourlyRateMapping: $scope.hourlyRateMapping,
            }],
            callback: function (response) {
                var result = response['saveHourlyRateMapping'];
                alert(result.message);
                 

            }
        });

    }
    $scope.get = function () {
       
        $scope.postToServer({
            data: [{
                action: "getHourlyRateMapping",  
            }],
            callback: function (response) { 
                console.log(response['getHourlyRateMapping']);

                var result = response['getHourlyRateMapping']; 
                if (result && result.length) {
                    $scope.hourlyRateMapping = result;
                }
                
            }
        });


    }

    //event 
    $scope.addChild = function () {
        if (!$scope.hourlyRateMapping)
            $scope.hourlyRateMapping = [];
        $scope.hourlyRateMapping.push({
            StoreCode: ' ',
            Gender: 'Male'
        });

    }
     
    $scope.removeChild = function (child, $index) {
        $scope.hourlyRateMapping.splice($index, 1); 
    }

    $scope.get();
}



angular
    .module('inspinia')
    .factory('responseObserver', function responseObserver($q, $window) {
        return {
            'responseError': function (errorResponse) {
                switch (errorResponse.status) {
                    case 403:
                        $window.location = '/';
                        break;
                    case 500:
                        $window.location = '/';
                        break;
                }
                return $q.reject(errorResponse);
            }
        };
    })
    .controller('LoginCtrl', LoginCtrl)
    .controller('MainCtrl', MainCtrl)
    .controller('SampleCtrl', SampleCtrl)
    .controller('SampleChildCtrl', SampleChildCtrl)
    .controller('TimeSlotCtrl', TimeSlotCtrl)
    .controller('IntroducerCtrl', IntroducerCtrl)
    .controller('ClientCtrl', ClientCtrl)
    .controller('WorkerCtrl', WorkerCtrl)
    .controller('PayrollGroupCtrl', PayrollGroupCtrl)
    .controller('AttendanceImportCtrl', AttendanceImportCtrl)
    .controller('UserProfileCtrl', UserProfileCtrl)
    .controller('ChangePasswordCtrl', ChangePasswordCtrl)
    .controller('InquiryCtrl', InquiryCtrl) 
    .controller('HourlyRateMappingCtrl', HourlyRateMappingCtrl) 