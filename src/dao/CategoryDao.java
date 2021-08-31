package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import entities.Category;

public class CategoryDao {
	private SessionFactory factory;

	public CategoryDao(SessionFactory factory) {
		super();
		this.factory = factory;
	}
	
	public int saveCategory(Category category) {
		Session session=this.factory.openSession();
		Transaction tx=session.beginTransaction();
		int catID=(int)session.save(category);
		tx.commit();
		session.close();
		return catID;
	}
	
	public List<Category> getCategories(){
		Session session=this.factory.openSession();
		Query q=session.createQuery("from Category");
		List<Category> list=q.list();
		session.close();
		return list;
	}
	
	public Category getCategoryById(int catId) {
		Category cat=null;
		try {
			Session session=this.factory.openSession();
			cat=session.get(Category.class, catId);
			session.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return cat;
	}
}
