package com.spring.day1125;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping(value = "inputForm.me")
	public String inputForm() {
				
		return "inputform";
	}
	@RequestMapping(value = "inputProcess.me")
	public String inputProcess(EmpVO vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
			String sql = "insert into emp_copy values(?,?,?,?, sysdate, ?,?,?)";
			
			Class.forName(driver);
			con= DriverManager.getConnection(url, "scott", "123456");
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,  vo.getEmpno());
			pstmt.setString(2, vo.getEname());
			pstmt.setString(3, vo.getJob());
			pstmt.setInt(4, vo.getMgr());
			pstmt.setDouble(5, vo.getSal());
			pstmt.setDouble(6, vo.getComm());
			pstmt.setInt(7, vo.getDeptno());
			System.out.println(pstmt);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			
		}
		return "index";
	}
	@RequestMapping(value = "selectProcess.me")
	public String selectProcess(Model model) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
			Class.forName(driver);
			con= DriverManager.getConnection(url, "scott", "123456");
			
			pstmt = con.prepareStatement("select * from emp_copy order by ename asc");
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				EmpVO empvo = new EmpVO();
				empvo.setEmpno(rs.getInt("empno"));
				empvo.setEname(rs.getString("ename"));
				empvo.setJob(rs.getString("job"));
				empvo.setMgr(rs.getInt("mgr"));
				empvo.setHiredate(rs.getDate("hiredate"));
				empvo.setSal(rs.getDouble("sal"));
				empvo.setComm(rs.getDouble("comm"));
				empvo.setDeptno(rs.getInt("deptno"));
				list.add(empvo);
			}
			model.addAttribute("list",list);
			
		}catch(Exception e) {
			
		}
		return "list";
	}
	@RequestMapping(value = "selectDept.me")
	public String selectDept(Model model, @RequestParam(value="deptno", required=false, defaultValue="1") int deptno) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DeptVO deptvo = null;
		
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
			
			Class.forName(driver);
			con= DriverManager.getConnection(url, "scott", "123456");
			
			pstmt = con.prepareStatement("select * from dept_copy where deptno=?");
			pstmt.setInt(1, deptno);
			rs= pstmt.executeQuery();
			
			rs.next();
				deptvo = new DeptVO();
				deptvo.setDeptno(rs.getInt("deptno"));
				deptvo.setDname(rs.getString("dname"));
				deptvo.setLoc(rs.getString("loc"));

			model.addAttribute("deptvo", deptvo);
			
		}catch(Exception e) {
			
		}
		return "deptview";
	}
	@RequestMapping(value = "selectEmpDept.me")
	public String selectEmpDept(Model model) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<EmpDeptVO> list = new ArrayList<EmpDeptVO>();
		EmpDeptVO edvo = null;
		
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
			
			Class.forName(driver);
			con= DriverManager.getConnection(url, "scott", "123456");
			
			pstmt = con.prepareStatement("select empno, ename, job, e.deptno deptno, dname, loc from emp_copy e, dept_copy d"
					+ " where e.deptno=d.deptno");
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				edvo = new EmpDeptVO();
				edvo.setEmpno(rs.getInt("empno"));
				edvo.setEname(rs.getString("ename"));
				edvo.setJob(rs.getString("job"));
				edvo.setDeptno(rs.getInt("deptno"));
				edvo.setDname(rs.getString("dname"));
				edvo.setLoc(rs.getString("loc"));
				list.add(edvo);
			}
			model.addAttribute("list", list);
			
		}catch(Exception e) {
			
		}
		return "empNdept";
	}
}
