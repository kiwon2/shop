<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>  
<%@ page import = "java.util.*" %>  
<%
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel()<1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	
	//검색어
	String searchMemberId = "";
	if(request.getParameter("memberId")!=null){
		searchMemberId = request.getParameter("searchMemberId");
	}
	System.out.println(searchMemberId+" <--selectMemberList searchMemberId");
	
	//페이지
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
	}
	System.out.println(currentPage+" <--selectMemberList currentPage");
	final int ROW_PER_PAGE = 10; //상수 : rowPerPage변수 10으로 초기화되면 끝까지 10이다. --> 상수
	
	int beginRow = (1-currentPage)*ROW_PER_PAGE;
	
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = null;
	if(searchMemberId.equals("") == true) { // 검색어가 없을 경우
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
	} else { // 검색어가 있을때
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE, searchMemberId);
	}
	int totalCount = memberDao.totalMemberCount();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소), /shop/partial/submenu.jsp -->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<h1>회원 목록</h1>
	<table border="1">
		<thead>
			<tr>
				<th>memberNo</th>
				<th>memberLevel</th>
				<th>memberName</th>
				<th>memberAge</th>
				<th>memberGender</th>
				<th>updateDate</th>
				<th>createDate</th>

			</tr>
		</thead>
		<tbody>
			<%
				for(Member m : memberList){
			%>
					<tr>
						<td><%=m.getMemberNo() %></td>
						<td>
							<%=m.getMemberLevel() %>
							<%
								if(m.getMemberLevel()==0){
							%>
									<span>일반회원</span>
							<%
								}else if(m.getMemberLevel()==1){
							%>
									<span>관리자 계정</span>
							<%
								}
							%>
						</td>
						<td><%=m.getMemberName() %></td>
						<td><%=m.getMemberAge() %></td>
						<td><%=m.getMemberGender() %></td>
						<td><%=m.getUpdateDate() %></td>
						<td><%=m.getCreateDate() %></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<div>
	<%
		// ISSUE : 페이지 잘되었는데... 검색한후 페이징하면 안된다 -> ISSUE 해결
		if (currentPage > 1) {
	%>
		<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage-1%>&searchMemberId=<%=searchMemberId%>">이전</a>
	<%
		}
	%>
	<%		
		int lastPage = totalCount / ROW_PER_PAGE;
		
		if (totalCount % ROW_PER_PAGE != 0) {
			lastPage += 1;
		}
	
		if (currentPage < lastPage) {
	%>
		<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage+1%>&searchMemberId=<%=searchMemberId%>">다음</a>
	<%
	}
	%>
	</div>
	<!-- memberId로 검색 -->
	<div>
		<form action="<%=request.getContextPath() %>/admin/selectMemberList.jsp" method="get">
			memberId : 
			<input type="text" name="searchMemberId">
			<button type="submit">검색</button>
		
		</form>
	
	</div>
</body>
</html>