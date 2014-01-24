<%@ page import="challan.SuperintendentOffice; challan.DistrictOffice" %>
<html>
<head>
<title><g:message code='spring.security.ui.login.title' default="Online Excise Reporting System"/></title>
<meta name='layout' content='register'/>
%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'css.css')}"/>--}%
    <link rel="shortcut icon" href="../favicon.ico">
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'demo1.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'style5.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'animate-custom.css')}" />

%{--<link rel="stylesheet" media="screen"--}%
      %{--href="${resource(dir: 'css', file: 'spring-security-ui.css', plugin: 'spring-security-ui')}"/>--}%
<style type="text/css">

body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px; /*background-image: url(images/page-bg.jpg);*/
    background-image: url(${resource(dir:'images',file:'page-bg.jpg')});
    background-repeat: repeat-x;
}

.s2ui_hidden_button {
    float: right;
    height: 0;
    left: 1px;
    margin: 0;
    padding: 0;
    position: absolute;
    width: 0;
    z-index: -1000;
    border: 0;
    background: white;
}

.txtlink2:link {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #FFF;
    text-decoration: underline;
}

.txtlink2:visited {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #FFF;
    text-decoration: underline;
}

.txtlink2:hover {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #FFF;
    text-decoration: none;
}

.txtlink2:active {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 12px;
    font-weight: bold;
    color: #FFF;
    text-decoration: underline;
}

.smalltxt {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 9px;
    font-weight: normal;
    color: #FFF;
    text-decoration: none;
}

    /*now onwards css for pop up div of forgot password     */
.DocumentLeftInner {
    width: 200px;
    float: left;
    margin-top: 1px;
    background: #fff;
}

.DocumentLeftInner h2 {
    width: 202px;
    float: left;
    position: relative;
    top: -1px;
    left: -1px;
    font: bold 12px Arial, Helvetica, sans-serif;
    color: #FFFFFF;
    margin: 0px;
    background: url(../images/temp/ui-bg_gloss-wave.png) repeat-x scroll 50% 50% #5C9CCC;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
}

.DocumentLeftInner h2 span {
    float: left;
    padding: 7px 0px 5px 12px;
    width: 180px;
}

.DocumentLeftCtn {
    width: 178px;
    height: 300px;
    overflow: auto;
    float: left;
    padding: 11px 11px 0px 11px;
}

.DocumentLeftBdrBtm {
    width: 202px;
    float: left;
    position: relative;
    top: 1px;
    left: -1px;
    background: url(../images/temp/BdrBtmRight.jpg) top right no-repeat;
}

.DocumentLeftBdrBtm img {
    float: left;
}

.blackOuterDiv {
    width: 100%;
    float: left;
    position: fixed;
    z-index: 1000;
    top: 0;
    left: 0;
    height: 100%;
    background: url(../images/overlay_bg.png) top left;
    display: none; /*opacity: 0.8;*/
}

</style>
%{--<script type="text/javascript">--}%
%{--</script>--}%
</head>

<body>

