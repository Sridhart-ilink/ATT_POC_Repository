//global variable declarations
var TaskID = 0;
var InstanceID = 0;
var TaskStatus = "";
var sarfList = [];
var noOfPages = 0;
var currentPage = 1;
var pageIndex = 0;
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

function saveSARFData(workflowProcessInstanceID) {
    var postSarfDataUrl = "Sarf/Post";
    var sarfNameTxt = $('#dijit_form_TextBox_0').val();
    var jsonData = { sarfName: sarfNameTxt, processInstanceID: workflowProcessInstanceID };
    /*
   api call to post sarf data
   */
    $.ajax({
        method: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: camundaBaseApiUrl + postSarfDataUrl,
        data: JSON.stringify(jsonData),
        async: false,
        cache: false,
        success: function (data) {
            savePolygonData();
        },
        error: function (err) {
            console.log(err);
        }
    });
}

function savePolygonData() {
    var postPolyDataUrl = "Polygon/Post";
    var polyVertices = $("#vertices").text();
    var polyArea = $("#hdnArea").val();
    var jsonData = {
        vertices: polyVertices,
        areaInSqKm: polyArea
    };
    /*
       api call to post polygon data
    */
    $.ajax({
        method: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: camundaBaseApiUrl + postPolyDataUrl,
        data: JSON.stringify(jsonData),
        async: false,
        cache: false,
        success: function (data) {
            $('#sarfForm').submit();
        },
        error: function (err) {
            console.log(err);
        }
    });
}

loadScript('https://js.arcgis.com/3.14/init.js', function () {
    onLoadGis(); //Initialize GIS components on ArcGIS load
});

function cardViewDataBind() {
    if (sarfList != null && sarfList.length > 0) {
        $('.cardView').empty();
        var countReset = 0;
        var cardView = $('.cardView');
        for (var count = pageIndex; count < sarfList.length; count++) {
            countReset++;
            var content = '';
            content += '<div class="cardInfo">' +
                            '<div class="cardBody">' +
                                    '<button type="button" class="btn btn-link linkcolor">' + sarfList[count].SARFID + '</button>' +
                                    '<h3>' + sarfList[count].SARFNAME + '</h3>' +
                                    '<span class="cardSpan clearfix">' + sarfList[count].AreaInSqKm + ' SqKm</span>' +
                                    '<span class="cardSpan clearfix">RF Pending Complete</span>' +
                             '</div>' +
                        '</div>';
            cardView.append(content);
            if (countReset == 10) {
                pageIndex = count + 1;
                countReset = 0;
                break;
            }
        }
        $('.pageTxt').val(currentPage);
    }
}

function initGrid() {
    var getDetailsAction = "SarfDetails/Get";
    $.ajax({
        method: 'GET',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        url: camundaBaseApiUrl + getDetailsAction,
        data: JSON.stringify({}),
        async: false,
        cache: false,
        success: function (data) {
            sarfList = data;
            sarfList.length > 10 ? $('.pager').show() : $('.pager').hide();
            noOfPages = (sarfList.length % 10 == 0) ? (sarfList.length / 10) : Math.ceil(sarfList.length / 10);
            $('.pageLength').text(' of ' + noOfPages);
            cardViewDataBind();
            console.log(sarfList);
        },
        error: function (err) {
            console.log(err);
        }
    });
}

