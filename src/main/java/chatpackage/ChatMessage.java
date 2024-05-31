package chatpackage;


import java.sql.Timestamp;

public class ChatMessage {
    private String customerId;
    private String message;
    private Timestamp chatTime;

    public ChatMessage(String customerId, String message, Timestamp chatTime) {
        this.customerId = customerId;
        this.message = message;
        this.chatTime = chatTime;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getChatTime() {
        return chatTime;
    }

    public void setChatTime(Timestamp chatTime) {
        this.chatTime = chatTime;
    }
}
