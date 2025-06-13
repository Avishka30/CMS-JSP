package lk.ijse.gdse.cmsjsp.model;

import lk.ijse.gdse.cmsjsp.db.DBConnectionPool;
import lk.ijse.gdse.cmsjsp.dto.Complaint;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ComplaintModel {
    public boolean addComplaint(Complaint complaint) {

        String sql = "INSERT INTO complaints (title, description, status, user_id) VALUES (?, ?, 'PENDING', ?)";

        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, complaint.getTitle());
            stmt.setString(2, complaint.getDescription());
            stmt.setInt(3, complaint.getUserId());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
