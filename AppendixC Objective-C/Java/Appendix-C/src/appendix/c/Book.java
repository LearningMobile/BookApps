/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package appendix.c;

/**
 *
 * @author iversen
 */
class Book {
    private String title;
    private String author;
    private int pages;
    private String lender;
    private boolean out;

    public Book() {
    }

    public Book(String title) {
        this.title = title;
        this.author = author;
    }
    
    public static Book createBook(String title) {
        Book book = new Book(title);
        return book;
    }
    
    public static Book createBook(String title, String author) {
        Book book = new Book(title);
        book.author = author;
        return book;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
public int getPages () {
    return pages;
}
    public void setPages(int pages) {
        this.pages = pages;
    }
    
    public String getLender() {
        return lender;
    }
    
    public boolean isOut() {
        return out;
    }
    
    public void lendout(String lenderName) {
        this.lender = lenderName;
        out = true;
    }
    
    public void returnBook() {
        lender = null;
        out = false;
    }
    
}
