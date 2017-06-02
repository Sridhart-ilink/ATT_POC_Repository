<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SarfPage.aspx.cs" Inherits="JavascriptBasedApp.SarfPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Autoforms</title>
    <script type="text/javascript" src="Scripts/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="Scripts/angular-1.3.15.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-3.3.4.min.js"></script>
    <script type="text/javascript" src="Scripts/globals.js"></script>

    <!--CSS imports-->
    <link rel="stylesheet" type="text/css" href="Styles/bootstrap-3.3.4.min.css" />
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.css" />
    <link rel="stylesheet" type="text/css" href="Styles/esri-3.14.css" />
    <link rel="stylesheet" type="text/css" href="Styles/claro-3.14.css" />
    <link rel="stylesheet" href="bootstrap.vertical-tabs.css" />
    <link rel="stylesheet" type="text/css" href="Styles/style.css" />

    <style>
        #BasemapToggle {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 50;
        }
        .dijitTooltipContainer {
                border:0px !important;
                background:none !important;
            }
            .dialogtooltip {
                width:230px; height:205px; border: 1px solid lightgray;
                background-color:white; border-radius:20px;
            }
            .dialogtooltipinput {
               border:1px solid lightgray;margin:20px;padding-top:5px;
               border-radius:5px;
               width:190px;
            }
            .dialogtootipbtn {
               width:30px;
               min-width:50px;
               height: 25px;   
               color: white;
               margin-left:100px;
               font-weight:normal;
               padding:0px;
            }
            .dialogtootipbtncancel {
               min-width:50px;
               height: 25px;   
               color: #0878c0;             
               font-weight:normal;
               padding:0px;
               margin-left:10px;
            }
    </style>

</head>

