<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:pageTemplate pageTitle="Cars">
    <h1>Cars</h1>
    <div class="container text-center">
        <div class="row">
            <div class="col">
                License Plate
            </div>
            <div class="col">
                Parking Spot
            </div>
            <div class="col">
                Owner Name
            </div>
        </div>
        <div class="row">
            <div class="col">
                SB28MAV
            </div>
            <div class="col">
                17
            </div>
            <div class="col">
                Andrei
            </div>
        </div>
    </div>
    <h5>Free parking spots: ${numberOfFreeParkingSpots}</h5>
</t:pageTemplate>