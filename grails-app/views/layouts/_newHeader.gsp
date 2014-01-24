<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/3/12
  Time: 1:15 PM
  To change this template use File | Settings | File Templates.
--%>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td height="70" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <div style="float: left; margin-left: 100px"><img src="${resource(dir: 'images', file: 'layoutImg1.jpg')}"
                                                       width="100px" height="50px"/></div>

                        <div style="float: left;padding-top:15px;font-weight: bold; margin-left: 30px">
                            <span class="title" style="color: #2081A1;font-size: 20px;">
                                Online Excise Reporting System
                            </span><br/>
                        </div>
                    </td>

                    <td style="text-align: right;color: #2081A1;font:16px verdana, arial, helvetica, sans-serif; vertical-align: middle">

                        <sec:ifLoggedIn>Welcome <sec:username/>
                            <span >|</span><g:link controller="logout" style="color: #2081A1; ">Logout</g:link>
                            <span class="txt">|</span>
                            <div style="margin-bottom:10px;display:inline;" id="dateDiv">
                                <script type="text/javascript">window.onload = date_time('dateDiv');</script>
                            </div>
                            %{--<input type="hidden" name="dataEnteredDate" value=""/>--}%
                                <span class="txt">|</span>
                            <sec:ifAllGranted roles="ROLE_ADMIN ,ROLE_HEADQUARTER">
                                <g:link controller="dataCollection" action="admin" class="mainLink">
                                    Admin
                                </g:link>
                            </sec:ifAllGranted>
                            <sec:ifNotGranted roles="ROLE_ADMIN ,ROLE_DISTRICT">
                                Admin
                            </sec:ifNotGranted>
                        </sec:ifLoggedIn>
                        <sec:ifNotLoggedIn>
                            <g:link class="mainlink" controller="login">Login</g:link>
                        </sec:ifNotLoggedIn>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <sec:ifLoggedIn>
        <sec:ifAnyGranted roles="ROLE_HEADQUARTER,ROLE_DISTRICT, ROLE_ADMIN">
            <tr><td width="5px">
                <sec:ifAnyGranted roles="ROLE_DISTRICT">
                    <div class="navigation">
                        <ul>
                            <li><g:link controller="dataCollection" action="home">Home</g:link></li>
                            <li><a href="#">Excise/VAT</a>
                                <ul class="submenu">
                                     <li><g:link controller="dataCollection"
                                                action="manufacturer">Distilleries-Excise</g:link></li>
                                    <li><g:link controller="dataCollection"
                                                action="distributor">Bonded Warehouse-Excise</g:link></li>
                                      <li><g:link controller="dataCollection"
                                                action="retailerOn">RetailerON-Excise/Vat</g:link></li>
                                        <li><g:link controller="dataCollection"
                                                action="retailerOff">RetailerOFF-Excise/Vat</g:link></li>
                                </ul>
                            </li>
                            %{--Tab for Report--}%

                            <li><a href="#">License Fee</a>
                                                            <ul class="submenu">
                                                                   <li><g:link controller="dataCollection"
                                                                            action="licenseManufacturer">Distilleries</g:link></li>
                                                                <li><g:link controller="dataCollection"
                                                                            action="licenseDistributor">Bonded Warehouse</g:link></li>
                                                                <li><g:link controller="dataCollection"
                                                                            action="licenseRetailerOn">Retailer ON</g:link></li>
                                                                <li><g:link controller="dataCollection"
                                                                            action="licenseRetailerOff">Retailer OFF</g:link></li>

                                                            </ul>
                                                        </li>
                            <li><a href="#">Reports</a>
                                <ul class="submenu">
                                    <li><g:link controller="dataCollection"
                                                action="vatReport">VAT Collections</g:link></li>
                                    <li><g:link controller="dataCollection"
                                                action="report">Excise Collections</g:link></li>
                                    <li><g:link controller="dataCollection"
                                                action="licenseReport">License Status</g:link></li>
                                </ul>
                            </li>
                            %{--Tab for License Fee--}%
                            <li><a href="#">File Sharing</a>
                            <ul class="submenu">
                                <li><g:link controller="dataCollection"
                                                action="uploadStatement">Upload File</g:link></ul></li>
                            <li><a href="#">Form</a>
                               <ul class="submenu">
                                   <li><g:link controller="form" action="openForm">Form1</g:link></li>


                                    <li><g:link controller="form" action="openForm">Form2</g:link></li>
                                </ul>
                            </li>
                            <li><g:link controller="form" action="history">History</g:link></li>
                            <li><a href="#" onclick="download()">Help</a></li>
                            <g:form name="form" method="POST" style="display:none" controller="dataCollection"
                                    action="helpMannualDownload">
                                <g:submitButton name="submitHelpButton" value="Submit"/>
                            </g:form>
                        </ul>
                    </div>
                </sec:ifAnyGranted>
                <sec:ifNotGranted roles="ROLE_DISTRICT">
                    <div class="navigation nav_hq">

                        <ul>
                            <li><g:link controller="dataCollection" action="home">Home</g:link></li>
                            <li><a href="#">Reports</a>
                                <ul class="submenu">
                                    <li><g:link controller="dataCollection"
                                                action="vatReport">VAT Collections</g:link></li>
                                    <li><g:link controller="dataCollection"
                                                action="report">Excise Collections</g:link></li>
                                    <li><g:link controller="dataCollection"
                                                action="licenseReport">License Status</g:link></li>
                                      <li><g:link controller="dataCollection" action="reconciliationStatements">File Sharing</g:link></li>
                                </ul>
                            </li>
                            <li><a href="#" onclick="download()">Help</a></li>
                            <g:form name="form" method="POST" style="display:none" controller="dataCollection"
                                    action="helpMannualDownload">
                                <g:submitButton name="submitHelpButton" value="Submit"/>
                            </g:form>
                        </ul>
                    </div>
                </sec:ifNotGranted>
            </td>
            </tr>
        </sec:ifAnyGranted>
    </sec:ifLoggedIn>
    <tr>
        %{--<td bgcolor="#FFFFFF"><img src="images/spacer.gif" width="1" height="1"/></td>--}%
    </tr>

    <tr>
        <td width="5%"></td>
    </tr>
</table>
<script type="text/javascript">
    $('#dateDiv').html(getCurrentIST());
    $('input[name="dataEnteredDate"]').attr('value', $('#dateDiv').text().trim());


    function getTwoDigitDate(date) {

          return (date.length < 2) ? ('0' + date) : date
      }



    function getCurrentIST() {
        var date = new Date();
        date.setTime(date.getTime() + (date.getTimezoneOffset() + 330) * 60 * 1000);

        var dateString = (1900 + date.getYear()) + "-" + (getTwoDigitDate('' + (date.getMonth() + 1))) + "-" + getTwoDigitDate('' + date.getDate()) + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        return(dateString);
    }

    function download() {
        $('[name="submitHelpButton"]').click();
    }

    function jasperReport() {
        $('.jasperButton').click();
    }
</script>