<body>
    <form id="sarfForm" runat="server">
        <div class="container-fluid">
            <div class="row">
                <%--<div id="logoSection">
                    <img src="Styles/images/att-logo.png" class="att-logo" />
                    <span class="att-heading">BPM/Orchestration</span>
                </div>
                <div id="search" class="att-search"></div>--%>
                <nav class="navbar navbar-default clearfix" role="navigation">
                    <div class="navbar-header pull-left">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">
                            <img src="Styles/images/att-logo.png" class="att-logo" />
                            <span class="att-heading">Site Build</span>
                        </a>
                    </div>
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                        <div class="col-sm-3 col-md-4 col-md-offset-2">
                            <div id="search" class="att-search"></div>
                        </div>
                        <div class="col-md-3 pull-right text-right profile">
                            <span class="profileInfo themeBlue">Maxine Walters</span>
                            <i class="icon-user profileIcon themeBlue" aria-hidden="true"></i>
                        </div>
                    </div>
                </nav>
            </div>
            <div class="row">

                <div class="col-md-3 pad-lr-5 slidingDiv detailsSlider" id ="style-2">
                    <div class="cardHead">
                        <h3>SARF Details</h3>
                    </div>
                    <div class="cardHead ctrlOption">
                        <div id="editBtn">
                            <i class="fa fa-pencil menuIcon themeBlue" aria-hidden="true"></i>
                            <span>Edit</span>
                        </div>
                        <div id="toggleComment">
                            <i class="fa fa-wechat menuIcon themeBlue" aria-hidden="true"></i>
                            <span>Discuss</span>
                        </div>
                        <div>
                            <i class="fa fa-trash-o menuIcon themeBlue" aria-hidden="true"></i>
                            <span>Delete</span>
                        </div>
                </div>
            <div class="">
                <div class="col-md-12 borderBottom" style="margin-top: 10px; margin-bottom: 5px;margin-left : 15px;">
                    <button type="button" id="detailsupdatebtn" class="btn btn-link pull-right linkcolor editLink">SAVE</button>
                    <button type="button" id="detailscancelBtn" class="btn btn-link pull-right linkcolor editLink">CANCEL</button>
                </div>
                <div class="sarfDetails">

                    <div class="row">
                        <div class="col-md-6 pull-left">
                            <label for="txtsarfname">SARF Name:</label>
                            <p class="lblDetails"><span id="lblsarfname"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtsarfname" />
                        </div>
                        <div class="col-md-6 pull-left">
                            <label for="txtfacode">FA Code:</label>
                            <p class="lblDetails"><span id="lblfacode"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtfacode" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 pull-left">
                            <label for="txtsearchring">Search Ring ID:</label>
                            <p class="lblDetails"><span id="lblsearchring"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtsearchring" />
                        </div>
                        <div class="col-md-6 pull-left">
                            <label for="txtiplan">IPlan Job #:</label>
                            <p class="lblDetails"><span id="lbliplan"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtiplan" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 pull-left">
                            <label for="txtpace">Pace Number #:</label>
                            <p class="lblDetails"><span id="lblpace"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtpace" />
                        </div>
                        <div class="col-md-6 pull-left">
                            <label for="txtmarket">Market:</label>
                            <p class="lblDetails"><span id="lblmarket"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtmarket" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 pull-left">
                            <label for="txtcounty">County:</label>
                            <p class="lblDetails"><span id="lblcounty"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtcounty" />
                        </div>
                        <div class="col-md-6 pull-left">
                            <label for="txtfatype">FA Type:</label>
                            <p class="lblDetails"><span id="lblfatype"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtfatype" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 pull-left">
                            <label for="txtmarketcluster">Market Cluster:</label>
                            <p class="lblDetails"><span id="lblmarketcluster"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtmarketcluster" />
                        </div>
                        <div class="col-md-6 pull-left">
                            <label for="txtregion">Region:</label>
                            <p class="lblDetails"><span id="lblregion"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtregion" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 pull-left">
                            <label for="txtrfdesign">RF Design Engineer ATTUID:</label>
                            <p class="lblDetails"><span id="lblrfdesign"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtrfdesign" />
                        </div>
                        <div class="col-md-6 pull-left">
                            <label for="txtarea">Area In SqKm:</label>
                            <p class="lblDetails"><span id="lblarea"></span></p>
                            <input class="form-control txtDetails" runat="server" type="text" id="txtarea" />
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-md-8 pull-left">
                            <div class="cardTail">
                                <div class="form-group">
                                    <label for="txtSarfName">Current Status</label>
                                    <div class="col-xs-12" id="statusDiv">
                                        <span id="statusLabel"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="row">
                        <div class="col-md-12 col-md-offset-2 wfbtnSet">
                            <button type="button" id="promoteBtn" class="statusBtn mrg15-R blueBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                value="promote">PROMOTE</button>
                            <button type="button" id="demoteBtn" class="statusBtn whiteBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                value="demote">DEMOTE</button>
                            <button type="button" id="pullbackBtn" class="statusBtn mrg15-R whiteBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                value="pullback">PULL BACK</button>
                            <button type="button" id="cancelBtn" class="statusBtn whiteBtn btn btn-lg btn-danger btn-form btn-draw disabled"
                                value="cancel">CANCEL</button>
                        </div>
                    </div>
                    <%--<div class="row">
                        <div class="col-md-12 text-center">
                            <button type="button" id="pullbackBtn" class="statusBtn mrg15-R whiteBtn btn btn-lg btn-primary btn-form btn-draw disabled"
                                value="pullback">PULL BACK</button>
                            <button type="button" id="cancelBtn" class="statusBtn whiteBtn btn btn-lg btn-danger btn-form btn-draw disabled"
                                value="cancel">CANCEL</button>
                        </div>
                    </div>--%>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="col-md-9 tabDiv">
            <div class="toggleArrow rotateArrow">
                <%--<img src="Styles/images/double-arrow-right-red.png" title="Hide&Show SideBar" width="15" />--%>
                <i class="fa fa-chevron-right" aria-hidden="true"></i>
            </div>
            <div class="col-md-12 borderBottom pageLink" style="margin-top: 7px; margin-bottom: 5px">
                <a href="Default.aspx" class="linkcolor" style="margin-left: 30px;">Home</a> :: <a class="linkcolor">SARF Details</a>
                <ul class="nav nav-tabs tabs-left navTabs-ul pull-right tabMenu">
                    <li class="active" data-index="0"><a href="#mapview" data-toggle="tab">Map</a></li>
                    <li class="" data-index="1"><a href="#workflow" data-toggle="tab">Workflow</a></li>
                </ul>
            </div>
            <div class="col-xs-12">
                <!-- required for floating -->
                <!-- Nav tabs -->
                
            </div>
            <div class="col-xs-9">
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane" id="mapview">
                        <div id="map" style="width: 138%; height: 520px" class="pull-left">
                            <%--<a id="btnExpandMap" class="btn btn-primary" title="Click to maximize/minimize map">--%>
                            <div id="BasemapToggle"></div>
                        </div>
                    </div>
                    <div class="tab-pane" id="workflow">
                        <div style="width: 138%; height: 520px;" class="pull-left">
                            <iframe runat="server" id="workflowImg" style="width: 994px; height: 545px; padding-right: 5px;" src="#" frameborder="1" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 pad-lr-5 commentingDiv" id="style-2">
                <button type="button" class="close commentCloseBtn" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <div class="clearfix"></div>
                <div>
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                        </span>
                        <input type="text" class="form-control" placeholder="Add your comment" aria-describedby="basic-addon1" />
                    </div>
                </div>
                <div>
                    <div class="clearfix"></div>
                    <button type="button" id="postBtn" class="blueBtn btn btn-sm btn-primary btn-form btn-draw disabled pull-right"
                        value="post">
                        POST</button>
                </div>
                <div>
                    <button type="button" id="seeMoreBtn" class="btn btn-link pull-left linkcolor editLink fontClass">See more comments</button>
                </div>
                <div class="clearfix"></div>
                <div>
                    <div class="commentInfo">
                        <div class="chatHead clearfix">
                            <div class="pull-left">
                                <i class="glyphicon glyphicon-user"></i>
                            </div>
                            <div class="pull-right chatLabel">
                                <h3 class="fontClass">John Markus (C&E PM)</h3>
                                <p class="fontClass">April 25, 2017 11:40 am</p>
                            </div>
                        </div>
                        <div class="chatBody">
                            <p class="fontClass">
                                @Jill, Demoting the form as the iPlan details are incorrect. 
                            </p>
                            <div>
                                <input type="text" class="form-control" placeholder="leave a reply" />
                            </div>
                        </div>
                    </div>
                    <div class="commentInfo">
                        <div class="chatHead clearfix">
                            <div class="pull-left">
                                <i class="glyphicon glyphicon-user"></i>
                            </div>
                            <div class="pull-right chatLabel">
                                <h3 class="fontClass">Jill Baker (RF Engineer)</h3>
                                <p class="fontClass">April 26, 2017 09:15 am</p>
                            </div>
                        </div>
                        <div class="chatBody">
                            <p class="fontClass">
                                @John, Corrected the iPlan details and promoted the SARF again.
                                Can you plese review it and assign it to the vendor ?
                            </p>
                            <div>
                                <input type="text" class="form-control" placeholder="leave a reply" />
                            </div>
                        </div>
                    </div>
                    <div class="commentInfo">
                        <div class="chatHead clearfix">
                            <div class="pull-left">
                                <i class="glyphicon glyphicon-user"></i>
                            </div>
                            <div class="pull-right chatLabel">
                                <h3 class="fontClass">John Markus (C&E PM)</h3>
                                <p class="fontClass">April 26, 2017 90:20 am</p>
                            </div>
                        </div>
                        <div class="chatBody">
                            <p class="fontClass">
                                Need time to assign the SARF to the right vendor.
                            </p>
                            <div>
                                <input type="text" class="form-control" placeholder="leave a reply" />
                            </div>
                        </div>
                    </div>
                    <div class="commentInfo">
                        <div class="chatHead clearfix">
                            <div class="pull-left">
                                <i class="glyphicon glyphicon-user"></i>
                            </div>
                            <div class="pull-right chatLabel">
                                <h3 class="fontClass">Jill Baker (RF Engineer)</h3>
                                <p class="fontClass">April 26, 2017 09:22 am</p>
                            </div>
                        </div>
                        <div class="chatBody">
                            <p class="fontClass">
                                That's fine John. Thank you!
                            </p>
                            <div>
                                <input type="text" class="form-control" placeholder="leave a reply" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        </div>
            <div class="clearfix"></div>
        </div>
    </form>
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script>
        var labelStatus = '';
        function loadScript(src, callback) {
            'use strict';

            var script = document.createElement('script');
            script.type = 'text/javascript';
            script.src = src;

            script.onreadystatechange = function () {
                if (this.readyState === 'complete' || this.readyState === 'loaded') {
                    callback();
                }
            };

            script.onload = callback;

            var scriptTag = document.getElementsByTagName('script')[0];
            scriptTag.parentNode.insertBefore(script, scriptTag);
        }

        loadScript('https://js.arcgis.com/3.14/init.js', function () {
            onLoadGis(); //Initialize GIS components on ArcGIS load
        });

        function updatePromoteStatus(currentStatus) {

            switch (currentStatus) {
                case statusEnum.One:
                    labelStatus = statusEnum.Two;
                    $('#demoteBtn').show();
                    $('#pullbackBtn').show();
                    break;
                case statusEnum.Two:
                    labelStatus = statusEnum.Three;
                    $('#demoteBtn').show();
                    $('#pullbackBtn').show();
                    break;
                case statusEnum.Three:
                    labelStatus = statusEnum.Six;
                    $('#demoteBtn').hide();
                    $('#promoteBtn').hide();
                    $('#pullbackBtn').show();
                    break;
                case statusEnum.Four:
                    labelStatus = statusEnum.Two;
                    $('#demoteBtn').hide();
                    break;
                case statusEnum.Five:
                    labelStatus = statusEnum.Three;
                    $('#demoteBtn').hide();
                    break;
            }
        }

        function updateDemoteStatus(currentStatus) {
            switch (currentStatus) {
                case statusEnum.Two:
                    labelStatus = statusEnum.Four;
                    break;
                case statusEnum.Three:
                    labelStatus = statusEnum.Five;
                    break;
            }
            $('#pullbackBtn').show();
            $('#demoteBtn').hide();
        }

        function updatePullbackStatus(currentStatus) {
            switch (currentStatus) {
                case statusEnum.Six:
                    labelStatus = statusEnum.One;
                    break;
                case statusEnum.Two:
                    labelStatus = statusEnum.One;
                    break;
                case statusEnum.Three:
                    labelStatus = statusEnum.One;
                    break;
                case statusEnum.Four:
                    labelStatus = statusEnum.One;
                    break;
                case statusEnum.Five:
                    labelStatus = statusEnum.One;
                    break;
            }
            $('#cancelBtn').show();
            $('#promoteBtn').show();
            $('#pullbackBtn').hide();
        }

        function updateCancelStatus(currentStatus) {
            labelStatus = statusEnum.Seven;
            $('#promoteBtn').hide();
            $('#demoteBtn').hide();
            $('#pullbackBtn').hide();
        }

        function workflowUpdate(currentBtnText) {
            switch (currentBtnText) {
                case "PROMOTE":
                    updatePromoteStatus(labelStatus);
                    break;
                case "DEMOTE":
                    updateDemoteStatus(labelStatus);
                    break;
                case "PULL BACK":
                    updatePullbackStatus(labelStatus);
                    break;
                case "CANCEL":
                    updateCancelStatus(labelStatus);
                    break;
            }
        }
        function updateSarfStatus(id) {
            var getStatusUrl = "UpdateSarfStatus";
            var sarf = {
                id: id,
                sarfStatus: labelStatus
            };
            /*
            api call to update status
            */
            $.ajax({
                method: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: camundaBaseApiUrl + getStatusUrl,
                data: JSON.stringify(sarf),
                async: false,
                cache: false,
                success: function (data) {
                    localStorage["taskStatus"] = labelStatus;
                    $('#sarfForm').submit();
                },
                error: function (err) {
                    $('#sarfForm').submit();
                }
            });
        }

        function updateStatus(wfStatus, currentText) {
            var getStatusUrl = "taskcomplete";
            var jsonData = {
                variables: {
                    "action": { "value": wfStatus, "type": "String" }
                },
                id: JSON.parse(JSON.stringify(localStorage["taskID"]))
            };
            /*
            api call to update status
            */
            $.ajax({
                method: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: camundaBaseApiUrl + getStatusUrl,
                data: JSON.stringify(jsonData),
                async: false,
                cache: false,
                success: function (data) {
                    if (data) {
                        getTaskStatusbyProcessInstanceID(processInstanceID);
                        workflowUpdate(currentText);
                        console.log(data);
                        localStorage["tabIndex"] = $('.tabs-left').find('li.active').attr('data-index');
                        $('#sarfForm').submit();
                    }
                    else {
                        localStorage["tabIndex"] = $('.tabs-left').find('li.active').attr('data-index');
                        workflowUpdate(currentText);
                        updateSarfStatus(localStorage["sarfID"]);
                    }
                },
                error: function (err) {
                    localStorage["tabIndex"] = $('.tabs-left').find('li.active').attr('data-index');
                    workflowUpdate(currentText);
                    updateSarfStatus(localStorage["sarfID"]);
                    console.log(err);
                }
            });
        }

        function getTaskStatusbyProcessInstanceID(processInstanceID) {
            var getStatusUrl = "task-by-process-instance";
            /*
            api call to get the  task id , activity name ie status to complete the task
            */
            $.ajax({
                method: 'GET',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                url: camundaBaseApiUrl + getStatusUrl + "/" + processInstanceID,
                data: JSON.stringify({}),
                async: false,
                cache: false,
                success: function (data) {
                    if (data != null) {
                        var parsedData = JSON.parse(data)[0];
                        TaskID = parsedData.id;
                        TaskStatus = parsedData.name;
                        localStorage["taskID"] = TaskID;
                        localStorage["instanceID"] = processInstanceID;
                        InstanceID = processInstanceID;
                        localStorage["taskStatus"] = TaskStatus;
                        console.log(parsedData);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        var processInstanceID = "";
        var polygonlist = [];
        function initializeDetailsLabel(details) {
            if (details != null) {
                $('#lblsarfname').text(details.SarfName);
                $('#lblcounty').text(details.County);
                $('#lblfacode').text(details.FA_Code);
                $('#lblfatype').text(details.FA_Type);
                $('#lblmarket').text(details.Market);
                $('#lblmarketcluster').text(details.Market_Cluster);
                $('#lblpace').text(details.Pace);
                $('#lblrfdesign').text(details.RF_Design_Engineer_ATTUID);
                $('#lblregion').text(details.Region);
                $('#lblsearchring').text(details.Search_Ring_ID);
                $('#lbliplan').text(details.iPlan_Job);
                $('#lblarea').text(details.AreaInSqKm);
                $('#txtarea').attr('disabled', true);
            }
        }

        function initializeDetailsText(details) {
            if (details != null) {
                $('#txtsarfname').val(details.SarfName);
                $('#txtcounty').val(details.County);
                $('#txtfacode').val(details.FA_Code);
                $('#txtfatype').val(details.FA_Type);
                $('#txtmarket').val(details.Market);
                $('#txtmarketcluster').val(details.Market_Cluster);
                $('#txtpace').val(details.Pace);
                $('#txtrfdesign').val(details.RF_Design_Engineer_ATTUID);
                $('#txtregion').val(details.Region);
                $('#txtsearchring').val(details.Search_Ring_ID);
                $('#txtiplan').val(details.iPlan_Job);
                $('#txtarea').val(details.AreaInSqKm);

            }
        }

        function resetWorkflowButtons(currentStatus) {
            switch (currentStatus) {
                case statusEnum.One:
                    $('#promoteBtn').show();
                    $('#cancelBtn').show();
                    break;
                case statusEnum.Two:
                case statusEnum.Three:
                    $('#promoteBtn').show();
                    $('#demoteBtn').show();
                    $('#pullbackBtn').show();
                    $('#cancelBtn').show();
                    break;

                case statusEnum.Four:
                case statusEnum.Five:
                    $('#promoteBtn').show();
                    $('#pullbackBtn').show();
                    break;

                case statusEnum.Six:
                    $('#pullbackBtn').show();
                    $('#cancelBtn').show();
                    break;

                case statusEnum.Seven:
                    break;

                default:
                    if (currentStatus.startsWith('RF Mod')) {
                        $('#promoteBtn').show();
                        $('#pullbackBtn').show();
                    }
                    else {
                        $('#promoteBtn').show();
                        $('#cancelBtn').show();
                    }
                    break;
            }
        }

        function restoreCurrentTab() {
            var lastViewedTabIndex = localStorage["tabIndex"];
            if (lastViewedTabIndex != null && lastViewedTabIndex != '') {
                lastViewedTabIndex = parseInt(lastViewedTabIndex);
                switch (lastViewedTabIndex) {
                    case 0:
                        $($('.tabs-left').find('li')[lastViewedTabIndex]).addClass('active');
                        $($('.tabs-left').find('li')[lastViewedTabIndex + 1]).removeClass('active');
                        $($('.tab-content').find('.tab-pane')[lastViewedTabIndex]).addClass('active');
                        $($('.tab-content').find('.tab-pane')[lastViewedTabIndex + 1]).removeClass('active');
                        break;
                    case 1:
                        $($('.tabs-left').find('li')[lastViewedTabIndex]).addClass('active');
                        $($('.tabs-left').find('li')[lastViewedTabIndex - 1]).removeClass('active');
                        $($('.tab-content').find('.tab-pane')[lastViewedTabIndex]).addClass('active');
                        $($('.tab-content').find('.tab-pane')[lastViewedTabIndex - 1]).removeClass('active');
                        break;
                    default:
                        $($('.tabs-left').find('li')[0]).addClass('active');
                        $($('.tab-content').find('.tab-pane')[0]).addClass('active');
                        $($('.tabs-left li')[0]).find('a').focus();
                        break;
                }
            }
            else {
                $($('.tabs-left').find('li')[0]).addClass('active');
                $($('.tab-content').find('.tab-pane')[0]).addClass('active');
                $($('.tabs-left li')[0]).find('a').focus();
            }
        }

        //Jquery - document load script method
        $(document).ready(function () {
            $('.commentingDiv').hide();
            $('.toggleArrow').click(function () {
                $('.toggleArrow').toggleClass('rotateArrow');
                if ($('.slidingDiv').is(":visible")) {
                    //console.log('side bar shown');
                    $(".slidingDiv").toggle();
                    $('.tabDiv').removeClass('col-md-9');
                    $('.tabDiv').addClass('col-md-12');
                }
                else {
                    console.log('side bar hidden');
                    $(".slidingDiv").toggle();
                    $('.tabDiv').removeClass('col-md-12');
                    $('.tabDiv').addClass('col-md-9');
                }
            });

            $('#toggleComment').click(function () {
                $(".commentingDiv").toggle();
            });

            $('.commentCloseBtn').click(function () {
                $(".commentingDiv").toggle();
            });

            processInstanceID = GetParameterValues("processInstanceId");
            getTaskStatusbyProcessInstanceID(processInstanceID);
            $('#statusLabel').text(localStorage["taskStatus"]);
            labelStatus = $('#statusLabel').text();
            $('#promoteBtn').hide();
            $('#demoteBtn').hide();
            $('#pullbackBtn').hide();
            $('#cancelBtn').hide();

            resetWorkflowButtons(localStorage["taskStatus"]);
            $('#statusLabel').text(labelStatus);
            $('.txtDetails').hide();
            $('.lblDetails').show();
            $('#detailsupdatebtn').hide();
            $('#detailscancelBtn').hide();
            var jsonDetails = {};
            /*
            api call to update status
            */
            var getDetailsUrl = "AllSarfDetails/Get/" + localStorage["sarfID"]; //processInstanceID;
            $.ajax({
                method: 'GET',
                dataType: 'json',
                contentType: 'application/json',
                url: camundaBaseApiUrl + getDetailsUrl,
                data: JSON.stringify({}),
                async: false,
                cache: false,
                success: function (data) {
                    jsonDetails = data[0];
                    initializeDetailsLabel(jsonDetails);
                    initializeDetailsText(jsonDetails);
                    console.log(data);
                },
                error: function (err) {
                    console.log(err);
                }
            });

            var getSarfPolygonUrl = "GetAllPolygon/Get";

            $.ajax({
                method: 'GET',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                url: camundaBaseApiUrl + getSarfPolygonUrl,
                data: JSON.stringify({}),
                async: false,
                cache: false,
                success: function (data) {
                    $.each(data, function (i, item) {
                        console.log(item.Vertices);
                        polygonlist.push(item.Vertices);
                    });

                },
                error: function (err) {
                    console.log(err);
                }
            });

            $('#editBtn').click(function () {
                $('#editBtn').hide();
                $('#detailsupdatebtn').show();
                $('#detailscancelBtn').show();
                $('.lblDetails').hide();
                $('.txtDetails').show();
            });


            $('#detailscancelBtn').click(function () {
                initializeDetailsText(jsonDetails);
                $('#editBtn').show();
                $('#detailsupdatebtn').hide();
                $('#detailscancelBtn').hide();
                $('.lblDetails').show();
                $('.txtDetails').hide();
            });

            $("#btnExpandMap").click(function () {
                $("#mainWrapper").toggleClass("maximized-map");

                map.resize(); //Very important, must be called any time the map div is resized

                var chevron = $(this).find("span");
                chevron.toggleClass("glyphicon-chevron-down");
                chevron.toggleClass("glyphicon-chevron-up");
            });

            $('.statusBtn').click(function (e) {
                var currentBtnText = $(this).text();
                var currentBtnVal = $(this).val();
                var currentStatus = $('#statusLabel').text();
                updateStatus(currentBtnVal, currentBtnText);
            });

            function GetParameterValues(param) {
                var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < url.length; i++) {
                    var urlparam = url[i].split('=');
                    if (urlparam[0] == param) {
                        return urlparam[1];
                    }
                }
            }

            $('#detailsupdatebtn').click(function (e) {

                var sarfid = GetParameterValues("sarfid");
                var sarfNameTxt = $('#txtsarfname').val();
                var facodeTxt = $('#txtfacode').val();
                var searchringTxt = $('#txtsearchring').val();
                var iplanTxt = $('#txtiplan').val();
                var paceTxt = $('#txtpace').val();
                var marketTxt = $('#txtmarket').val();
                var countyTxt = $('#txtcounty').val();
                var fatypeTxt = $('#txtfatype').val();
                var marketcluterTxt = $('#txtmarketcluster').val();
                var regionTxt = $('#txtregion').val();
                var rfdesignTxt = $('#txtrfdesign').val();

                var postSarfDataUrl = "UpdateSarf/Post";
                var sarf = {
                    id: sarfid,
                    sarfName: sarfNameTxt,
                    facode: facodeTxt,
                    searchringid: searchringTxt,
                    iplanjob: iplanTxt,
                    pacenumber: paceTxt,
                    market: marketTxt,
                    county: countyTxt,
                    fatype: fatypeTxt,
                    marketcluster: marketcluterTxt,
                    region: regionTxt,
                    rfdesignenggid: rfdesignTxt
                };
                /*
              api call to post sarf data
              */
                $.ajax({
                    method: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    url: camundaBaseApiUrl + postSarfDataUrl,
                    data: JSON.stringify(sarf),
                    async: false,
                    cache: false,
                    success: function (data) {
                        $('#editBtn').show();
                        $('#detailsupdatebtn').hide();
                        $('#detailscancelBtn').hide();
                        $('.lblDetails').show();
                        $('.txtDetails').hide();
                        console.log(data);
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
                $('#sarfForm').submit();
            });

            restoreCurrentTab();
        });

        function onLoadGis() {
            require([
              "esri/map",
              "esri/dijit/BasemapToggle",
              "esri/layers/CSVLayer",
              "esri/Color",
               "esri/dijit/Search",
              "esri/symbols/SimpleMarkerSymbol",
              "esri/renderers/SimpleRenderer",
              "esri/InfoTemplate",
             // "esri/urlUtils",     
              "esri/toolbars/draw",
              "esri/graphic",
              "esri/Color",
              "esri/toolbars/edit",
             // "esri/symbols/SimpleMarkerSymbol",
              "esri/symbols/SimpleLineSymbol",
              "esri/symbols/SimpleFillSymbol",
              "esri/symbols/CartographicLineSymbol",
              "esri/geometry/Circle",
              "esri/geometry/Point",
              "esri/geometry/Polygon",
              "esri/geometry/Polyline",
              "esri/layers/GraphicsLayer",
              "esri/geometry/webMercatorUtils",
              "dojo/parser",
              "dijit/Menu",
              "dijit/MenuItem",
               "dijit/Dialog",
               "dijit/TooltipDialog",
              "dijit/form/Form",
              "dijit/form/TextBox",
              "dijit/form/Button",
              "dojo/on",
              "dojo/dom",
              "dojo/domReady!"],
            function (Map,
              BasemapToggle,
              CSVLayer,
              Color,
              Search,
              SimpleMarkerSymbol,
              SimpleRenderer,
              InfoTemplate,
             // urlUtils,
              Draw,
              Graphic,
              Color,
              Edit,
              // MapView,
              //SimpleMarkerSymbol,
              SimpleLineSymbol,
              SimpleFillSymbol,
              CartographicLineSymbol,
              Circle,
              Point,
              Polygon,
              Polyline,
              GraphicsLayer,
              WebMercatorUtils,
              Parser,
              Menu,
              MenuItem,
              Dialog,
              TooltipDialog,
              Form,
              TextBox,
              Button,
              on,
              dom) {

                var editToolBar, drawToolBar, drawingLayer, ctxMenuForGraphics, selectedGraphic = null;
                var drawing = false, editing = false;
                var tooltipDialog;
                Parser.parse();
                map = new Map("map", {
                    basemap: "streets",
                    center: [-120.435, 46.159], // lon, lat
                    zoom: 5,
                    minZoom: 2
                });

                var toggle = new BasemapToggle({
                    map: map,
                    basemap: "satellite",
                    basemaps:
                    {
                        "streets": {
                            "title": "Map",
                            "thumbnailUrl": "https://js.arcgis.com/3.15/esri/images/basemap/streets.jpg"
                        },
                        "satellite": {
                            "title": "Satellite",
                            "thumbnailUrl": "https://js.arcgis.com/3.15/esri/images/basemap/satellite.jpg"
                        }
                    }
                }, "BasemapToggle");
                toggle.startup();

                events.push(map.on("load", function () {
                    map.graphics.clear();
                    initDrawing();
                    initEditing();
                    // createToolbarAndContextMenu();

                    if (localStorage["vertices"] != null || localStorage["vertices"] != "") {
                        var finalVal = JSON.parse(JSON.stringify(localStorage["vertices"]));
                        var fillSymbol = new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID,
                             new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,
                             new Color([255, 0, 0]), 2), new Color([0, 0, 0, 0.25])
                          );
                        var polygon = new Polygon(new esri.SpatialReference({ wkid: 4326 }));
                        finalVal = JSON.parse("[" + finalVal + "]");
                        polygon.addRing(finalVal)

                        var gra = new esri.Graphic(polygon, fillSymbol);
                        map.graphics.add(gra);
                        map.setExtent(gra.geometry.getExtent().expand(2));

                        if (polygonlist.length > 0) {

                            $.each(polygonlist, function (i, val) {

                                var vertices_arr = [];
                                vertices_arr.push(val.split(';'))
                                var finalVal = "";
                                $.each(vertices_arr[0], function (i, val) {
                                    if (vertices_arr[0][i].length > 0) {
                                        finalVal = finalVal + '[' + vertices_arr[0][i] + ']' + ','
                                    }

                                });
                                if (finalVal.length > 0) {
                                    finalVal = finalVal.substring(0, finalVal.length - 1)
                                    if (finalVal != localStorage["vertices"]) {
                                        var finalVertices = JSON.parse(JSON.stringify(finalVal));
                                        polygon = new Polygon(new esri.SpatialReference({ wkid: 4326 }));
                                        finalVertices = JSON.parse("[" + finalVertices + "]");
                                        polygon.addRing(finalVertices)
                                        var fillSymbol = new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID,
                                        new SimpleLineSymbol(SimpleLineSymbol.STYLE_DASHDOT,
                                        new Color([201, 0, 0]), 2), new Color([0, 0, 0, 0.25])
                                        );

                                        var gra = new esri.Graphic(polygon, fillSymbol);
                                        map.graphics.add(gra);
                                    }
                                }
                            });
                        }
                    }
                }));

                function clearGraphics() {
                    //first remove all graphics added directly to map
                    if (map.graphics.type == "point") {
                        map.graphics.clear();
                    }


                    //now go into each graphic layer and clear it
                    var graphicLayerIds = map.graphicsLayerIds;
                    var len = graphicLayerIds.length;
                    for (var i = 0; i < len; i++) {
                        var gLayer = map.getLayer(graphicLayerIds[i]);
                        //clear this Layer
                        if (map.graphics.type == "point") {
                            gLayer.clear();
                        }
                    }

                }

                //Creates right-click context menu for graphics on the point
                function createGraphicsMenu() {
                    ctxMenuForGraphics = new Menu({});
                    ctxMenuForGraphics.addChild(new MenuItem({
                        label: "Add Node",
                        onClick: function () {
                            // CREATE DIALOG
                            var node = dom.byId('drawingLayer_layer');
                            if (!tooltipDialog) {
                                var htmlFragment = '';
                                htmlFragment += '<div id="mapTwo" class="dialogtooltip"><input type="text" placeholder="Atoll Site Name" id="txtatollname" width="150px" class="dialogtooltipinput">';
                                htmlFragment += '<div><input type="text" id="txtiplannumber" placeholder="IPlan Job No" width="150px" class="dialogtooltipinput" style="margin-top:0px;"></div>'
                                htmlFragment += '<div><input type="text" id="txtpacenumber" placeholder="Pace Number" width="150px" class="dialogtooltipinput" style="margin-top:0px;"></div>'
                                htmlFragment += '<div><input type="button" id="btncreatenode" value="Save" class="btn blueBtn dialogtootipbtn"/>'
                                htmlFragment += '<input type="button"  id="btncancelnode"  value="Cancel" class="btn whiteBtn dialogtootipbtncancel"/></div></div>'
                                var errorMsg = '<div class= "errorMsg" style = "margin-left: 20px;"><span style="color : red;">Fields must not be empty</span></div>';
                                // CREATE TOOLTIP DIALOG
                                tooltipDialog = new dijit.TooltipDialog({
                                    content: htmlFragment,
                                    autofocus: !dojo.isIE, // NOTE: turning focus ON in IE causes errors when reopening the dialog
                                    refocus: !dojo.isIE
                                });

                                // DISPLAY TOOLTIP DIALOG AROUND THE CLICKED ELEMENT
                                dijit.popup.open({ popup: tooltipDialog, around: node });
                                tooltipDialog.opened_ = true;
                                //Deactivate the toolbar
                                drawToolBar.deactivate();
                                drawing = false;
                                //Enable panning
                                map.enableMapNavigation();
                                //Remove active style from draw button
                                $(".btn-draw.active").removeClass("active");

                                $('#txtatollname').keypress(function () {
                                    $('div.errorMsg').remove();
                                });

                                $('#txtiplannumber').keypress(function () {
                                    $('div.errorMsg').remove();
                                });

                                $('#txtpacenumber').keypress(function () {
                                    $('div.errorMsg').remove();
                                });

                            } else {
                                if (tooltipDialog.opened_) {
                                    dijit.popup.close(tooltipDialog);
                                    tooltipDialog.opened_ = false;
                                    // node.innerHTML = "Show map below me";
                                } else {
                                    dijit.popup.open({ popup: tooltipDialog, around: node });
                                    tooltipDialog.opened_ = true;
                                    //Deactivate the toolbar
                                    drawToolBar.deactivate();
                                    drawing = false;
                                    //Enable panning
                                    map.enableMapNavigation();
                                    //Remove active style from draw button
                                    $(".btn-draw.active").removeClass("active");
                                }
                            }

                            $("#btncancelnode").click(function () {
                                if (tooltipDialog.opened_) {
                                    dijit.popup.close(tooltipDialog);
                                    tooltipDialog.opened_ = false;
                                }
                            });
                            $("#btncreatenode").click(function () {
                                // add node
                                var saveNodeUrl = "Node/Post";
                                var txtAtollName = $('#txtatollname').val();
                                var txtIplanNumber = $('#txtiplannumber').val();
                                var txtPaceNumber = $('#txtpacenumber').val();

                                var jsonData = {
                                    sarfId: localStorage["sarfID"],
                                    latitude: localStorage["lat"],
                                    longitude: localStorage["long"],
                                    atollSiteName: txtAtollName,
                                    iPlanJobNumber: txtIplanNumber,
                                    paceNumber: txtPaceNumber
                                }

                                if (txtAtollName.length > 0 && txtIplanNumber.length > 0 && txtPaceNumber.length > 0) {
                                    $.ajax({
                                        method: 'POST',
                                        dataType: 'json',
                                        contentType: 'application/json',
                                        url: camundaBaseApiUrl + saveNodeUrl,
                                        data: JSON.stringify(jsonData),
                                        async: false,
                                        cache: false,
                                        success: function (data) {
                                            console.log(data);
                                            $('#sarfForm').submit();
                                        },
                                        error: function (err) {
                                            console.log(err);
                                            $('#sarfForm').submit();
                                        }
                                    });
                                }
                                else {
                                    $('#txtpacenumber').after(errorMsg);
                                }
                                
                            });

                        }
                    }));
                    ctxMenuForGraphics.addChild(new MenuItem({
                        label: "Clear Node",
                        onClick: function () {
                            clearGraphics();
                        }
                    }));

                    ctxMenuForGraphics.startup();


                    //Bind and unbind the context menu using the following two events
                    map.graphics.on("mouse-over", function (evt) {
                        // We'll use this "selected" graphic to enable editing tools
                        // on this graphic when the user click on one of the tools
                        // listed in the menu.             
                        selected = evt.graphic;
                        // Let's bind to the graphic underneath the mouse cursor   
                        if (evt.graphic.geometry.type == "point") {
                            ctxMenuForGraphics.bindDomNode(evt.graphic.getDojoShape().getNode());
                        }
                    });

                    map.graphics.on("mouse-out", function (evt) {
                        if (evt.graphic.geometry.type == "point") {
                            ctxMenuForGraphics.unBindDomNode(evt.graphic.getDojoShape().getNode());
                        }
                    });

                }
                //Unload all the events when the application closes to prevent memory leaks
                events.push(map.on("unload", function () {
                    for (var i = 0; i < events.length; i++) {
                        events[i].remove();
                    }
                }));

                //LineSymbol used for polylines
                var lineSymbol = new CartographicLineSymbol(
                  CartographicLineSymbol.STYLE_SOLID,
                  new Color([255, 0, 0]), 10,
                  CartographicLineSymbol.CAP_ROUND,
                  CartographicLineSymbol.JOIN_MITER, 5
                );

                //FillSymbol for polygons drawn on the drawing layer
                var drawFillSymbol = new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID,
                  new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,
                  new Color([255, 0, 0]), 2), new Color([0, 0, 0, 0.25])
                );

                function initDrawing() {
                    drawToolBar = new Draw(map);
                    events.push(drawToolBar.on("draw-end", onDrawEnd));

                    //Create a dedicated drawing layer
                    //You could also just draw on map.graphics (built-in GraphicsLayer)
                    drawingLayer = new GraphicsLayer({
                        id: "drawingLayer"
                    });

                    map.addLayer(drawingLayer);

                    //Set the click event for the draw buttons
                    $(".btn-draw").click(function () {
                        map.graphics.clear();
                        //If the draw button clicked is already active, deactivate it
                        if ($(this).hasClass("active")) {
                            $(this).removeClass("active");

                            drawToolBar.deactivate();
                            drawing = false;

                            //Enable panning
                            map.enableMapNavigation();
                        } else {
                            //Activate Draw for the selected tool
                            $(".btn-draw.active").removeClass("active");
                            $(this).addClass("active");

                            var tool = $(this).attr('value');

                            //Disable panning
                            map.disableMapNavigation();

                            drawToolBar.activate(tool);
                            drawing = true;
                        }
                    });

                    //Enable the draw buttons
                    $(".btn-draw").removeClass("disabled");

                    map.graphics.on("click", function (evt) {
                        if (drawing !== true) {
                            if (evt.graphic.geometry.type !== "point") {
                                var symbol = new SimpleMarkerSymbol(
                                                              SimpleMarkerSymbol.STYLE_CIRCLE,
                                                              12,
                                                              new SimpleLineSymbol(
                                                                SimpleLineSymbol.STYLE_NULL,
                                                                new Color([247, 34, 101, 0.9]),
                                                                1
                                                              ),
                                                              new Color([207, 34, 171, 0.5])
                                                            );

                                map.graphics.add(new esri.Graphic(evt.mapPoint, symbol));
                            }

                            createGraphicsMenu();


                        }
                    });
                }

                function onDrawEnd(evt) {
                    //Deactivate the toolbar
                    drawToolBar.deactivate();
                    drawing = false;

                    //Enable panning
                    map.enableMapNavigation();

                    //Remove active style from draw button
                    $(".btn-draw.active").removeClass("active");

                    //Use the appropriate symbol depending on geometry type
                    var symbol;
                    if (evt.geometry.type === "polyline") {
                        symbol = lineSymbol;
                    } else {
                        symbol = drawFillSymbol;
                    }

                    var graphic = new Graphic(evt.geometry, symbol);

                    addGraphicToDrawingLayer(graphic);
                }

                function addGraphicToDrawingLayer(graphic) {

                    //For the purpose of this demo we only want one graphic at a time
                    drawingLayer.clear();

                    drawingLayer.add(graphic);

                    //Automatically activate editing
                    editToolBar.activate(Edit.EDIT_VERTICES, graphic);
                    editing = true;

                    postGraphic(graphic.geometry);
                }

                function initEditing() {

                    editToolBar = new Edit(map);

                    //Events to update vertex data after a shape is modified
                    events.push(editToolBar.on("vertex-move-stop", function (e) {
                        postGraphic(e.graphic.geometry);
                    }));

                    events.push(editToolBar.on("vertex-delete", function (e) {
                        postGraphic(e.graphic.geometry);
                    }));

                    events.push(editToolBar.on("graphic-move-stop", function (e) {
                        postGraphic(e.graphic.geometry);
                    }));

                    events.push(editToolBar.on("scale-stop", function (e) {
                        postGraphic(e.graphic.geometry);
                    }));

                    events.push(editToolBar.on("rotate-stop", function (e) {
                        postGraphic(e.graphic.geometry);
                    }));

                    //You can capture double clicks for the map itself or for a specific GraphicsLayer
                    //ex. drawingLayer.on("dbl-click", function (e) {...})
                    events.push(map.on("dbl-click", function (e) {
                        //If editing a graphic toggle the edit mode when that graphic is double-clicked
                        if (editing) {
                            var state = editToolBar.getCurrentState();
                            var editingGraphic = state.graphic;

                            if (editingGraphic != null) {
                                //There exists a method to check if a point is "in" a polygon, but no such thing for polylines
                                if ((editingGraphic.geometry.type === "polygon" && editingGraphic.geometry.contains(e.mapPoint))
                                    || (editingGraphic.geometry.type === "polyline" && e.graphic === editingGraphic)) {

                                    if (state.tool == Edit.EDIT_VERTICES) {
                                        editToolBar.activate(Edit.MOVE, editingGraphic);
                                    } else if (state.tool == Edit.MOVE) {
                                        editToolBar.activate(Edit.EDIT_VERTICES, editingGraphic);
                                    }

                                    map.infoWindow.hide();
                                }
                            }
                        }
                    }));
                }

                //Parse the vertices, convert them to a convenient format, then display
                function postGraphic(geometry) {
                    $("#vertices").text("");

                    if (geometry.type === 'polygon') {
                        //Our polygons should have only one ring
                        var polygon = geometry.rings[0];
                        var vertices = "";

                        for (var i = 0; i < polygon.length; i++) {
                            if (geometry.spatialReference.isWebMercator()) {
                                //Convert to traditional decimal degrees
                                longLat = WebMercatorUtils.xyToLngLat(polygon[i][0], polygon[i][1]);
                            } else longLat = [polygon[i][0], polygon[i][1]];

                            x = round(longLat[0], DECIMAL_PRECISION);
                            y = round(longLat[1], DECIMAL_PRECISION);

                            //Convert the vertices to the format x,y;x,y;
                            vertices = vertices + x + ',' + y + ';';
                        }

                        $("#vertices").text(vertices);

                        map.graphics.add(new esri.Graphic(geometry, drawFillSymbol));


                        var geographicGeometries = [];
                        geographicGeometries.push(esri.geometry.webMercatorToGeographic(geometry));
                        var areas = esri.geometry.geodesicAreas(geographicGeometries, esri.Units.KILOMETERS);
                        // alert("The area of the polygon is: " + areas[0] + " KM");
                        var areaInSqKm = areas * 0.00404685642;
                        $("#hdnArea").val(areaInSqKm);
                        // alert(areaInSqKm);

                    }
                    else if (geometry.type === 'polyline') {
                        //Assuming one line
                        var path = geometry.paths[0];
                        var points = "";

                        for (var j = 0; j < path.length; j++) {
                            if (geometry.spatialReference.isWebMercator()) {
                                //Convert to traditional decimal degrees
                                longLat = WebMercatorUtils.xyToLngLat(path[j][0], path[j][1]);
                            } else longLat = [path[j][0], path[j][1]];

                            x = round(longLat[0], DECIMAL_PRECISION);
                            y = round(longLat[1], DECIMAL_PRECISION);

                            //Convert the vertices to the format x,y;x,y;
                            points = points + x + ',' + y + ';';
                        }

                        $("#vertices").text(points);
                    }
                }

                function round(num, places) {
                    var multiplier = Math.pow(10, places);
                    return Math.round((num + 0.00001) * multiplier) / multiplier;
                }


                //   function createToolbarAndContextMenu() {

                //       map.graphics.on("click", function (evt) {
                //          if (drawing !== true) {
                //          var symbol = new SimpleMarkerSymbol(
                //                                        SimpleMarkerSymbol.STYLE_CIRCLE,
                //                                        12,
                //                                        new SimpleLineSymbol(
                //                                          SimpleLineSymbol.STYLE_NULL,
                //                                          new Color([247, 34, 101, 0.9]),
                //                                          1
                //                                        ),
                //                                        new Color([207, 34, 171, 0.5])
                //                                      );

                //       // map.graphics.add(new esri.Graphic(evt.mapPoint,symbol));
                //        //createGraphicsMenu();
                //     }
                //   });
                //}

                //Disable double-click zoom if a graphic is being clicked while editing
                events.push(map.on("mouse-down", function (e) {
                    if (e.graphic !== undefined && editing) {
                        map.disableDoubleClickZoom();
                    } else {
                        map.enableDoubleClickZoom();
                    }
                }));

                //Prevent the infoWindow from opening while drawing
                //Important if your app has drawing/editing and popup windows!
                events.push(map.infoWindow.on("show", function () {
                    if (drawing) map.infoWindow.hide();
                }));
            });
        }
         </script>
     </body>
</html>
