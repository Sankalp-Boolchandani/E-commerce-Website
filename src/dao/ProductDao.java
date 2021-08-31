package dao;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import entities.Product;

public class ProductDao {
	private SessionFactory factory;

	public ProductDao(SessionFactory factory) {
		super();
		this.factory = factory;
	}

	public boolean saveProduct(Product product) {
		boolean x = false;
		try {
			Session session = this.factory.openSession();
			Transaction tx = session.beginTransaction();

			session.save(product);
			System.out.print(product.getCategory());
			tx.commit();
			session.close();
			x = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			x = false;
		}
		return x;
	}
	
	//get all products
	public List<Product> getProducts() {
		Session session=this.factory.openSession();
		Query query=session.createQuery("FROM Product");
		List<Product> list=query.list();
		session.close();
		return list;
	}
	
	//get all products of given category by id
		public List<Product> getAllProductsById(int cid) {
			int x=cid;
			Session session=this.factory.openSession();
			String hql = "FROM Product P WHERE P.category.categoryId = :id";
			List<Product> list=session.createQuery(hql).setParameter("id", x).list();
			//query.setParameter("id", x);
			//List<Product> list=query.list();
			session.close();
			return list;
		}

}
