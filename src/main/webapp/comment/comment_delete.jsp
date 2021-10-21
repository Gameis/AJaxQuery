<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	//DB 연동 할 때는 여기서 하면 된다.
	
	boolean result = false;
	String message = "덧글이 삭제에 실패했습니다.";
	
	if(num != 0) {
		result = true;
		message = "덧글이 삭제되었습니다.";
	}
%>

<?xml version="1.0" encoding="UTF-8"?>
<comment>
	<result><%=result %></result>
	<message><%=message %></message>
</comment>