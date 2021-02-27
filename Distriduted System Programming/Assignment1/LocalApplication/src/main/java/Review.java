
import java.io.Serializable;

public class Review implements Serializable {
    private String id;
    private String link;
    private String title;
    private String text;
    private long rating;
    private String author;
    private String date;

    public Review(String id, String link, String title, String text, long rating, String author, String date) {
        this.id = id;
        this.link = link;
        this.title = title;
        this.text = text;
        this.rating = rating;
        this.author = author;
        this.date = date;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public long getRating() {
        return rating;
    }

    public void setRating(long rating) {
        this.rating = rating;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void printReview() {
        System.out.println(this.id);
        System.out.println(this.link);
        System.out.println(this.title);
        System.out.println(this.text);
        System.out.println(this.rating);
        System.out.println(this.author);
        System.out.println(this.date);
    }
}