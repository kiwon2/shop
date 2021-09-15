<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인증 방어 코드 : 로그인 전에만 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	
	if(session.getAttribute("loginMember") != null) {
		System.out.println("이미 로그인 되어 있습니다.");
		response.sendRedirect("./index.jsp");
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
	<h1>로그인</h1>
	<form method="post" action="./loginAction.jsp">
		<div>memberId : </div>
		<div><input type="text" name="memberId"></div>
		<div>memberPw : </div>
		<div><input type="password" name="memberPw"></div>
		<div><button type="submit">로그인</button></div>
	</form>
</body>
</html>