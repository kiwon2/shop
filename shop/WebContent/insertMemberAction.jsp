<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");

	//로그인 상태에서는 페이지 접근불가
	if(session.getAttribute("loginMember")!=null){
		// 다시 브라우저에게 다른곳을 요청하도록 하는 메서드
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	//로그인 상태에서는 페이지 접근불가
	if(request.getParameter("memberId") ==null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null ||request.getParameter("memberAge") == null || request.getParameter("memberGender") == null){
	// 다시 브라우저에게 다른곳을 요청하도록 하는 메서드
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("") ||request.getParameter("memberAge").equals("") || request.getParameter("memberGender").equals("")){
		// 다시 브라우저에게 다른곳을 요청하도록 하는 메서드
			response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
			return;
		}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	//request 매개값 디버깅 코드
	System.out.println(memberId+" <--memberId");
	System.out.println(memberPw+" <--memberPw");
	System.out.println(memberName+" <--memberName");
	System.out.println(memberAge+" <--memberAge");
	System.out.println(memberGender+" <--memberGender");
	
	Member member = new Member();
	// request parma -> member vo
   member.setMemberId(memberId);
   member.setMemberPw(memberPw);
   member.setMemberName(memberName);
   member.setMemberAge(memberAge);
   member.setMemberGender(memberGender);
  

	MemberDao memberDao = new MemberDao();
	int row = memberDao.insertMember(member);
		
	if(row==1){
		System.out.println("입력성공");//디버깅
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	}else{
		System.out.println("입력실패");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
	}

	
%>