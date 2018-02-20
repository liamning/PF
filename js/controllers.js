/**
 * INSPINIA - Responsive Admin Theme
 *
 */

/**
 * MainCtrl - controller
 */
function MainCtrl($scope, $state, $http) {

    $scope.loginID = "Administrator";

    $scope.refresh_ui_select_list = {};
    $scope.refresh_ui_select = function (table, input, limit, includeInput, callback) {
        if (limit && (!input || input.length < limit)) return;
        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({ action: "refreshList", Table: table, Input: input }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {

            console.log('refresh_ui_select [' + table + '] [Done].');

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
            if (index < 0) {
                $scope.generalMaster[pro].length = 0;
            } else {
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

                for (pro in response)
                    $scope.generalMaster[pro] = response[pro];

                console.log($scope.generalMaster);
            }

            if (callback)
                callback(response);
        });
    }


};


function SampleCtrl($scope, $http) {

    var vm = this;

    //object initialization
    (function () { 
        $scope.sampleObj = {
        };
          
        $scope.getGeneralMasterList(["Relationship"]);

    })();


    //event 
    $scope.addStaff = function () {
        if (!$scope.sampleObj.ChildList)
            $scope.sampleObj.ChildList = [];
        $scope.sampleObj.ChildList.push({
        });

    }

    $scope.removeStaff = function (staff) {
        for (var i = 0; i < $scope.sampleObj.StaffList.length; i++) {
            var obj = $scope.sampleObj.StaffList[i];

            if (obj.ID == staff.ID) {
                $scope.sampleObj.StaffList.splice(i, 1);
            }
        }

    }

    $scope.save = function () {

        if ($scope.userForm.$invalid) return; 

        $http({
            method: 'POST',
            url: 'HttpHandler/AjaxHandler.ashx',
            data: $.param({
                action: "saveSample",
                SampleInfo: JSON.stringify($scope.sampleObj)
            }),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).success(function (response) {

            alert(response.message);
            console.log("success");

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
                console.log("failed");
            },
            success: function (response) {
                alert(response.message);
                console.log("success");
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
            console.log(response);
            if (response)
                $scope.sampleObj = response;
            else {
                confirm("Confirm to Create a new record?")
                $scope.sampleObj = {
                    SampleNo: $scope.sampleObj.SampleNo,
                };
            }

            console.log($scope.sampleObj);

        });

    }

}



angular
    .module('inspinia')
    .controller('MainCtrl', MainCtrl)
    .controller('SampleCtrl', SampleCtrl)