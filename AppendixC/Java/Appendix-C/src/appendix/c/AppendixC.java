/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package appendix.c;

import java.util.ArrayList;

/**
 *
 * @author iversen
 */
public class AppendixC {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Book book1 = new Book();
        book1.setTitle("Moby Dick");
        book1.setAuthor("Herman Melville");
        book1.setPages(899);
        
        Book book2 = Book.createBook("To Kill a Mockingbird", "Harper Lee");
        book2.setPages(359);
        
        book1.lendout("Jim Smith");
        book2.lendout("Mary Jane");
        book1.returnBook();
        
        if(book1.isOut()) {
            System.out.println(book1.getTitle() + " is lent out to " + book1.getLender());
        }
        else {
            System.out.println(book1.getTitle() + " is not lent out");
        }
        
        ArrayList<Book> books = new ArrayList<>();
        books.add(book1);
        books.add(book2);
        for(Book book : books) {
            System.out.println(book.getTitle() + ", " + book1.getPages() + " pages.");
        }
        
    }
}
