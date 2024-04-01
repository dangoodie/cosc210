
import java.sql.*;
import java.util.*;

public class  DbTester{

	public static void main(String [] argv) throws Exception{
		String username = System.getenv("USERNAME");
		String password = System.getenv("PASSWORD");


	    Connection conn = null;
	    try
	    {
	      Class.forName("org.postgresql.Driver");
	      

      		String url = "jdbc:postgresql://localhost/prac_04";


	      conn = DriverManager.getConnection(url,username, password);
	    }
	    catch (ClassNotFoundException e)
	    {
	      e.printStackTrace();
	      System.exit(1);
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	      System.exit(2);
	    }
	    //Now we're connected up lets retrieve a list of employees


	    System.out.println("\n****Employees Currently Within the Database*****");
	    System.out.println();
	    //Print the column headings to the console
            System.out.printf("%-12s %-12s %n", "First Name","Last Name");
	    System.out.println("--------------------");

	    // First we specify our query
	    String query = "SELECT fname, lname FROM employee;";
	    Statement stmt = null;
	    try {
		//Create an sql statement object
		stmt = conn.createStatement();
		//Execute the query
		ResultSet rs = stmt.executeQuery(query);
		//Iterate through the results and print to the console
		while (rs.next()) {
		    String fName = rs.getString("fname");
		    String lName = rs.getString("lname");
		    System.out.printf("%-12s %-12s %n", fName,lName);
		}
	    } catch (SQLException e ) {
		System.out.println(e);
		conn.close();
		System.exit(1);
	    } 
	    System.out.println("--------------------");
	    System.out.println("\nQuery Executed Successfully...exiting");
	    //Close the database connection
	    conn.close();
      }

}
