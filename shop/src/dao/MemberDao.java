package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import vo.Member;
import commons.DBUtil;

public class MemberDao {
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

