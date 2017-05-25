<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SarfPage.aspx.cs" Inherits="JavascriptBasedApp.SarfPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sarf Info</title>
    <script type="text/javascript" src="Scripts/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="Scripts/angular-1.3.15.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-3.3.4.min.js"></script>

    <!--CSS imports-->
    <link rel="stylesheet" type="text/css" href="Styles/bootstrap-3.3.4.min.css" />
    <link rel="stylesheet" type="text/css" href="Styles/esri-3.14.css" />
    <link rel="stylesheet" type="text/css" href="Styles/claro-3.14.css" />
    <link rel="stylesheet" type="text/css" href="Styles/style.css" />
    <link rel="stylesheet" href="bootstrap.vertical-tabs.css" />
</head>
    <style type="text/css">
        /* DivTable.com */
.divTable{
	display: table;
	width: 100%;
}
.divTableRow {
	display: table-row;
}
.divTableHeading {
	background-color: #EEE;
	display: table-header-group;
}
.divTableCell, .divTableHead {
	border: 0px solid #999999;
	display: table-cell;
	padding: 3px 10px;
}
.divTableHeading {
	background-color: #EEE;
	display: table-header-group;
	font-weight: bold;
}
.divTableFoot {
	background-color: #EEE;
	display: table-footer-group;
	font-weight: bold;
}
.divTableBody {
	display: table-row-group;
}
    </style>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row" style="min-height: 600px;">
                <div class="col-sm-12">
                    <h3>Sarf Details</h3>
                    <hr />
                    <div class="col-xs-12">
                        <!-- required for floating -->
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs tabs-left">
                            <li class="active"><a href="#mapview" data-toggle="tab">Map View</a></li>
                            <li><a href="#workflow" data-toggle="tab">Workflow</a></li>
                            <li><a href="#details" data-toggle="tab">Details</a></li>
                            <li><a href="#actions" data-toggle="tab">Actions</a></li>
                        </ul>
                    </div>
                    <div class="col-xs-9">
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="mapview">
                                <div id="map" style="width: 1080px; height: 520px" class="pull-left">
                                    <a id="btnExpandMap" class="btn btn-primary" title="Click to maximize/minimize map">
                                        <span class="glyphicon glyphicon-chevron-up"></span></a>
                                </div>
                            </div>
                            <div class="tab-pane" id="workflow">
                                <div style="width: 1080px; height: 520px" class="pull-left">
                                    <iframe runat="server" id="workflowImg" style="width: 1080px; height: 400px;" src="#" frameborder="1" />
                                    <button type="button" id="promoteBtn" class="statusBtn btn btn-primary btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                                        value="promote">
                                        Promote</button>
                                    <button type="button" id="demoteBtn" class="statusBtn btn btn-success btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                                        value="demote">
                                        Demote</button>
                                    <button type="button" id="pullbackBtn" class="statusBtn btn btn-warning btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                                        value="pullback">
                                        Pull Back</button>
                                    <button type="button" id="cancelBtn" class="statusBtn btn btn-danger btn-form btn-draw disabled" title="Click and release to draw a polygon side. Double-click to finish the shape"
                                        value="cancel">
                                        Cancel</button>
                                    <div id="statusSection">
                                        <div class="form-group">
                                            <label for="txtSarfName">Current Status</label>
                                            <div class="col-xs-12">
                                                <span id="statusLabel"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="details">
                                <div class="divTable" style="width: 100%;">
                                    <div class="divTableBody">
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;SARF NAME :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtsarfname" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;FA CODE :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtfacode" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;SEARCH RING ID :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtsearchring" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;IPLAN JOB# :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtiplan" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;PACE NUMBER # :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtpace" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;MARKET :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtmarket" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;COUNTY :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtcountry" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;FA TYPE :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtfatype" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;MARKET CLUSTER :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtmarketcluster" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;REGION :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtregion" />
                                            </div>
                                        </div>
                                        <div class="divTableRow">
                                            <div class="divTableCell">&nbsp;RF DESIGN ENGINEER ATTUID :</div>
                                            <div class="divTableCell">
                                                <input runat="server" id="txtrfdesign" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" id="detailsupdatebtn" class="btn btn-warning btn-form btn-draw disabled" title="Submit"
                                    value="Submit">
                                    Submit</button>
                                <button type="button" id="detailscancelBtn" class="btn btn-danger btn-form btn-draw disabled" title="Cancel"
                                    value="cancel">
                                    Cancel</button>
                                <!-- DivTable.com -->
                            </div>
                            <div class="tab-pane" id="actions">Actions.</div>
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
        var DECIMAL_PRECISION = 5;
        //Save a collection of event handlers. It is best practive to remove 
        //event handlers when the application closes (on map "unload")
        var events = [];
        var appUrl = "http://localhost/ATTWorkFlowPOC/";
        var camundaBaseApiUrl = "http://localhost/ATTWebAppAPI/api/";
        var statusEnum = {
            One: "RF Pending Completion",
            Two: "C&E Vendor Assignment",
            Three: "TV Pending Approval",
            Four: "RF Mod - C&E PM Vendor Assignment",
            Five: "RF Mod - TV Pending Approval",
            Six: "TV Complete",
            Seven: "Cancel"
        };

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

        function updateStatus(wfStatus) {
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
                    console.log(data);
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        var processInstanceID = "";
        $(document).ready(function () {

            processInstanceID = GetParameterValues("processInstanceId");
             

            $('#statusLabel').text(localStorage["taskStatus"]);

            $('#demoteBtn').hide();
            $('#pullbackBtn').hide();

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
                updateStatus(currentBtnVal);
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
                var countyTxt = $('#txtcountry').val();
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
                             new Color([255, 0, 0]), 2), new Color([0, 0, 0, 0.25])
                          );
                        var polygon = new Polygon(new esri.SpatialReference({ wkid: 4326 }));
                        finalVal = JSON.parse("[" + finalVal + "]");
                        polygon.addRing(finalVal)

                        var gra = new esri.Graphic(polygon, fillSymbol);
                        map.graphics.add(gra);
                        map.setExtent(polygon.getExtent());
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
