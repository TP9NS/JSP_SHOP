package chatpackage;

import java.sql.*;
import java.util.concurrent.*;

public class ChatCleanupTask implements Runnable {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/shop2";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "psh0811";

    @Override
    public void run() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sqlDeleteOldChats = "DELETE FROM chatstatus WHERE chatstatus='문의가 종료되었습니다.' AND chatdate < NOW() - INTERVAL 3 DAY";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            pstmt = conn.prepareStatement(sqlDeleteOldChats);
            int deletedRows = pstmt.executeUpdate();
            System.out.println("Deleted rows: " + deletedRows);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
            if (conn != null) try { conn.close(); } catch (SQLException ex) { }
        }
    }

    public static void main(String[] args) {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        ChatCleanupTask cleanupTask = new ChatCleanupTask();
        // Schedule the task to run once a day
        scheduler.scheduleAtFixedRate(cleanupTask, 0, 1, TimeUnit.DAYS);
    }
}
