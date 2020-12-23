package com.spring.day1127;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository
// @Repository >> bean 객체로 만들어줌 >> bean 객체는 서버가 구동될때 딱하나만 자동으로 만들어짐
public class SungjukDAO {
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs = null;
	
	public int userCheck(MemberVO mVO) {
		String dbpasswd = "";
		
		int x = -1;
		
		try {
			conn=JDBCUtill.getConnection();
			
			pstmt = conn.prepareStatement("select * from s_member where hakbun = ?");
			pstmt.setString(1, mVO.getHakbun());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("pw");
				if(dbpasswd.equals(mVO.getPw())) {
					x=1;
				} else {
					x=0;
				}
			} else {
				x = -1;
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			JDBCUtill.closeResource(rs, pstmt, conn);
		}
		return x;
	}
	
	//insert(멤버, 성적)
	
	public int insertMember(MemberVO mVO) {
		int result = 0;
		
		try {
			conn = JDBCUtill.getConnection();
			
			pstmt = conn.prepareStatement("insert into s_member values(?,?,?,?,?,?)");
			pstmt.setString(1, mVO.getHakbun());
			pstmt.setString(2, mVO.getPw());
			pstmt.setString(3, mVO.getName());
			pstmt.setInt(4, mVO.getAge());
			pstmt.setString(5, mVO.getS_class());
			pstmt.setString(6, mVO.getEmail());

			result =pstmt.executeUpdate();
		} catch(Exception ex) {
			System.out.println("가입오류" + ex.getMessage());
			ex.printStackTrace();
		} finally {
			JDBCUtill.closeResource(pstmt, conn);
		}
		return result;
	}
	public int insertSungjuk(SungjukProcessVO sVO) {
		int result = 0;
		try {
			conn = JDBCUtill.getConnection();
			
			pstmt = conn.prepareStatement("insert into s_sungjuk values(?,?,?,?,?,?,?,?)");
			pstmt.setString(1, sVO.getHakbun());
			pstmt.setString(2, sVO.getName());
			pstmt.setInt(3, sVO.getKor());
			pstmt.setInt(4, sVO.getEng());
			pstmt.setInt(5, sVO.getMath());
			pstmt.setInt(6, sVO.getTot());
			pstmt.setDouble(7, sVO.getAvg());
			pstmt.setString(8, sVO.getGrade());

			result =pstmt.executeUpdate();
		} catch(Exception ex) {
			System.out.println("성적입력오류" + ex.getMessage());
			ex.printStackTrace();
		} finally {
			JDBCUtill.closeResource(pstmt, conn);
		}
		return result;
	}
	
	//리스트 조회 (성적, 멤버)
	
