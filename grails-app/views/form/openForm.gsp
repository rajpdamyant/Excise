<%--
  Created by IntelliJ IDEA.
  User: shweta
  Date: 1/23/14
  Time: 4:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <head>
    <title>Form</title>
<g:javascript library="jquery" plugin="jquery"/>
<meta name="layout" content="main"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<script type="text/javascript">
</script>
</head>
</head>
<body>
<form id=formID1>
    <table style="border: none">


        <tr>
            <td > <label>Name : &nbsp; </label>

             <input type="text" name="name" class="text-input"/>
            </td>

            <td >
                <label>Date:&nbsp;&nbsp;</label><input id="datePickerDate" name="selectionDate" type="text" readonly="true" class="validate[required,custom[selectDate]] text-input">
            </td>
        </tr>
        <tr>
            <td  > <label>Details of Permanent Account Number
            : &nbsp; </label>

                <input type="text" name="name" class="text-input"/>
            </td>
            <td  > <label>Address of business premises: &nbsp; </label>

                <input type='text' name="address" class="text-input"  />
            </td>
        </tr>
        <tr>
            <td  > <label>Details of Permanent Account Number
            : &nbsp; </label>

                <input type="text" name="name" class="text-input"/>
            </td>
            <td  > <label>Address of business premises: &nbsp; </label>

                <input type='text' name="address" class="text-input"  />
            </td>
        </tr>
        <tr>
            <td  > <label>Details of Permanent Account Number
            : &nbsp; </label>

                <input type="text" name="name" class="text-input"/>
            </td>
            <td  > <label>Address of business premises: &nbsp; </label>

                <input type='text' name="address" class="text-input"  />
            </td>
        </tr>




    </table>
</table>
    <div class="middleDiv" id="accountHead">
    </div>
    <table style="border: none">
        <tr>
            <td colspan="4">
                <input type="submit" value="Submit" onclick="submitForm()" class="${classs} buttonCss" >
                <input type="button" value="Cancel" onclick="reset1()" class="${classs} buttonCss"/>

            </td>
        </tr>
    </table>
</form>
</body>
</html>