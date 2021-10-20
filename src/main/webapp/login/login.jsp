<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%-- XML 파일 태그 시작전의 공백 문자 제거 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="result" value="false" />
<c:set var="span" value=""/>
<c:if test="${param.user_id == 'hong' && param.user_password == '111'}">
	<c:set var="result" value="true"/>
	<c:set var="span" value="message = 안녕하세요 홍길동님 ${param.user_id } ${param.user_password }" />
</c:if>
<c:if test="${param.user_id == 'hong' && param.user_password != '111'}">
	<c:set var="result" value="false"/>
	<c:set var="span" value="message = 비밀번호가 틀렸습니다 ${param.user_id } ${param.user_password }" />
</c:if>
<c:if test="${param.user_id != 'hong' && param.user_password == '111'}">
	<c:set var="result" value="false"/>
	<c:set var="span" value="message = 가입하지 않은 아이디입니다 ${param.user_id } ${param.user_password }" />
</c:if>

<?xml version="1.0" encoding="UTF-8"?>
<message>
	<result>${span }</result>
</message>
