package lk.ijse.gdse.cmsjsp.dto;

public class Complaint {

        private int id;
        private String title;
        private String description;
        private String status;
        private String remarks;
        private int userId;

        public Complaint() {}

        public Complaint(int id, String title, String description, String status, String remarks, int userId) {
            this.id = id;
            this.title = title;
            this.description = description;
            this.status = status;
            this.remarks = remarks;
            this.userId = userId;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getRemarks() {
            return remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
        }

        public int getUserId() {
            return userId;
        }

        public void setUserId(int userId) {
            this.userId = userId;
        }
}
