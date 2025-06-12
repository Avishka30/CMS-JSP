package lk.ijse.gdse.cmsjsp.db;

import org.apache.commons.dbcp2.BasicDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBConnectionPool {
    private static BasicDataSource dataSource;

    static {
        dataSource = new BasicDataSource();
        dataSource.setUrl("jdbc:mysql://localhost:3306/cms");
        dataSource.setUsername("root");
        dataSource.setPassword("avishka12345");

        dataSource.setMinIdle(5);
        dataSource.setMaxIdle(20);
        dataSource.setMaxOpenPreparedStatements(100);

        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
