<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:pageTemplate pageTitle="Users">
    <h1>Users</h1>
    <c:if test="${pageContext.request.isUserInRole('WRITE_USERS')}">
        <a href="${pageContext.request.contextPath}/AddUser" class="btn btn-primary btn-lg">Add User</a>
    </c:if>

    <form method="POST" action="${pageContext.request.contextPath}/Users">
        <div class="container text-center">
            <c:if test="${not empty users}">
                <c:forEach var="user" items="${users}">
                    <div class="row align-items-center mb-2">
                        <c:if test="${pageContext.request.isUserInRole('WRITE_USERS')}">
                            <div class="col-auto">
                                <label for="user_${user.id}" class="visually-hidden">Select ${user.username}</label>
                                <input id="user_${user.id}" type="checkbox" name="user_ids" value="${user.id}" />
                            </div>
                        </c:if>
                        <div class="col">
                            ${user.username}
                        </div>
                        <div class="col">
                            ${user.email}
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>

        <c:if test="${pageContext.request.isUserInRole('WRITE_USERS')}">
            <div class="mt-3">
                <button type="submit" class="btn btn-danger">Delete selected</button>
            </div>
        </c:if>
    </form>
    <c:if test="${not empty invoices}">
        <h2>Invoices</h2>
        <c:forEach var="username" items="${invoices}" varStatus="status">
            ${status.index + 1}. ${username}
            <br/>
        </c:forEach>
    </c:if>
</t:pageTemplate>