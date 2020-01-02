<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sejong.namu.dto.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../part/head.jspf"%>

<div class="article-detail table-common con">
	<table>
		<colgroup>
			<col width="95">
		</colgroup>
		<tbody>
			<tr>
				<th>닉네임</th>
				<td><c:out value="${member.name}" escapeXml="true" /></td>
			</tr>
			<tr>
				<th>ID</th>
				<td><c:out value="${member.loginId}" /></td>
			</tr>
			<tr>
				<th>가입날짜</th>
				<td><c:out value="${member.regDate}" /></td>
			</tr>
		</tbody>

	</table>
</div>
<div class="con ">
	<button
		style="cursor: pointer; border: 1px solid #dcdcdc; display: inline-block; color: #777777; font-family: Arial; font-size: 15px; font-weight: bold; padding: 4px 15px; text-decoration: none; text-shadow: 0px 1px 0px #ffffff; -moz-box-shadow: inset 0px 1px 0px 0px #ffffff; -webkit-box-shadow: inset 0px 1px 0px 0px #ffffff; box-shadow: inset 0px 1px 0px 0px #ffffff; background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf)); background: -moz-linear-gradient(top, #ededed 5%, #dfdfdf 100%); background: -webkit-linear-gradient(top, #ededed 5%, #dfdfdf 100%); background: -o-linear-gradient(top, #ededed 5%, #dfdfdf 100%); background: -ms-linear-gradient(top, #ededed 5%, #dfdfdf 100%); background: linear-gradient(to bottom, #ededed 5%, #dfdfdf 100%); filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf', GradientType=0); background-color: #ededed; -moz-border-radius: 3px; -webkit-border-radius: 3px; margin-top:5px;"
		type="button"
		onclick="location.href = '/member/modify?id=${member.id}';">회원정보수정</button>
</div>

<%@ include file="../part/foot.jspf"%>