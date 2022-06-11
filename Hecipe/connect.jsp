<%@page import="java.sql.*" %>

<%!
public static final class Connect {
    
    private final String USERNAME = "root";
    private final String PASSWORD = "";
    private final String DATABASE = "hecipe";
    private final String HOST = "localhost:3306";
    private final String CONNECTION = String.format("jdbc:mysql://%s/%s", HOST, DATABASE);

    private Connection con;
    private Statement st;

    private Connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(CONNECTION, USERNAME, PASSWORD);
            st = con.createStatement();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    private static Connect instance;

    public static Connect getConnection(){
        if (instance == null){
            instance = new Connect();
        }

        return instance;
    }

    public ResultSet executeQuery(String query){
        ResultSet rs = null;
        try {
            rs = st.executeQuery(query);
        } catch(Exception e){
            e.printStackTrace();
        }

        return rs;
    }

    public Integer executeUpdate(String query){
        Integer result = 0;
        try {
            result = st.executeUpdate(query);
        } catch(Exception e){
            e.printStackTrace();
        }

        return result;
    }
}

%>