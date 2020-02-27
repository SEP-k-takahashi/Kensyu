package Listpkg;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddBL
 */
@WebServlet("/AddBL")
public class AddBL extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddBL() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//接続変数
		Connection connect;
		Statement stmt ;
		ResultSet rs ;

		//抽出クエリ文字列
		String SelectQuery;
		String InsQuery;

		String name = request.getParameter("name") ;
		String address = request.getParameter("address") ;
		String tel = request.getParameter("tel") ;


		try {
			Class.forName("com.mysql.jdbc.Driver");
			connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb?characterEncoding=UTF-8&serverTimezone=JST","root", "1234567890");
			stmt = connect.createStatement();

			InsQuery = "Insert into tbl_jusho (name,address,number,delete_flg)VALUES (?,?,?,'1')";
			PreparedStatement ps = connect.prepareStatement(InsQuery);
			ps.setString(1, name);
			ps.setString(2, address);
			ps.setString(3, tel);

			try {

				ps.executeUpdate();
				connect.commit();

			}catch(Exception e){

				connect.rollback();
			}

		} catch (ClassNotFoundException | SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}

		// TODO Auto-generated method stub
		//doGet(request, response);
		response.sendRedirect("./AddressList.jsp");


	}

}

