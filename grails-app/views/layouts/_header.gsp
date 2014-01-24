<table styel="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
    %{--<tr>--}%
        %{--<td>&nbsp;</td>--}%
    %{--</tr>--}%
    <tr>
        <td height="70" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <div style="float: left; margin-left: 100px">
                            <img src="${resource(dir: 'images', file: 'layoutImg1.jpg')}" width="100px" height="50px"/>
                        </div>

                        <div style="float: left;padding-top:15px;font-weight: bold; margin-left: 30px">
                            <span class="title" style="color: #2081A1;font-size: 20px;">
                                Online Excise Reporting System
                            </span><br/>
                        </div>
                    </td>

                    <td align="right" style="text-align:right;">

                        <sec:ifLoggedIn>Welcome <sec:username/>

                            <span class="txt">|</span><g:link controller="logout" class="mainlink">Logout</g:link>
                            <span class="txt">|</span>
                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                <g:link controller="dataCollection" action="admin" class="mainLink">
                                    Admin
                                </g:link>
                            </sec:ifAllGranted>
                            <sec:ifNotGranted roles="ROLE_ADMIN">
                                Admin
                            </sec:ifNotGranted>

                        </sec:ifLoggedIn>

                    </td>

                </tr>

            </table>
        </td>
    </tr>
    <sec:ifLoggedIn>
        <sec:ifAnyGranted roles="ROLE_HEADQUARTER,ROLE_DISTRICT">
            <tr>
                <td height="30" bgcolor="#FFFFFF">
                    <table width="100%" border="0" cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="16%" height="30" align="center" bgcolor="#333333">
                                <g:link controller="dataCollection" action="home" class="txtlink2">
                                    <div style="text-align: center;padding-top: 3px;">
                                        Home
                                    </div>
                                </g:link>
                            </td>
                            <sec:ifAnyGranted roles="ROLE_DISTRICT">
                                <td width="16%" align="center" bgcolor="#333333">
                                    <g:link controller="dataCollection" action="dataEnter" class="txtlink2">
                                        <div style="text-align: center;padding-top: 3px;">

                                        </div>
                                    </g:link>
                                </td>
                            </sec:ifAnyGranted>
                            <td width="16%" align="center" bgcolor="#333333">
                                <g:link controller="dataCollection" action="report" class="txtlink2">
                                    <div style="text-align: center;padding-top: 3px;">
                                        Reports
                                    </div>
                                </g:link>
                            </td>
                             <td width="16%" align="center" bgcolor="#333333">
                                    <div style="text-align: center;padding-top: 3px;">
                                        <g:link controller="dataCollection" action="uploadStatement" class="txtlink2">
                                            File Sharing
                                        </g:link>
                                    </div>
                            </td>
                            <td width="16%" align="center" bgcolor="#333333">
                                <a href="#" onclick="download()" class="txtlink2">
                                    <div style="text-align: center;padding-top: 3px;">
                                        Help
                                    </div>
                                </a>
                                <g:form name="form" method="POST" style="display:none" controller="dataCollection"
                                        action="helpMannualDownload">
                                    <g:hiddenField name="helpMannualContent" value=""/>
                                    <g:submitButton name="submitButton" value="Submit"/>
                                </g:form>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </sec:ifAnyGranted>
    </sec:ifLoggedIn>
    <tr>
        <td bgcolor="#FFFFFF"><img src="images/spacer.gif" width="1" height="1"/></td>
    </tr>

    <tr>
        <td width="5%"></td>
    </tr>
</table>
<script type="text/javascript">
    function download() {
        var helpMannualContent = $('#helpMannual').html();
        $('[name="helpMannualContent"]').attr('value', helpMannualContent);
        $('[name="submitButton"]').click();
    }
</script>
