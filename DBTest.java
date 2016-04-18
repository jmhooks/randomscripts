package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.jws.WebService;
import com.mysql.jdbc.Statement;

@WebService
public class DBTest {
	
	private ArrayList<String> actorList = new ArrayList<String>();
	private Connection connection;
	
//	public static void main(String[] args){
//		DBTest actors = new DBTest();
//		System.out.println(actors.connectUp());
//		actors.addActor("first","michael");
//		actors.addActor("first","john");
//		actors.addActor("first","jim");
//		actors.addActor("last","wood");
//		actors.printActorList();
//	}

	public ArrayList<String> printActorList() {
		for(String a : actorList){
			System.out.println("Name: " + a);
		}
		return this.actorList;
	}
	
	/*
	 * Establish a connection with the default database (sakila)
	 */
	public String connectUp(){
		String url = "jdbc:mysql://localhost:3306/sakila?useSSL=false";
		String username = "root";
		String password = "password";
		
		try {
			this.connection = DriverManager.getConnection(url, username, password);
			Statement stmt = (Statement) connection.createStatement();
			String query = "select * from actor where first_name = 'JOHN'";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
			    	String firstName = rs.getString(2);
			        String lastName = rs.getString(3);
			        String adding = firstName + " " + lastName;
			        return adding;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return "Connected22!";
	}
	
	/*
	 * Establish a connection with a specific database
	 */
//	public void connectUp(String db){
//		String url = "jdbc:mysql://localhost:3306/" + db;
//		String username = "root";
//		String password = "password";
//		try {
//			this.connection = DriverManager.getConnection(url, username, password);
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}
	
	/*
	 * Add actor to the ArrayList titles actorList
	 */
	public String addActor(String firstorlast, String strIn) {
		try {
			strIn = "'" + strIn.toUpperCase() + "'";
			Statement stmt = (Statement) connection.createStatement();
			String query = "";
			switch (firstorlast){
				case "first":
					query = "select * from actor where first_name = " + strIn;
					break;
				case "last":
					query = "select * from actor where last_name = " + strIn;
					break;
				default:
					query = "select * from actor where first_name = " + strIn;
			}
			
			
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
			    	String firstName = rs.getString(2);
			        String lastName = rs.getString(3);
			        String adding = firstName + " " + lastName;
			        actorList.add(adding);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "Added actors!";
	}

}