<g:render template="/layouts/header"/>
<div style="height: 500px;">

    %{--<div class="login s2ui_center ui-corner-all" style='text-align:center;'>--}%
        %{--<div class="login-inner">--}%
            %{--<form action='${postUrl}' method='POST' id="loginForm" name="loginForm" autocomplete='off'>--}%
                %{--<div class="sign-in">--}%

                    %{--<h1><g:message code='spring.security.ui.login.signin' default="Member Sign In"/></h1>--}%

                    %{--<div align="center">--}%
                        %{--<table>--}%
                            %{--<tr>--}%
                                %{--<td><label for="username"><g:message code='spring.security.ui.login.username'--}%
                                                                     %{--default="Username:"/></label>--}%
                                %{--</td>--}%
                                %{--<td><input name="j_username" id="username" size="20"/></td>--}%
                            %{--</tr>--}%
                            %{--<tr>--}%
                                %{--<td><label for="password"><g:message code='spring.security.ui.login.password'--}%
                                                                     %{--default="Password:"/></label>--}%
                                %{--</td>--}%
                                %{--<td><input type="password" name="j_password" id="password" size="20"--}%
                                           %{--onpaste="return false;"></td>--}%
                            %{--</tr>--}%
                            %{--<tr>--}%
                                %{--<td colspan='2'>--}%
                                    %{--<input type="checkbox" class="checkbox" name="${rememberMeParameter}"--}%
                                           %{--id="remember_me"--}%
                                           %{--checked="checked"/>--}%
                                    %{--<label for='remember_me'><g:message--}%
                                            %{--code='spring.security.ui.login.rememberme' default="Remember me"/></label>--}%
                                    %{--<s2ui:submitButton elementId='loginButton' form='loginForm'--}%
                                    %{--messageCode='spring.security.ui.login.login'--}%
                                    %{--style='margin-left: 40px; width: 115px;'/>--}%

                                    %{--<input type='submit' id="submit"--}%
                                           %{--value='${message(code: "springSecurity.login.button")}'/>--}%
                                %{--</td>--}%
                            %{--</tr>--}%
                            %{--<tr>--}%
                                %{--<td>--}%
                                    %{--<span class="forgot-link">--}%
                                        %{--<a href="#" onclick="$('#pop_up').attr('style', 'display:inline');">--}%
                                            %{--<g:message code='spring.security.ui.login.forgotPassword'/>--}%
                                        %{--</a>--}%
                                    %{--</span>--}%

                                %{--</td>--}%
                            %{--</tr>--}%
                            %{--<tr>--}%
                                %{--<td colspan='2'>--}%

                                %{--</td>--}%
                            %{--</tr>--}%
                        %{--</table>--}%
                        %{--<g:if test="${flash.message}">--}%
                            %{--<div style="color: RED">${flash.message}</div>--}%
                        %{--</g:if>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</form>--}%
        %{--</div>--}%
    %{--</div>--}%

    %{--<section style="margin-top: 30px">--}%
        %{--<div id="container_demo" >--}%

            %{--<a class="hiddenanchor" id="toregister"></a>--}%
            %{--<a class="hiddenanchor" id="tologin"></a>--}%
            %{--<div id="wrapper">--}%
                %{--<div id="login" class="animate form">--}%
                    %{--<form action='${postUrl}' method='POST' id="loginForm" name="loginForm" autocomplete='off'>--}%
                        %{--<h1>Log in</h1>--}%
                        %{--<p>--}%
                            %{--<label for="username" >--}%
                                %{--<g:message code='spring.security.ui.login.username' default="Username:"/>Your username </label>--}%
                            %{--<input name="j_username" id="username" required="required" type="text" placeholder="myusername "/>--}%
                        %{--</p>--}%
                        %{--<p>--}%
                            %{--<label for="password"><g:message code='spring.security.ui.login.password' default="Password:"/> Your password </label>--}%
                            %{--<input id="password" name="j_password"  required="required" type="password" placeholder="eg. X8df!90EO" />--}%
                        %{--</p>--}%
                        %{--<p class="keeplogin">--}%
                            %{--<input type="checkbox" name="${rememberMeParameter}" id="remember_me" value="loginkeeping" />--}%
                            %{--<label for="remember_me">Keep me logged in</label>--}%
                        %{--</p>--}%
                        %{--<p class="login button">--}%
                            %{--<input type="submit" value="Login" />--}%
                        %{--</p>--}%
                        %{--<g:if test="${flash.message}">--}%
                        %{--<div style="color: RED">${flash.message}</div>--}%
                        %{--</g:if>--}%

                    %{--</form>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</section>--}%
</div>

 <g:render template="/layouts/footer"/>

