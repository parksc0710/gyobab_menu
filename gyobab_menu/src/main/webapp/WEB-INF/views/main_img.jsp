<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="rand"><%= java.lang.Math.round(java.lang.Math.random() * 19) %></c:set>

<c:choose>
	<c:when test="${rand eq 0}">
		<img src="https://www.gyobab.shop/images/main/r1.png" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 1}">
		<img src="https://www.gyobab.shop/images/main/r2.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 2}">
		<img src="https://www.gyobab.shop/images/main/r3.png" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 3}">
		<img src="https://www.gyobab.shop/images/main/r4.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 4}">
		<img src="https://www.gyobab.shop/images/main/r5.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 5}">
		<img src="https://www.gyobab.shop/images/main/r6.png" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 6}">
		<img src="https://www.gyobab.shop/images/main/r7.png" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 7}">
		<img src="https://www.gyobab.shop/images/main/r8.png" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 8}">
		<img src="https://www.gyobab.shop/images/main/r9.png" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 9}">
		<img src="https://www.gyobab.shop/images/main/r10.png" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 10}">
		<img src="https://www.gyobab.shop/images/main/r11.jpg" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 11}">
		<img src="https://www.gyobab.shop/images/main/r12.jpg" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 12}">
		<img src="https://www.gyobab.shop/images/main/r13.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 13}">
		<img src="https://www.gyobab.shop/images/main/r14.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 14}">
		<img src="https://www.gyobab.shop/images/main/r15.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 15}">
		<img src="https://www.gyobab.shop/images/main/r16.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 16}">
		<img src="https://www.gyobab.shop/images/main/r17.jpg" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 17}">
		<img src="https://www.gyobab.shop/images/main/r18.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 18}">
		<img src="https://www.gyobab.shop/images/main/r19.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:when test="${rand eq 19}">
		<img src="https://www.gyobab.shop/images/main/r20.gif" style="width:100%;max-width:639px;"/><br>
	</c:when>
	<c:otherwise>
		<img src="https://www.gyobab.shop/images/main/r1.png" style="width:100%;max-width:639px;"/><br>
	</c:otherwise>
</c:choose>