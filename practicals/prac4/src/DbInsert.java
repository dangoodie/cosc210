
import java.sql.*;
import java.util.*;

public class  DbInsert{

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


	    System.out.println("\n****Inserting a New Employee*****");
	    System.out.println();
	   

	    // First we specify our query
	    Statement stmt = null;
	    try {
		//Create a new statement object - notice the additional arguments for inserting
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		//Get all record in the employee table
        	ResultSet uprs = stmt.executeQuery("SELECT * FROM employee");

		/* - Employee table. Here to show column list
			CREATE TABLE employee (
			    fname character varying(15) NOT NULL,
			    minit character varying(1),
			    lname character varying(15) NOT NULL,
			    ssn character(9) NOT NULL,
			    bdate date,
			    address character varying(50),
			    sex character(1),
			    salary numeric(10,2),
			    superssn character(9),
			    dno integer
			);

		*/
		//Create a new row in the ResultSet object
        	uprs.moveToInsertRow();
		//Add new employee's information to the new row of data
        	uprs.updateString("fname", "New_fname");
		uprs.updateString("minit", "S");
		uprs.updateString("lname", "New_lname");
		uprs.updateString("ssn", "112233445");
        	uprs.updateInt("dno", 5);
		//Insert the new row of data to the database
        	uprs.insertRow();
		//Move the cursor back to the start of the ResultSet object
        	uprs.beforeFirst();
	    } catch (SQLException e ) {
		System.out.println(e);
		conn.close();
		System.exit(1);
	    } 
	    
	    System.out.println("\nQuery Executed Successfully...exiting");
	    //Close the database connection
	    conn.close();
      }

}
