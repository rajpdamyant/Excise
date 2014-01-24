<%--
  Created by IntelliJ IDEA.
  User: Administration
  Date: 1/30/12
  Time: 3:34 PM
  To change this template use File | Settings | File Templates.
--%>

<div class="layout">

    <div style="width: 100%;height: 40%">
        <div style="float: left">
            <img src="${resource(dir: 'images', file: 'multiSystem.jpg')}" width="400px" height="200px"/>
        </div>

        <div style="float: right;width:600px">
            <div class="content_style">
                %{--<p>Multi-Tenant Information Management System - MIMS is an open-source system to support integrated data management, analytic and business intelligence services for Government and Enterprise Customers.--}%
                %{--</p>--}%
                <ul>
                    <li><h3>Features</h3></li>
                    <li>Provide an easy to use information processing gateway</li>
                    <li>Enable access to information from web or mobile apps</li>
                    <li>Enhance decision making by accessing right information at the right time</li>
                    <li>Build a collaborative ecosystem  to bring best industry best practices and processes</li>
                    <li>Improve Business ROI with zero IT overhead</li>
                    <li>Increase Operational Safety</li>
                </ul>
            </div>
        </div>
    </div>
    <sec:ifAnyGranted roles="ROLE_HEADQUARTER,ROLE_DISTRICT, ROLE_ADMIN">
        <div class="bottom_section">
            <h4>Online Excise Reporting System</h4>
            <ul>
                <li>Easy to use information processing gateway</li>
                <li>Access to information from web or mobile app</li>
                <li>Improved Operational Effectiveness by reducing redundancy, inefficiency and inaccuracy of data management &nbsp</li>
                <li>Increased Operational Safety</li>
                <li>Easy-to-use interface to upload all excise data collection at various superintendent office levels</li>
                <li>Automatic report generation at Corporate HQ, District Office, Superintendent Office levels</li>
                <li>Easy-to-use interface to upload all revenue data collection at various superintendent-office levels</li>
            </ul>
        </div>
    </sec:ifAnyGranted>
</div>



