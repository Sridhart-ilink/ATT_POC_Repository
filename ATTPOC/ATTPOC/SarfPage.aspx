<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SarfPage.aspx.cs" Inherits="JavascriptBasedApp.SarfPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sarf Info</title>
    <script type="text/javascript" src="Scripts/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="Scripts/angular-1.3.15.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-3.3.4.min.js"></script>
    <script type="text/javascript" src="Scripts/globals.js"></script>

    <!--CSS imports-->
    <link rel="stylesheet" type="text/css" href="Styles/bootstrap-3.3.4.min.css" />
    <link rel="stylesheet" type="text/css" href="Styles/esri-3.14.css" />
    <link rel="stylesheet" type="text/css" href="Styles/claro-3.14.css" />
    <link rel="stylesheet" href="bootstrap.vertical-tabs.css" />
    <link rel="stylesheet" type="text/css" href="Styles/style.css" />
</head>

<body>
    <form id="sarfForm" runat="server">
        <div class="container-fluid">
            <div class="row">
                
                <div class="col-md-3 pad-lr-5 slidingDiv">
                    <div class="">
                    <div class="col-md-12 borderBottom" style="margin-top: 10px; margin-bottom: 5px;">
                        <button type="button" id ="editBtn" class="btn btn-link pull-right linkcolor editLink">EDIT</button>
                        <button type="button" id ="detailsupdatebtn" class="btn btn-link pull-right linkcolor editLink">SAVE</button>
                        <button type="button" id ="detailscancelBtn" class="btn btn-link pull-right linkcolor editLink">CANCEL</button>
                        
                    </div>
                    <div class="sarfDetails">
                       
                        <div class="row">
                            <div class="col-md-6 pull-left">
                                <label for="txtsarfname">Sarf Name:</label>
                                <p class="lblDetails"><span id="lblsarfname"></span></p>
                                <input class="form-control txtDetails" runat="server" type="text" id="txtsarfname" />
                            </div>
                            <div class="col-md-6 pull-left">
                                <label for="txtfacode">FA Code:</label>
                                <p class="lblDetails"><span id="lblfacode"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtfacode" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 pull-left">
                                <label for="txtsearchring">Search Ring ID:</label>
                                <p class="lblDetails"><span id="lblsearchring"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtsearchring" />
                            </div>
                            <div class="col-md-6 pull-left">
                                <label for="txtiplan">IPlan Job #:</label>
                                <p class="lblDetails"><span id="lbliplan"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtiplan" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 pull-left">
                                <label for="txtpace">Pace Number #:</label>
                                <p class="lblDetails"><span id="lblpace"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtpace" />
                            </div>
                             <div class="col-md-6 pull-left">
                                <label for="txtmarket">Market:</label>
                                <p class="lblDetails"><span id="lblmarket"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtmarket" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 pull-left">
                                <label for="txtcounty">County:</label>
                                <p class="lblDetails"><span id="lblcounty"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtcounty" />
                            </div>
                            <div class="col-md-6 pull-left">
                                <label for="txtfatype">FA Type:</label>
                                <p class="lblDetails"><span id="lblfatype"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtfatype" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 pull-left">
                                <label for="txtmarketcluster">Market Cluster:</label>
                                <p class="lblDetails"><span id="lblmarketcluster"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtmarketcluster" />
                            </div>
                            <div class="col-md-6 pull-left">
                                <label for="txtregion">Region:</label>
                                <p class="lblDetails"><span id="lblregion"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtregion" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 pull-left">
                                <label for="txtrfdesign">RF Design Engineer ATTUID:</label>
                                <p class="lblDetails"><span id="lblrfdesign"></span></p>
                                <input class="form-control txtDetails" runat="server" type ="text" id="txtrfdesign" />
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-md-8 pull-left">
                                <div>
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
                            <div class="col-md-8 pull-left">
                                <button type="button" id="promoteBtn" class="statusBtn btn btn-lg btn-primary btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                                value="promote">
                                Promote</button>
                                <button type="button" id="demoteBtn" class="statusBtn btn btn-lg btn-primary btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                                    value="demote">
                                    Demote</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8 pull-left">
                                <button type="button" id="pullbackBtn" class="statusBtn btn btn-lg btn-primary btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                                    value="pullback">
                                    Pull Back</button>
                                <button type="button" id="cancelBtn" class="statusBtn btn btn-lg btn-danger btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                                    value="cancel">
                                    Cancel</button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                        </div>
                </div>
                <div class="col-md-9 tabDiv">
                    <div class="toggleArrow">
                           <img src="Styles/images/double-arrow-right-red.png" title="Hide&Show SideBar" width="15" />
                       </div>
                    <div class="col-md-12 borderBottom pageLink" style="margin-top: 7px; margin-bottom: 5px">
                        <a href="Default.aspx" class="linkcolor" style="margin-left:30px;">Home</a> :: <a class="linkcolor">Sarf Details</a>
                    </div>
                    <div class="col-xs-12">
                        <!-- required for floating -->
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs tabs-left">
                            <li class="active"><a href="#mapview" data-toggle="tab">Map View</a></li>
                            <li><a href="#workflow" data-toggle="tab">Workflow</a></li>
                        </ul>
                    </div>
                    <div class="col-xs-9">
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="mapview">
                                <div id="map" style="width: 138%; height: 520px" class="pull-left">
                                    <a id="btnExpandMap" class="btn btn-primary" title="Click to maximize/minimize map">
                                        <span class="glyphicon glyphicon-chevron-up"></span></a>
                                </div>
                            </div>
                            <div class="tab-pane" id="workflow">
                                <div style="width: 138%; height: 520px" class="pull-left">
                                    <iframe runat="server" id="workflowImg" style="width: 1080px; height: 400px;" src="#" frameborder="1" />
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
                    $('#statusLabel').text(statusEnum.Two);
                    $('#demoteBtn').show();
                    $('#pullbackBtn').show();
                    break;
                case statusEnum.Two:
                    $('#statusLabel').text(statusEnum.Three);
                    $('#demoteBtn').show();
                    $('#pullbackBtn').show();
                    break;
                case statusEnum.Three:
                    $('#statusLabel').text(statusEnum.Six);
                    $('#demoteBtn').hide();
                    $('#promoteBtn').hide();
                    $('#pullbackBtn').show();
                    break;
                case statusEnum.Four:
                    $('#statusLabel').text(statusEnum.Two);
                    $('#demoteBtn').hide();
                    break;
                case statusEnum.Five:
                    $('#statusLabel').text(statusEnum.Three);
                    $('#demoteBtn').hide();
                    break;
            }
        }

        function updateDemoteStatus(currentStatus) {
            switch (currentStatus) {
                case statusEnum.Two:
                    $('#statusLabel').text(statusEnum.Four);
                    break;
                case statusEnum.Three:
                    $('#statusLabel').text(statusEnum.Five);
                    break;
            }
            $('#pullbackBtn').show();
            $('#demoteBtn').hide();
        }

        function updatePullbackStatus(currentStatus) {
            switch (currentStatus) {
                case statusEnum.Six:
                    $('#statusLabel').text(statusEnum.One);
                    break;
                case statusEnum.Two:
                    $('#statusLabel').text(statusEnum.One);
                    break;
                case statusEnum.Three:
                    $('#statusLabel').text(statusEnum.One);
                    break;
                case statusEnum.Four:
                    $('#statusLabel').text(statusEnum.One);
                    break;
                case statusEnum.Five:
                    $('#statusLabel').text(statusEnum.One);
                    break;
            }
            $('#cancelBtn').show();
            $('#promoteBtn').show();
            $('#pullbackBtn').hide();
        }

        function updateCancelStatus(currentStatus) {
            $('#statusLabel').text(statusEnum.Seven);
            $('#promoteBtn').hide();
            $('#demoteBtn').hide();
            $('#pullbackBtn').hide();
        }

        function workflowUpdate(currentBtnText) {
            switch (currentBtnText) {
                case "Promote":
                    updatePromoteStatus(currentStatus);
                    break;
                case "Demote":
                    updateDemoteStatus(currentStatus);
                    break;
                case "Pull Back":
                    updatePullbackStatus(currentStatus);
                    break;
                case "Cancel":
                    updateCancelStatus(currentStatus);
                    break;
            }
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
                    getTaskStatusbyProcessInstanceID(processInstanceID);
                    workflowUpdate(currentText);
                    console.log(data);
                    $('#sarfForm').submit();
                },
                error: function (err) {
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
                    var parsedData = JSON.parse(data)[0];
                    TaskID = parsedData.id;
                    TaskStatus = parsedData.name;
                    localStorage["taskID"] = TaskID;
                    localStorage["instanceID"] = processInstanceID;
                    InstanceID = processInstanceID;
                    localStorage["taskStatus"] = TaskStatus;
                    console.log(parsedData);
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

        $(document).ready(function () {

               // $(".slidingDiv").hide();
                //$(".toggleArrow").show();

                $('.toggleArrow').click(function () {
                    
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

            processInstanceID = GetParameterValues("processInstanceId");
            getTaskStatusbyProcessInstanceID(processInstanceID);
            $('#statusLabel').text(localStorage["taskStatus"]);

            $('#promoteBtn').hide();
            $('#demoteBtn').hide();
            $('#pullbackBtn').hide();
            $('#cancelBtn').hide();

            resetWorkflowButtons(localStorage["taskStatus"]);
            $('.txtDetails').hide();
            $('.lblDetails').show();
            $('#detailsupdatebtn').hide();
            $('#detailscancelBtn').hide();
            var jsonDetails = {};
            /*
            api call to update status
            */
            var getDetailsUrl = "AllSarfDetails/Get/" + processInstanceID;
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
        });

        function onLoadGis() {
            require([
              "esri/map",
              "esri/toolbars/draw",
              "esri/graphic",
              "esri/Color",
              "esri/toolbars/edit",

              "esri/symbols/SimpleMarkerSymbol",
              "esri/symbols/SimpleLineSymbol",
              "esri/symbols/SimpleFillSymbol",
              "esri/symbols/CartographicLineSymbol",
              "esri/geometry/Circle",
              "esri/geometry/Point",
              "esri/geometry/Polygon",
              "esri/geometry/Polyline",
              "esri/layers/GraphicsLayer",
              "esri/geometry/webMercatorUtils",
              "dijit/Menu",
              "dijit/MenuItem",
              "dojo/on"],
            function (Map,

                Draw, Graphic, Color, Edit,

               SimpleMarkerSymbol,
                SimpleLineSymbol, SimpleFillSymbol,
              CartographicLineSymbol, Circle,
              Point,
              Polygon, Polyline, GraphicsLayer,
              WebMercatorUtils, Menu, MenuItem, on) {

                var editToolBar, drawToolBar, drawingLayer, ctxMenuForGraphics, selectedGraphic = null;
                var drawing = false, editing = false;

                map = new Map("map", {
                    basemap: "streets",
                    center: [-120.435, 46.159], // lon, lat
                    zoom: 5,
                    minZoom: 2
                });


                events.push(map.on("load", function () {
                    map.graphics.clear();
                    initDrawing();
                    initEditing();
                    createGraphicsMenu();
                    if (localStorage["vertices"] != null || localStorage["vertices"] != "") {
                        var finalVal = JSON.parse(JSON.stringify(localStorage["vertices"]));
                        var fillSymbol = new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID,
                             new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,
                             new Color([0, 0, 225]), 2), new Color([0, 0, 0, 0.25])
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
                                        new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,
                                        new Color([255, 0, 0]), 2), new Color([0, 0, 0, 0.25])
                                        );

                                        var gra = new esri.Graphic(polygon, fillSymbol);
                                        map.graphics.add(gra);
                                    }
                                }
                            });
                        }
                    }
                }));

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

                //Creates right-click context menu for graphics on the drawingLayer
                function createGraphicsMenu() {

                    ctxMenuForGraphics = new Menu({});
                    ctxMenuForGraphics.addChild(new MenuItem({
                        label: "Create Sarf",
                        onClick: function () {
                            if (selectedGraphic != null && selectedGraphic.geometry.type !== "point") {
                                require([
                 "dijit/Dialog",
                 "dijit/form/Form",
                 "dijit/form/TextBox",
                 "dijit/form/Button",
                 "dojo/domReady!"
                                ], function (Dialog, Form, TextBox, Button) {
                                    var form = new Form();

                                    new TextBox({
                                        placeHolder: "Name"
                                    }).placeAt(form.containerNode);

                                    var myDialog = new Dialog({
                                        //    title: "SARF is created",
                                        style: "width: 300px; top:425px;"
                                    });

                                    new Button({
                                        label: "Save",
                                        onClick: function () {
                                            //myDialog.set("content", "SARF is created");
                                            //myDialog.show();
                                        }
                                    }).placeAt(form.containerNode);

                                    var dia = new Dialog({
                                        content: form,
                                        title: "SARF Name",
                                        style: "width: 300px; height: 80px; background-color: white;"
                                    });
                                    form.startup();
                                    dia.show();
                                });//~require
                            }
                        }
                    }));

                    ctxMenuForGraphics.startup();

                    //Bind and unbind the context menu using the following two events
                    events.push(drawingLayer.on("mouse-over", function (e) {
                        selectedGraphic = e.graphic;

                        ctxMenuForGraphics.bindDomNode(e.graphic.getDojoShape().getNode());
                    }));

                    events.push(drawingLayer.on("mouse-out", function (e) {
                        ctxMenuForGraphics.unBindDomNode(e.graphic.getDojoShape().getNode());
                    }));
                }

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
