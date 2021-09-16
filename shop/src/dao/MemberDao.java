package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Member;
import commons.DBUtil;

public class MemberDao {
	
	//[관리자] 회원 리스트 관리(회원목록출력)
	public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow, int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException{
		ArrayList<Member> list = new ArrayList<Member>();
		System.out.println(beginRow+" <--beginRow");
		System.out.println(rowPerPage + " <--rowPerPage");
		
		//DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_Age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id LIKE ? ORDER BY create_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,"%"+searchMemberId+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
		
	}
	
	// [관리자] 회원목록출력
	public ArrayList<Member> selectMemberListAllByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException{
		ArrayList<Member> list = new ArrayList<Member>();
		System.out.println(beginRow + " <--beinRow");
		System.out.println(rowPerPage + " <--rowPerPage");
		//DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_Age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
		
	}
	
	//총 멤버 수
	public int totalMemberCount() throws ClassNotFoundException, SQLException {
		int totalCount = 0;
		//DB접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT count(*) FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		
		return totalCount;
		
	}
	public int insertMember(Member member) throws ClassNotFoundException, SQLException { //회원가입

		System.out.println(member.getMemberId()+" <-- MemberDao.insertMember param: memberId");
		System.out.println(member.getMemberPw()+" <-- MemberDao.insertMember param: memberPw");
		System.out.println(member.getMemberLevel()+" <-- MemberDao.insertMember param: memberLevel");
		System.out.println(member.getMemberName()+" <-- MemberDao.insertMember param: memberName");
		System.out.println(member.getMemberAge()+" <-- MemberDao.insertMember param: memberAge");
		System.out.println(member.getMemberGender()+" <-- MemberDao.insertMember param: memberGender");
		System.out.println(member.getUpdateDate()+" <-- MemberDao.insertMember param: updateDate");
		System.out.println(member.getCreateDate()+" <-- MemberDao.insertMember param: updateDate");

		//DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "insert into member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date) VALUES (?,?,0,?,?,?,NOW(),NOW())";		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.setInt(4, member.getMemberAge());
		stmt.setString(5, member.getMemberGender());
		int row = stmt.executeUpdate();
		//System.out.println(row+"<--stmt");
		
		stmt.close();
		conn.close();
		return row;		

	}
	public Member login(Member member) throws SQLException, ClassNotFoundException { //로그인
		System.out.println(member.getMemberId()+" <-- MemberDao.login param : memberId");
		System.out.println(member.getMemberPw()+" <-- MemberDao.login param : memberPw");
		//DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo,member_id memberId, member_name memberName FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			Member returnMember = new Member();
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberName(rs.getString("memberName"));
			return returnMember;
		}
		stmt.close();
		conn.close();
		rs.close();
		return null;
		
	}
	
	}

