<%--
  Created by IntelliJ IDEA.
  User: damyant
  Date: 1/30/12
  Time: 3:33 PM
  To change this template use File | Settings | File Templates.
--%>

%{--<table style="height: 40px"  border="0" align="center" cellpadding="0" cellspacing="0">--}%
    %{--<tr>--}%
        %{--<td height="30" bgcolor="#939393">--}%
            %{--<table width="100%" border="0" cellspacing="0" cellpadding="0">--}%
            %{--<tr>--}%
                %{--<td rowspan="2">&nbsp;</td>--}%
                %{--<td   rowspan="2" cldass="smalltxt">--}%
                    %{--<sec:ifLoggedIn>--}%
                        %{--<a href="${createLink(uri: '/dataCollection/home')}" class="txtlink2">Home</a> |--}%
                    %{--</sec:ifLoggedIn>--}%
                    %{--<a href="http://www.damyant.com" target="_blank" class="txtlink2">About Us</a> |--}%
                    %{--<a href="http://www.damyant.com/contact.html" target="_blank" class="txtlink2">Contact Us</a><br/></td>--}%
                %{--<td  align="right"--}%
                    %{--class="smalltxt">Copyright Â© 2011 Damyant Softwares, All Rights Reserved.</td>--}%
                %{--<td style="width:3%" rowspan="2">&nbsp;</td>--}%
            %{--</tr>--}%

        %{--</table></td>--}%
    %{--</tr>--}%
%{--</table>--}%

 <div style="width: 100%; height: 70px;">

    <p>
<sec:ifLoggedIn>
<a href="${createLink(uri: '/dataCollection/home')}" style="color: #2081A1;margin-left: 40%" class="txtlink2">Home</a>
<a href="http://www.damyant.com" target="_blank" style="color: #2081A1;margin-left: 50px" class="txtlink2">About Us</a>
<a href="http://www.damyant.com/contact.html" target="_blank" style="color: #2081A1;margin-left:50px" class="txtlink2">Contact Us</a>
    </sec:ifLoggedIn>
</p>
<p>
<span style="float: left;margin-left: 42%;color: #2081A1; margin-top: 20px">Copyright  @ Damyant Software Pvt. Ltd.</span>
</p>

</div>