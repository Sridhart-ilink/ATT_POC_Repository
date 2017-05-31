<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="JavascriptBasedApp._Default" %>

<%--<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">--%>
<!--JS imports-->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
         <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Autoforms</title>
        <script type="text/javascript" src="Scripts/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="Scripts/angular-1.3.15.min.js"></script>
        <script type="text/javascript" src="Scripts/bootstrap-3.3.4.min.js"></script>
        <script type="text/javascript" src="Scripts/globals.js"></script>
        <script type="text/javascript" src="Scripts/script.js"></script>
  
        <!--CSS imports-->
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet"/>
        <link rel="stylesheet" type="text/css" href="Styles/bootstrap-3.3.4.min.css" />
        <link rel="stylesheet" type="text/css" href="Styles/esri-3.14.css" />
        <link rel="stylesheet" type="text/css" href="Styles/claro-3.14.css" />
        <link rel="stylesheet" type="text/css" href="Styles/style.css" />
        <style>
            .line tr th
            {
                text-transform: none;
            }
            #BasemapToggle {
          position: absolute;
          top: 20px;
          right: 20px;
          z-index: 50;
    }
        </style>
    </head>
    
    <body>
        <form runat="server" id ="sarfForm">
            <div id="mainWrapper" class="container-fluid">
              <div class="row">
                    <div class="col-md-2 pad-lr-5 slidingDiv" id="style-2">
                        <div>
                            <a class="btn btn-default btn-form btn-draw disabled btnDraw" id="btnDraw" value="polygon">Create Search Ring</a>
                        </div>
                        <div class="cardView">
                        </div>
                        <div class="pager">
                            <span class="glyphicon glyphicon-backward" id ="backIcon" aria-hidden="true"></span>
                            <span class="glyphicon glyphicon-forward" id ="frontIcon" aria-hidden="true"></span>
                            <span>Page</span>
                            <span><input type="text" value="1" class="pageTxt"/></span>
                            <span class="pageLength"></span>
                        </div>
                        <div id="drawOptions">
                            <textarea style="display: none;" id="vertices" runat="server" rows="3" class="form-control form-group"></textarea>
                            <asp:HiddenField runat="server" ID="hdnArea" />
                        </div>
                    </div>
                <div class="col-md-10 pad-lr-5 tabDiv">
                    <div class="toggleArrow rotateArrow">
                           <img src="Styles/images/double-arrow-right-red.png" title="Hide&Show SideBar" width="15" />
                       </div>
                    <div id="search"></div>
                    <div id="map" class="pull-left">     
                         <div id="BasemapToggle"></div>               
                    </div>
                     <a class="btn-draw" id="circle" value="circle">Circle</a>
                      <a class="btn-draw" id="polygon" value="polygon">Polygon</a>
                     <a class="btn-draw" id="freehandpolyline" value="freehandpolyline">Freehand</a>                   
                     <%-- <div id="info">    
                          <button id="Circle">Circle</button>  
                          <button id="Polygon">Polygon</button>
                          <button id="Freehand">Freehand</button>
                        </div>  --%>                  
                </div>
                 
            </div>
            </div>
        </form>
    </body>
</html>
