<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 관리자 메뉴 include -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소), /shop/partial/submenu.jsp -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>	
	<h1>관리자페이지</h1>
	<div><%=loginMember.getMemberId() %>님 반갑습니다!</div>
</body>
</html>