	public ArrayList<SungjukProcessVO> getSungjuklist(){
		SungjukProcessVO vo = null;
		ArrayList<SungjukProcessVO> sungjuk_list =new ArrayList<SungjukProcessVO>();
		
		try {
			conn=JDBCUtill.getConnection();
			pstmt = conn.prepareStatement("select rownum Rank, s.* from s_sungjuk s order by avg desc");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					vo = new SungjukProcessVO();
					vo.setHakbun(rs.getString("hakbun"));
					vo.setName(rs.getString("name"));
					vo.setKor(rs.getInt("kor"));
					vo.setEng(rs.getInt("eng"));
					vo.setMath(rs.getInt("math"));
					vo.setTot(rs.getInt("tot"));
					vo.setAvg(rs.getDouble("avg"));
					vo.setGrade(rs.getString("grade"));

					sungjuk_list.add(vo);
					
				}while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtill.closeResource(rs, pstmt, conn);
		}
		return sungjuk_list;
	}
	public ArrayList<MemberVO> getMemberlist(){
		MemberVO vo = null;
		ArrayList<MemberVO> member_list =null;
		
		try {
			conn=JDBCUtill.getConnection();
			pstmt = conn.prepareStatement("select * from s_member order by hakbun");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member_list = new ArrayList<MemberVO>();
				do {
					vo = new MemberVO();
					vo.setHakbun(rs.getString("hakbun"));
					vo.setPw(rs.getString("pw"));
					vo.setName(rs.getString("name"));
					vo.setAge(rs.getInt("age"));
					vo.setS_class(rs.getString("s_class"));
					vo.setEmail(rs.getString("email"));

					member_list.add(vo);
					
				}while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtill.closeResource(rs, pstmt, conn);
		}
		return member_list;
	}
	
	// 단일 조회 (멤버, 성적)
	public MemberVO selectMember(MemberVO memberVO) {
	MemberVO vo = null;
	
	try {
		conn= JDBCUtill.getConnection();
		pstmt = conn.prepareStatement("select * from s_member where hakbun=?");
		pstmt.setString(1, memberVO.getHakbun());
		rs = pstmt.executeQuery();
		rs.next();
		
		vo = new MemberVO();
		vo.setHakbun(rs.getString("hakbun"));
		vo.setPw(rs.getString("pw"));
		vo.setName(rs.getString("name"));
		vo.setAge(rs.getInt("age"));
		vo.setS_class(rs.getString("s_class"));
		vo.setEmail(rs.getString("email"));
		
	}catch(Exception ex) {
		ex.printStackTrace();
	}finally {
		JDBCUtill.closeResource(rs, pstmt, conn);
	}
	return vo;
}
	public SungjukProcessVO selectSungjuk(SungjukProcessVO sVO) {
		SungjukProcessVO svo = new SungjukProcessVO();
	
	try {
		conn= JDBCUtill.getConnection();
		pstmt = conn.prepareStatement("select * from s_sungjuk where hakbun=?");
		pstmt.setString(1, sVO.getHakbun());
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
		svo.setHakbun(rs.getString("hakbun"));
		svo.setName(rs.getString("name"));
		svo.setKor(rs.getInt("kor"));
		svo.setEng(rs.getInt("eng"));
		svo.setMath(rs.getInt("math"));
		svo.setTot(rs.getInt("tot"));
		svo.setAvg(rs.getDouble("avg"));
		svo.setGrade(rs.getString("grade"));
		}
		
	}catch(Exception ex) {
		ex.printStackTrace();
	}finally {
		JDBCUtill.closeResource(rs, pstmt, conn);
	}
	return svo;
}
	/*public HashMap<String,Object> selectMember(MemberVO memberVO) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		MemberVO vo = null;
		SungjukProcessVO svo =null;
		
		try {
			conn= JDBCUtill.getConnection();
			pstmt = conn.prepareStatement("select * from s_member where hakbun=?");
			pstmt.setString(1, memberVO.getHakbun());
			rs = pstmt.executeQuery();
			rs.next();
			
			vo = new MemberVO();
			vo.setHakbun(rs.getString("hakbun"));
			vo.setPw(rs.getString("pw"));
			vo.setName(rs.getString("name"));
			vo.setAge(rs.getInt("age"));
			vo.setS_class(rs.getString("s_class"));
			vo.setEmail(rs.getString("email"));
			
			map.put(vo.hakbun, vo);
			
			pstmt = conn.prepareStatement("select * from s_sungjuk where hakbun=?");
			pstmt.setString(1, memberVO.getHakbun());
			rs = pstmt.executeQuery();
			rs.next();
			
			svo = new SungjukProcessVO();
			svo.setHakbun(rs.getString("hakbun"));
			svo.setName(rs.getString("name"));
			svo.setKor(rs.getInt("kor"));
			svo.setEng(rs.getInt("eng"));
			svo.setMath(rs.getInt("math"));
			svo.setTot(rs.getInt("tot"));
			svo.setAvg(rs.getDouble("avg"));
			svo.setGrade(rs.getString("grade"));
			
			map.put(vo.hakbun, svo);

		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtill.closeResource(rs, pstmt, conn);
		}
		return map;
	}*/
	
	//삭제 (멤버, 성적)
	
	public int deleteMember(MemberVO memberVO) {
		int result = 0;
		
		try {
			conn = JDBCUtill.getConnection();
			pstmt = conn.prepareStatement("delete from s_member where hakbun=?");
			pstmt.setString(1, memberVO.getHakbun());
			result = pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtill.closeResource(pstmt, conn);
		}
		return result;
	}
	public int deleteSungjuk(SungjukProcessVO sVO) {
		int result = 0;
		
		try {
			conn = JDBCUtill.getConnection();
			pstmt = conn.prepareStatement("delete from s_sungjuk where hakbun=?");
			pstmt.setString(1, sVO.getHakbun());
			result = pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtill.closeResource(pstmt, conn);
		}
		return result;
	}
	
	//수정 (멤버, 성적)
	public int updateMember(MemberVO mVO) {
		int result= 0;
		try {
			conn= JDBCUtill.getConnection();
			pstmt = conn.prepareStatement("UPDATE S_MEMBER SET Pw=?, NAME=?, AGE=?, S_CLASS=?, EMAIL=?  WHERE HAKBUN =?");			
			pstmt.setString(1, mVO.getPw());
			pstmt.setString(2, mVO.getName());
			pstmt.setInt(3, mVO.getAge());
			pstmt.setString(4, mVO.getS_class());
			pstmt.setString(5, mVO.getEmail());
			pstmt.setString(6, mVO.getHakbun());
			
			result=pstmt.executeUpdate();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtill.closeResource(rs, pstmt, conn);
		}
		return result;
	}
	public int updateSungjuk(SungjukProcessVO sVO) {
		int result= 0;
		try {
			conn= JDBCUtill.getConnection();
			pstmt = conn.prepareStatement("UPDATE S_sungjuk SET NAME=?, KOR=?, ENG=?, MATH=?, TOT=?, AVG=?, GRADE=?  WHERE HAKBUN =?");		
			pstmt.setString(1, sVO.getName());
			pstmt.setInt(2, sVO.getKor());
			pstmt.setInt(3, sVO.getEng());
			pstmt.setInt(4, sVO.getMath());
			pstmt.setInt(5, sVO.getTot());
			pstmt.setDouble(6, sVO.getAvg());
			pstmt.setString(6, sVO.getGrade());
			pstmt.setString(6, sVO.getHakbun());

			result=pstmt.executeUpdate();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			JDBCUtill.closeResource(rs, pstmt, conn);
		}
		return result;
	}
}
