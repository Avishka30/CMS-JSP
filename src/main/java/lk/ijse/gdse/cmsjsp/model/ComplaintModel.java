package lk.ijse.gdse.cmsjsp.model;

import lk.ijse.gdse.cmsjsp.db.DBConnectionPool;
import lk.ijse.gdse.cmsjsp.dto.Complaint;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ComplaintModel {
    //employee
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

    public List<Complaint> getComplaintsByUserId(int userId) {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE user_id = ?";

        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setId(rs.getInt("id"));
                complaint.setTitle(rs.getString("title"));
                complaint.setDescription(rs.getString("description"));
                complaint.setStatus(rs.getString("status"));
                complaint.setRemarks(rs.getString("remarks"));
                complaint.setUserId(rs.getInt("user_id"));
                complaints.add(complaint);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return complaints;
    }
    public boolean updateComplaint(Complaint complaint) {
        String sql = "UPDATE complaints SET title = ?, description = ? WHERE id = ? AND status = 'PENDING'";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, complaint.getTitle());
            stmt.setString(2, complaint.getDescription());
            stmt.setInt(3, complaint.getId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteComplaint(int complaintId) {
        String sql = "DELETE FROM complaints WHERE id = ? AND status = 'PENDING'";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, complaintId);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Complaint getComplaintById(int id) {
        String sql = "SELECT * FROM complaints WHERE id = ?";
        try (Connection conn = DBConnectionPool.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Complaint c = new Complaint();
                c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                c.setRemarks(rs.getString("remarks"));
                c.setUserId(rs.getInt("user_id"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
     // admin

}
