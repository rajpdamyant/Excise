package challan

import grails.test.*

class DistrictOfficeControllerTests extends ControllerUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testRenderHomePage() {
    controller.test()
    assertEquals "Welcome to the gTunes store!",
    controller.response.contentAsString


    }
}
