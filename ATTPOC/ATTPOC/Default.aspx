<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="JavascriptBasedApp._Default" %>

<%--<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">--%>
<!--JS imports-->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Autoforms</title>
        <script type="text/javascript" src="Scripts/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="Scripts/angular-1.3.15.min.js"></script>
        <script type="text/javascript" src="Scripts/bootstrap-3.3.4.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.loadingoverlay/latest/loadingoverlay.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.loadingoverlay/latest/loadingoverlay_progress.min.js"></script>
        <script type="text/javascript" src="Scripts/globals.js"></script>
        <script type="text/javascript" src="Scripts/common.js"></script>
        <script type="text/javascript" src="Scripts/script.js"></script>
  
        <!--CSS imports-->
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="Styles/bootstrap-3.3.4.min.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.css" />
        <link rel="stylesheet" type="text/css" href="Styles/esri-3.14.css" />
        <link rel="stylesheet" type="text/css" href="Styles/claro-3.14.css" />
        <link rel="stylesheet" type="text/css" href="Styles/style.css" />
        <style>
        .line tr th {
                text-transform: none;
            }

            #BasemapToggle {
                  position: absolute;
                  top: 20px;
                  right: 20px;
                  z-index: 50;
            }
            .drawicon {
                position:relative;left:180px;bottom:100px;display:block;
            }
            .dijitTooltipContainer {
                border:0px !important;
                background:none !important;
            }
            .dialogtooltip {
                width:230px; height:185px; border: 1px solid lightgray;
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
    <form runat="server" id="sarfForm">
            <div id="mainWrapper" class="container-fluid">
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
                    <div class="col-md-2 pad-lr-5 slidingDiv" id="style-2">
                    
                        <div class="cardHead">
                            <h3>Recent SARFs</h3>
                        </div>
                        <div class="cardView">
                        </div>
                        <div class="pager">
                        <span class="glyphicon glyphicon-backward" id="backIcon" aria-hidden="true"></span>
                        <span class="glyphicon glyphicon-forward" id="frontIcon" aria-hidden="true"></span>
                            <span>Page</span>
                        <span>
                            <input type="text" value="1" class="pageTxt" /></span>
                            <span class="pageLength"></span>
                        </div>
                        <div id="drawOptions">
                            <textarea style="display: none;" id="vertices" runat="server" rows="3" class="form-control form-group"></textarea>
                            <asp:HiddenField runat="server" ID="hdnArea" />
                        </div>
                    </div>
                    <div class="col-md-10 pad-lr-5 tabDiv">
                    <div class="toggleArrow rotateArrow">
                        <%--<img src="Styles/images/double-arrow-right-red.png" title="Hide&Show SideBar" width="15" />--%>
                        <i class="fa fa-chevron-right" aria-hidden="true"></i>
                       </div>

                    <div id="map" class="pull-left">     
                         <div id="BasemapToggle"></div>               
                        <div class="addSarfBtn">
                            <a class="btn btn-default btn-form btnDraw" id="btnDraw" >Create Search Ring</a>
                             <a class="btn-draw" id="freehandpolyline" value="freehandpolyline" style="position:relative;left:200px;bottom:35px;"><img src="Styles/images/freehand.png" style="cursor:pointer;width:30px;height:30px;" /></a>
                     <a class="btn-draw" id="circle" value="circle" style="position:relative;left:235px;bottom:65px;"><img src="Styles/images/circle.png"  style="cursor:pointer;width:30px;height:30px;"/></a>
                     <a class="btn-draw" id="value" value="polygon"  style="position:relative;left:270px;bottom:95px;"><img src="Styles/images/polygon.png"  style="cursor:pointer;width:30px;height:30px;"/></a>  </div>
               
                        </div>
                    </div>
                     </div>
            </div>
        </form>
    </body>
</html>
