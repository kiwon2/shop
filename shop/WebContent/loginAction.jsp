<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	// request값 디버깅
	
	MemberDao memberDao = new MemberDao();
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 성공시 : memberId + memberName
	// 실패시 : null
	Member returnMebmer = memberDao.login(paramMember);
	// 디비깅
	if(returnMebmer == null) {
		System.out.println("로그인 실패");
		response.sendRedirect("./loginForm.jsp");
		return;
	} else {
		System.out.println("로그인 성공");
		System.out.println(returnMebmer.getMemberId());
		System.out.println(returnMebmer.getMemberName());
		// request, session : JSP내장객체
		// 한 사용자의 공간(session)에 변수를 생성
		session.setAttribute("loginMember", returnMebmer);
		response.sendRedirect("./index.jsp");
	}
	
	
%>