$(document).ready(function () {
    initGrid();
    $('.toggleArrow').click(function () {
        $('.toggleArrow').toggleClass('rotateArrow');
        if ($('.slidingDiv').is(":visible")) {
            //console.log('side bar shown');
            $(".slidingDiv").toggle();
            $('.tabDiv').removeClass('col-md-10');
            $('.tabDiv').addClass('col-md-13');
        }
        else {
            console.log('side bar hidden');
            $(".slidingDiv").toggle();
            $('.tabDiv').removeClass('col-md-13');
            $('.tabDiv').addClass('col-md-10');
        }
    });
    $('#map').height($(window).height()-60);
    $("#btnExpandMap").click(function () {
        $("#mainWrapper").toggleClass("maximized-map");

        map.resize(); //Very important, must be called any time the map div is resized

        var chevron = $(this).find("span");
        chevron.toggleClass("glyphicon-chevron-down");
        chevron.toggleClass("glyphicon-chevron-up");
    });

    /*Pagination for card view*/
    //paging forward
    $('#frontIcon').click(function () {
        currentPage += 1;
        currentPage = currentPage >= noOfPages ? noOfPages : currentPage;
        cardViewDataBind();
    });

    //paging backward
    $('#backIcon').click(function () {
        currentPage -= 1;
        currentPage = currentPage < 1 ? 1 : currentPage;
        pageIndex = pageIndex < 0 ? 0 : (pageIndex - 10);
        cardViewDataBind();
    });
});

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
            var parsedData = JSON.parse(data);
            InstanceID = parsedData[0].processInstanceId;
            TaskID = parsedData[0].id;
            TaskStatus = parsedData[0].name;
            localStorage["taskID"] = TaskID;
            localStorage["instanceID"] = InstanceID;
            localStorage["taskStatus"] = TaskStatus;
            console.log(parsedData);
        },
        error: function (err) {
            console.log(err);
        }
    });
}
function onLoadGis() {
    require([
      "esri/map",
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
      "dijit/form/Form",
      "dijit/form/TextBox",
      "dijit/form/Button",
      "dojo/on",
      "dojo/dom",
      "dojo/domReady!"],
    function (Map,
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
              Form,
              TextBox,
              Button,
              on,
              dom) {

        var editToolBar, drawToolBar, drawingLayer, ctxMenuForGraphics, ctxMenuForGraphics1, selectedGraphic = null;
        var drawing = false, editing = false;
        Parser.parse();

        map = new Map("map", {
            basemap: "streets",
            center: [-115.94158, 48.89913, -125.14812, 44.75269], // lon, lat
            zoom: 5,
            minZoom: 2
        });

        var search = new Search({
            map: map
        }, "search");
        search.startup();

        events.push(map.on("load", function () {
            initDrawing();
            initEditing();
          // initcsv();
            //createGraphicsMenu();
            // createToolbarAndContextMenu();
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

        function initcsv() {

            var csv;

            //urlUtils.addProxyRule({
            //    proxyUrl: "",
            //    urlPrefix: "earthquake.usgs.gov"
            //});
            //file:///C:/Users/Anusha/Downloads/ATT_Orchestration_BPM_POC-master/ATT_Orchestration_BPM_POC-master/ATTPOC/ATTPOC/2.5_week.csv
            csv = new CSVLayer("../../2.5_week.csv", {
                copyright: "USGS.gov"
            });

            var orangeRed = new Color([238, 69, 0, 0.5]); // hex is #ff4500
            var marker = new SimpleMarkerSymbol("solid", 15, null, orangeRed);
            var renderer = new SimpleRenderer(marker);
            csv.setRenderer(renderer);
            var template = new InfoTemplate("${type}", "${place}");
            csv.setInfoTemplate(template);
            map.addLayer(csv);

        }

        function initDrawing() {
            drawToolBar = new Draw(map);
            events.push(drawToolBar.on("draw-end", onDrawEnd));

            //Create a dedicated drawing layer
            //You could also just draw on map.graphics (built-in GraphicsLayer)
            drawingLayer = new GraphicsLayer({
                id: "drawingLayer"
            });

            map.addLayer(drawingLayer);

            $("#dtGrid tr").click(function () {                
                map.graphics.clear();
                var cell = $(this);

                $("#dtGrid tr:even").css("background-color", "white");
                $("#dtGrid tr:odd").css("background-color", "lightgray");
          
               
                if (cell[0].childNodes[2].childNodes['3'] != undefined) {
                    cell[0].style.backgroundColor = "#005476";
                    cell[0].style.Color = "white";
                var verticesVal = cell[0].childNodes[2].childNodes['3'].defaultValue;
                if (verticesVal != "") {
                    var vertices_arr = [];
                    vertices_arr.push(verticesVal.split(';'))
                    var finalVal = "";
                    $.each(vertices_arr[0], function (i, val) {
                        if (vertices_arr[0][i].length > 0) {
                            finalVal = finalVal + '[' + vertices_arr[0][i] + ']' + ','
                        }

                    });
                    if (finalVal.length > 0) {
                        finalVal = finalVal.substring(0, finalVal.length - 1)
                        var finalVal = JSON.parse(JSON.stringify(finalVal));
                        var drawFillSymbol = new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID,
                         new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,
                         new Color([255, 0, 0]), 2), new Color([0, 0, 0, 0.25])
                       );
                        var polygon = new Polygon(new esri.SpatialReference({ wkid: 4326 }));
                        finalVal = JSON.parse("[" + finalVal + "]");
                        polygon.addRing(finalVal)

                        var gra = new esri.Graphic(polygon, drawFillSymbol);
                        map.graphics.add(gra);
                        map.setExtent(gra.geometry.getExtent().expand(2));
                       
                    }
                }
               }
            });

            $(".sarfclick").click(function () {
                map.graphics.clear();

                var self = $(this);
                var sarfName = self.text();
                var sarfId = $(self).attr('data-sarfid');
                var verticesVal = $(self).attr('data-vertices');
                if (verticesVal != "") {
                    var vertices_arr = [];
                    vertices_arr.push(verticesVal.split(';'))
                    var finalVal = "";
                    $.each(vertices_arr[0], function (i, val) {
                        if (vertices_arr[0][i].length > 0) {
                            finalVal = finalVal + '[' + vertices_arr[0][i] + ']' + ','
                        }

                    });
                    if (finalVal.length > 0) {
                        finalVal = finalVal.substring(0, finalVal.length - 1)
                        localStorage["vertices"] = finalVal;
                    }
                }
                getTaskStatusbyProcessInstanceID($(self).attr('data-processinstanceid'));
                window.location = appUrl + "SarfPage.aspx?processInstanceId=" + InstanceID + "&sarfid=" + sarfId;
                
            });
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

            createGraphicsMenu();
            // triggered the click event to enable the context for create sarf
            $(".btn-draw").click();
        }

        function addGraphicToDrawingLayer(graphic) {

            //For the purpose of this demo we only want one graphic at a time
            drawingLayer.clear();

            drawingLayer.add(graphic);

            //Automatically activate editing
            // editToolBar.activate(Edit.EDIT_VERTICES, graphic);
            // editing = true;
            //Activate Draw for the selected tool
            ////////////////////////////////////////
            $(".btn-draw.active").removeClass("active");
            $(this).addClass("active");

            var tool = $(this).attr('value');

            //Disable panning
            map.disableMapNavigation();

            drawToolBar.activate(tool);
            drawing = true;
            ////////////////////////////////////
            //Enable panning

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
            //  events.push(map.on("dbl-click", function (e) {
                //If editing a graphic toggle the edit mode when that graphic is double-clicked
            //if (editing) {
            //    var state = editToolBar.getCurrentState();
            //    var editingGraphic = state.graphic;

            //    if (editingGraphic != null) {
            //        //There exists a method to check if a point is "in" a polygon, but no such thing for polylines
            //        if ((editingGraphic.geometry.type === "polygon" && editingGraphic.geometry.contains(e.mapPoint))
            //            || (editingGraphic.geometry.type === "polyline" && e.graphic === editingGraphic)) {

            //            if (state.tool == Edit.EDIT_VERTICES) {
            //                editToolBar.activate(Edit.MOVE, editingGraphic);
            //            } else if (state.tool == Edit.MOVE) {
            //                editToolBar.activate(Edit.EDIT_VERTICES, editingGraphic);
            //            }

            //            map.infoWindow.hide();
            //        }
            //    }
            //}
            // }));
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

        

        function clearGraphics() {
            //first remove all graphics added directly to map
            map.graphics.clear();

            //now go into each graphic layer and clear it
            var graphicLayerIds = map.graphicsLayerIds;
            var len = graphicLayerIds.length;
            for (var i = 0; i < len; i++) {
                var gLayer = map.getLayer(graphicLayerIds[i]);
                //clear this Layer
                gLayer.clear();
            }

        }

        //Creates right-click context menu for graphics on the drawingLayer
        function createGraphicsMenu() {

            ctxMenuForGraphics = new Menu({});
            ctxMenuForGraphics.addChild(new MenuItem({
                label: "Create Sarf",
                onClick: function () {
                    if (selectedGraphic != null && selectedGraphic.geometry.type !== "point") {      
                            var form = new Form();

                            new TextBox({
                                width:"150px",
                            }).placeAt(form.containerNode);
                         
                        new Button({
                            label: "REMOVE POLYGON ",
                            style: "padding:5px 5px 5px 5px;font-size:12px;font-family:Roboto regular;color:white;border:0px solid #ff2000 !important; background: linear-gradient(0deg, #ba1a00, #ff2000 80%) no-repeat;",
                            onClick: function () {
                                dia.destroy();
                                clearGraphics();
                            }
                            }).placeAt(form.containerNode);
                            new Button({
                                label: "SAVE",
                                style: "padding:5px 5px 5px 5px;font-size:12px;font-family:Roboto regular;color:white;border:0px solid #ff2000 !important; background: linear-gradient(0deg, #005991, #007ecd 80%) no-repeat;",
                                onClick: function () {
                                    var getProcessUrl = "process-definition";
                                    var jsonData = {
                                        variables: {},
                                        key: "identify-sarfs"
                                    }

                                    $.ajax({
                                        method: 'POST',
                                        dataType: 'json',
                                        contentType: 'application/json',
                                        url: camundaBaseApiUrl + getProcessUrl,
                                        data: JSON.stringify(jsonData),
                                        async: false,
                                        cache: false,
                                        success: function (data) {
                                            saveSARFData(JSON.parse(data).id);
                                        },
                                        error: function (err) {
                                            saveSARFData(0);
                                            console.log(err);
                                        }
                                    });
                                }
                            }).placeAt(form.containerNode);

                            var dia = new Dialog({
                                content: form
                            });
                            form.startup();
                            dia.show();
                            $('.dijitDialog').addClass('dialogStyle');
                            $('.dijitDialog').find('div[role="presentation"]').css('border-color', 'silver');
                            $('.dijitInputInner').attr('placeholder', 'Sarf Name');
                            $('.dijitInputInner').addClass('form-control');
                            $('.dijitDialog').find('input[type="button"]').addClass('btn btn-default dialogSaveBtn');                     
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

