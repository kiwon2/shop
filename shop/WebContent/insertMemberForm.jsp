<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
</head>
<body>
	<%
		//로그인 상태에서는 페이지 접근불가
		if(session.getAttribute("loginMember")!=null){
			// 다시 브라우저에게 다른곳을 요청하도록 하는 메서드
			response.sendRedirect("./index.jsp");
			return;
		}
	%>
	<h1>회원가입</h1>
	<form method="post" action="./insertMemberAction.jsp">
		<!-- 아이디 -->
		<div>memberId : </div>
		<input type="text" name="memberId">
		<!-- 비밀번호 -->
		<div>memberPw : </div>
		<div><input type="password" name="memberPw"></div>
		<!-- 이름 -->
		<div>memberName : </div>
		<div><input type="text" name="memberName"></div>
		<!-- 나이 -->
		<div>memberAge : </div>
		<div><input type="text" name="memberAge"></div>
		<!-- 성별 -->
		<div>memberGender : </div>
		<div>
			<input type="radio" name="memberGender" value="남">남
			<input type="radio" name="memberGender" value="여">여
		</div>
		<button type="submit">회원가입</button>
	</form>
</body>
</html>