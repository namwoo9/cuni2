<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sejong.namu.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="홈" />
<%@ include file="../part/head.jspf"%>

<h3 class="con">메인화면 입니다.</h3>


<%-- <c:if test="${loginedMember != null}"> --%>
<%-- 	<div class="con">${loginedMember.name}님 안녕하세요.</div> --%>
<%-- </c:if> --%>
<%@ include file="../part/foot.jspf"%>