%{--<div>--}%
    %{--<div id="pop_up" class="blackOuterDiv" style="display: none;">--}%
        %{--<div id="popUpOuterDiv" class="DocumentLeftInner"--}%
             %{--style="width: 360px; height: 320px;z-index: 1000;position:absolute;top:200px;left:500px;">--}%
            %{--<h2 style="width: 362px;">--}%
                %{--<span style="width: 340px;border-top-left-radius: 8px;">--}%
                    %{--Forgot Password--}%
                    %{--<a href="#" style="text-decoration: none;float: right;font-weight:bold;color: #FFFFFF;"--}%
                       %{--onclick="hidePopUp()">Close</a>--}%
                %{--</span>--}%
            %{--</h2>--}%

            %{--<div id="popUpInnerDiv" class="DocumentLeftCtn" style="width: 338px;height: 274px;float: left;">--}%
                %{--<p>A mail will be sent to your domain manager, to reset the password.</p>--}%
                %{--<table border="0" style="font-size: small;">--}%
                    %{--<tr><td>User Name :</td><td><input type="text" id="forgotPasswordUserName" style="width:180px;"/>--}%
                    %{--</td></tr>--}%
                    %{--<tr><td></td><td></td></tr>--}%
                    %{--<tr><td><g:radio name="selectedDomain" value="districtOffice"--}%
                                     %{--checked="checked"/> District Office</td><td><g:select--}%
                            %{--from="${DistrictOffice.list().name}" id="districtOfficeList"--}%
                            %{--noSelection="['':'- Choose A District Office -']"--}%
                            %{--style="width:180px;"/></td>--}%
                    %{--</tr>--}%
                    %{--<tr><td><g:radio name="selectedDomain"--}%
                                     %{--value="superintendentOffice"/> Superintendent Office</td><td><g:select--}%
                            %{--from="${SuperintendentOffice.list().name}" id="superintendentOfficeList"--}%
                            %{--noSelection="['':'- Choose A Superintendent Office -']" disabled="true"--}%
                            %{--style="width:180px;"/></td></tr>--}%
                    %{--<tr><td><input type="button" value="Send Mail" onclick="sendMail()" id="sendButton"/></td>--}%
                        %{--<td><input type="button"--}%
                                   %{--value="Cancel"--}%
                                   %{--onclick="hidePopUp()" id="cancelSendButton"/>--}%
                        %{--</td></tr>--}%
                    %{--<tr>--}%
                        %{--<td id="mailStatus" colspan="2" style="text-align:center;">--}%

                        %{--</td>--}%
                    %{--</tr>--}%
                %{--</table>--}%
            %{--</div>--}%

            %{--<div class="DocumentLeftBdrBtm" style="width: 362px;"><img alt=""--}%
                                                                       %{--src="../images/temp/BdrBtmLeft.jpg">--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%
<script>
    $(document).ready(function() {
        $('#username').focus();
    });
    $('[name="selectedDomain"]').live('change', function() {
        $('#superintendentOfficeList').val('- Choose A Superintendent Office -');
        $('#districtOfficeList').val('- Choose A District Office -');

        var selectedDomain = getSelectedRadio('selectedDomain');
        if (selectedDomain == 'districtOffice') {
            $('#districtOfficeList').attr('disabled', false);
            $('#superintendentOfficeList').attr('disabled', true);
        }
        else if (selectedDomain == 'superintendentOffice') {
            $('#districtOfficeList').attr('disabled', true);
            $('#superintendentOfficeList').attr('disabled', false);
        }
        function getSelectedRadio(selectedRadio) {
            var value = '';
            $('[name="' + selectedRadio + '"]').each(function() {
                if ($(this).attr('checked'))
                    value = $(this).attr('value');
            });
            return value;
        }

        function sendMail() {
            var username = $('#forgotPasswordUserName').val().trim();
            var selectedDomain = getSelectedRadio('selectedDomain');
            var domainName = '';

            if (selectedDomain == 'districtOffice') {
                domainName = $('#districtOfficeList').val().trim();
            }
            else if (selectedDomain == 'su') {
                domainName = $('#superintendentOfficeList').val().trim();
            }
            if (username == '') {
                alert('Please Enter The User Name');
            }
            else if (selectedDomain == 'DistrictOffice' && domainName == '') {
                alert('Please Choose A District Office');
            }
            else if (selectedDomain == 'SuperintendentOffice' && domainName == '') {
                alert('Please Choose A Superintendent Office');
            }
            else {
                $('#sendButton').attr('disabled', true);
                $('#cancelSendButton').attr('disabled', true);
                $('#mailStatus').html('Trying To Send Mail....');
                $.ajax({
                    url: '${createLink(controller: 'login', action: 'forgotPassword')}',
                    data:{userName:username,selectedDomain:selectedDomain,domainName:domainName},
                    type: 'POST',
                    async: false,
                    cache:false,
                    timeout:30000,
                    error:function() {
                        return true;
                    },
                    success: function(response) {
                        alert(response);
                        $('#sendButton').attr('disabled', false);
                        $('#cancelSendButton').attr('disabled', false);
                        $('#mailStatus').html('');
                        hidePopUp();
                    }
                });
            }

        }

        function hidePopUp() {
            $('#forgotPasswordUserName').val('');
            $('#districtOfficeList').val('');
            $('#superintendentOfficeList').val('');
            $('#pop_up').attr('style', 'display:none');
        }

    <s2ui:initCheckboxes/>

</script>

</body>
</html>