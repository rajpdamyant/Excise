%{--<html>--}%
%{--<head>--}%
%{--<title><g:layoutTitle default="Grails"/></title>--}%
%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>--}%
%{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'style.css')}"/>--}%
%{--<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>--}%
%{--<g:layoutHead/>--}%
%{--<g:javascript library="application"/>--}%
%{--</head>--}%

%{--<body>--}%
%{--<div id="spinner" class="spinner" style="display:none;">--}%
%{--<img src="${resource(dir: 'images', file: 'spinner.gif')}"--}%
%{--alt="${message(code: 'spinner.alt', default: 'Loading...')}"/>--}%
%{--</div>--}%

%{--<div class="header">--}%
%{--<g:render template="/layouts/header"/>--}%
%{--</div>--}%

%{--<div id="grailsLogo"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'layoutImg1.jpg')}"--}%
%{--alt="Grails" border="0"/></a></div>--}%
%{--<g:layoutBody/>--}%
%{--<g:render template="/layouts/footer"/>--}%
%{--</body>--}%
%{--</html>--}%


<html>
<head>
    <title><g:layoutTitle default="Grails"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>

    %{--<link rel="shortcut icon" href="${resource(dir: 'images', file: 'logo.png')}" type="image/x-icon"/>--}%
    <g:layoutHead/>
    <g:javascript library="application"/>
    <g:javascript library="jquery" plugin="jquery"/>
    %{--TODO: BY MANISH--}%
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <link rel="stylesheet" type="text/css"href="${resource(dir: 'css', file: 'style.css')}"/>
    <link href='http://fonts.googleapis.com/css?family=Enriqueta' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Squada+One' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'css', file: 'newStyle.css')}"/>
    <link rel="stylesheet" type="text/css"
          href="${resource(dir: 'css', file: 'validationEngine.css')}"/>
    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'jquery-min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js', file: 'dateTime.js')}"></script>

    <script type="text/javascript"
            src="${resource(dir: 'js/jQuery', file: 'jquery.ui.datepicker.js')}"></script>


    <style type="text/css">

    @media  all and (max-width:1366px) {

        .layoutBody{
           min-height:  480px;


        }
    }
    @media  all and (max-width:1280px) {

        .layoutBody{
           min-height: 420px;

        }
    }


    </style>
    %{--<link href="${resource(dir: 'css', file: 'css.css')}" rel="stylesheet"/>--}%


</head>

<body>

<div class="mainDiv">

    <div id="spinner" class="spinner" style="display:none;">
        <img src="${resource(dir: 'images', file: 'spinner.gif')}"
             alt="${message(code: 'spinner.alt', default: 'Loading...')}"/>
    </div>


    %{--HOME BAR ENDS--}%
    <div class="header">
        <g:render template="/layouts/newHeader"/>
    </div>
    %{--TODO HEADER DONE--}%

    <div class="layoutBody">
        <g:layoutBody/>
    </div>

    %{--TODO: INTEGRATING FOOTER--}%

    <g:render template="/layouts/footer"/>
</div>
</body>
</html>